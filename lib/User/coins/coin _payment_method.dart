import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CoinPaymentMethod extends StatefulWidget {
  final String? limitedOfferId;
  final String? specialOfferId;
  final String? callWithTimingId;

  CoinPaymentMethod({Key? key, this.limitedOfferId, this.specialOfferId, this.callWithTimingId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CoinPaymentMethodState();
  }
}

class _CoinPaymentMethodState extends State<CoinPaymentMethod> {
  String? totalCoins;
  String? payableAmount;
  bool isLoading = true;
  String? userId;
  String? userName;
  String? userEmail;
  String? userContact;
  String? offerType;
  int? days;
  int? minutes;
  String? price;

  Razorpay razorpay = Razorpay();


  final String razorpayKeyId = "rzp_test_H5ip9FXOQ0uLte";
  final String razorpayKeySecret = "YOUR_RAZORPAY_KEY_SECRET";
  final String appName = "Premalu";

  @override
  void initState() {
    super.initState();
    fetchData();
    _loadUserData();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }


  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      userId = user.uid;
      print('User ID: $userId');

      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('userdata')
            .where('firebaseUserId', isEqualTo: userId)
            .get();


        if (querySnapshot.docs.isNotEmpty) {
          print('User document exists!');
          // Assuming only ONE document matches the UID.  If there could be multiple,
          // adjust accordingly (e.g., loop through querySnapshot.docs).
          DocumentSnapshot userDoc = querySnapshot.docs.first;
          Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

          userName = userData?['name']?.toString() ?? 'N/A';
          userEmail = userData?['email']?.toString() ?? 'N/A';
          userContact = user.phoneNumber ?? 'N/A';

          print('User Name: $userName');
          print('User Email: $userEmail');
          print('User Contact: $userContact');

        } else {
          print('User document DOES NOT EXIST!');
          userName = 'N/A';
          userEmail = 'N/A';
          userContact = 'N/A';
          print('User document does not exist for user ID: $userId');
        }
      } catch (e) {
        print('Error fetching user data: $e');
        userName = 'N/A';
        userEmail = 'N/A';
        userContact = 'N/A';

      }
    } else {
      print('No user logged in!');
      userId = null;
      userName = null;
      userEmail = null;
      userContact = null;
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (widget.limitedOfferId != null || widget.specialOfferId != null || widget.callWithTimingId != null) {
        String? offerId = widget.limitedOfferId ?? widget.specialOfferId ?? widget.callWithTimingId;
        String collectionName;
        if (widget.limitedOfferId != null) {
          collectionName = 'LimitedOffer_Coins';
          offerType = 'LimitedOffer';
        } else if (widget.specialOfferId != null) {
          collectionName = 'specialOffer_coins';
          offerType = 'SpecialOffer';
        } else {
          collectionName = 'callWithTiming';
          offerType = 'CallWithTiming';
        }

        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(offerId)
            .get();

        if (documentSnapshot.exists) {
          Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

          setState(() {
            totalCoins = data?['coins']?.toString() ?? data?['discountPrice']?.toString();
            payableAmount = data?['price']?.toString();
            days = data?['days'] as int?;
            minutes = data?['minutes'] as int?;
            price = data?['price']?.toString();
            isLoading = false;
          });
        } else {
          print('Document does not exist in $collectionName with id $offerId');
          setState(() {
            isLoading = false;
            totalCoins = null;
            payableAmount = null;
            offerType = null;
            days = null;
            minutes = null;
            price = null;
          });
        }
      } else {
        print('No offer ID provided');
        setState(() {
          isLoading = false;
          totalCoins = null;
          payableAmount = null;
          offerType = null;
          days = null;
          minutes = null;
          price = null;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
        totalCoins = null;
        payableAmount = null;
        offerType = null;
        days = null;
        minutes = null;
        price = null;
      });
    }
  }

  Future<void> _updatePlanDetails(BuildContext context, String userId, int days, int minutes) async {
    try {
      DocumentReference userTotalCoinsRef = FirebaseFirestore.instance
          .collection('userTotalCoins')
          .doc(userId);

      DocumentSnapshot userDoc = await userTotalCoinsRef.get();

      bool planStatus = userDoc.exists && (userDoc.data() as Map<String, dynamic>?)?['planStatus'] == true;

      DateTime now = DateTime.now();
      DateTime planValidityDate;

      if (planStatus && userDoc.exists) {
        String? existingPlanValidityString = (userDoc.data() as Map<String, dynamic>?)?['planValidity'];

        if (existingPlanValidityString != null) {
          try {
            planValidityDate = DateFormat('MMMM d, yyyy PMt hh:mm:ss a UTC+5:30').parse(existingPlanValidityString);
            planValidityDate = planValidityDate.add(Duration(days: days));
          } catch (e) {
            print('Error parsing existing planValidity: $e');
            planValidityDate = now.add(Duration(days: days));
          }
        } else {
          planValidityDate = now.add(Duration(days: days));
        }
      } else {
        planValidityDate = now.add(Duration(days: days));
      }

      String planCreateAtFormatted = DateFormat('MMMM d, yyyy PMt hh:mm:ss a UTC+5:30').format(now);
      String planValidityFormatted = DateFormat('MMMM d, yyyy PMt hh:mm:ss a UTC+5:30').format(planValidityDate);


      await userTotalCoinsRef.set({
        'userId': userId,
        'minutes': minutes,
        'planCreatAt': planCreateAtFormatted,
        'planValidity': planValidityFormatted,
        'planStatus': true,
      }, SetOptions(merge: true));


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plan details successfully updated!')),
      );
    } catch (e) {
      print('Error updating plan details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update plan details. Please try again.')),
      );
    }
  }




  void _openCheckout() {
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Price is not available.')),
      );
      return;
    }

    double amount = double.tryParse(price!) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid price.')),
      );
      return;
    }

    int amountInPaisa = (amount * 100).toInt();

    var options = {
      'key': razorpayKeyId,
      'amount': amountInPaisa,
      'name': appName,
      'description': 'Purchase Coins',
      'prefill': {
        'name': userName ?? 'User',
        'email': userEmail ?? FirebaseAuth.instance.currentUser?.email ?? '',
        'contact': userContact ?? '',
      },
      'theme': {
        'color': '#B3261E'
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error starting Razorpay checkout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to start payment. Please try again.')),
      );
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response){
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    _addCoinsToUser(paymentId: response.paymentId); // Call _addCoinsToUser with paymentId
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future<void> _addCoinsToUser({String? paymentId}) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;
      try {
        if (days != null) {
          await _updatePlanDetails(context, userId, days!, minutes!);
        } else {
          DocumentReference userTotalCoinsRef = FirebaseFirestore.instance
              .collection('userTotalCoins')
              .doc(userId);

          int coinsToAdd = int.tryParse(totalCoins ?? '0') ?? 0;

          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot snapshot = await transaction.get(userTotalCoinsRef);
            int existingCoins = 0;

            if (snapshot.exists) {
              existingCoins = ((snapshot.data() as Map<String, dynamic>)['totalcoins'] as num?)?.toInt() ?? 0;
            }

            int newTotalCoins = existingCoins + coinsToAdd;

            transaction.set(userTotalCoinsRef, {
              'totalcoins': newTotalCoins,
              'userId': userId,
              'lastCoinAddedAt': FieldValue.serverTimestamp(), // Add timestamp
              'paymentId': paymentId, // Store payment ID

            }, SetOptions(merge: true));
          });

          showAlertDialog(context, "Payment Successful", "Successfully added coins to your account! Payment ID: $paymentId"); // Show success message with payment ID



        }
      } catch (e) {
        print('Error adding coins to user: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add coins. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Name: ${userName ?? "N/A"}'),
            Text('User Email: ${userEmail ?? "N/A"}'),
            Text('User Contact: ${userContact ?? "N/A"}'),
            const SizedBox(height: 20),

            if (days == null)
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red[900]!, width: 2),
                    ),
                    child: Table(
                      border:
                      TableBorder.all(color: Colors.red[900]!, width: 2),
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: IntrinsicColumnWidth(),
                      },
                      children: [
                        TableRow(children: [
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.yellow,
                              child: Text(
                                offerType == 'LimitedOffer' || offerType == 'SpecialOffer'
                                    ? 'Total Coin'
                                    : 'Discount Price',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.yellow,
                              child: Text(
                                totalCoins != null
                                    ? '$totalCoins  ${offerType == 'LimitedOffer' || offerType == 'SpecialOffer' ? 'Coins' : 'Rs.'}'
                                    : 'N/A',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.yellow,
                              child: const Text(
                                'Payable amount',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              color: Colors.yellow,
                              child: Text(
                                payableAmount != null ? 'Rs.$payableAmount' : 'N/A',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _openCheckout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB3261E),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            if (days != null)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.brown,
                        width: 3.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Payable amount',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          price != null ? 'Rs.$price' : 'N/A',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _openCheckout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB3261E),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}