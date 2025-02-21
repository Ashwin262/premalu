import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:premalu/User/coins/coin%20_payment_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  final List<Color> boxColors = [
    const Color(0xFFF78C8C),
    const Color(0xE21FD6FF),
    const Color(0xFF9C1717),
    const Color(0xFFC9E809),
  ];

  final List<Color> coinColors = [
    const Color(0xFFE21F1F),
    const Color(0xFF0E23E5),
    const Color(0xFFF21B1B),
    const Color(0xFF18BD5A),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFF21B1B)),
        child: Stack(
          children: [
            // Background Circle
            Positioned(
              right: -50,
              top: 300,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFFE03A3A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // White Background Container
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Premalu',
                                  style: TextStyle(
                                    color: Color(0xFFF21B1B),
                                    fontSize: 24,
                                    fontFamily: 'Miltonian Tattoo',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  'Limited Offer',
                                  style: TextStyle(
                                    color: Color(0xFFB3261E),
                                    fontSize: 32,
                                    fontFamily: 'Oleo Script',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "10,000 coins - 1 min ",
                                    style: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildCoinOffers(context), // Pass context here
                      const SizedBox(height: 20),
                      const Text(
                        'Special Offer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF9C1717),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildPackageOffers(context),
                      // Add this line
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Coin ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Navigate back on tap
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoinOffers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: StreamBuilder<QuerySnapshot>(
        stream:
        FirebaseFirestore.instance.collection('LimitedOffer_Coins').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: snapshot.data!.docs.asMap().entries.map((entry) {
              int index = entry.key;
              DocumentSnapshot document = entry.value;
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;

              // Use colors cyclically
              Color boxColor = boxColors[index % boxColors.length];
              Color coinColor = coinColors[index % coinColors.length];

              return _buildCoinItem(
                context: context,
                amount: '${data['coins']} Coins',
                discountedPrice: '${data['discountedPrice']}',
                price: '${data['price']}',
                assetImage: "assets/images/coins/coin.png",
                color: boxColor,
                coinColor: coinColor,
                limitedOfferId: document.id, // ID from LimitedOffer_Coins
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildPackageOffers(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPackageItem(
            context: context,
            backgroundColor: const Color(0xFFE57373),
            showImages: true,
            coinDataStream: FirebaseFirestore.instance
                .collection('specialOffer_coins')
                .snapshots(), // Pass the stream here, CORRECTED COLLECTION NAME
          ),
          _buildPackageItem(
            context: context,
            backgroundColor: const Color(0xFF81D4FA),
            showImages: false,
            coinDataStream: FirebaseFirestore.instance
                .collection('callWithTiming')
                .snapshots(),
          ),
        ],
      ),
    );
  }

  // Widget for building coin item
  Widget _buildCoinItem({
    required BuildContext context,
    required String amount,
    required String discountedPrice,
    required String price,
    required Color color,
    required Color coinColor,
    String? assetImage,
    String? limitedOfferId, // ADDED
  }) {
    return GestureDetector(
      onTap: () {
        // Show payment options dialog when the container is tapped
        showPaymentDialog(context, limitedOfferId: limitedOfferId, specialOfferId: null, callWithTimingId: null); // Limited offer ID is first
      },
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Container
          Container(
            width: 82,
            height: 125,
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 3, color: Colors.white),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image with Gold Shadow or CircleAvatar
                SizedBox(
                  width: 50,
                  height: 50,
                  child: assetImage != null
                      ? _buildImageWithGoldShadow(assetImage)
                      : CircleAvatar(backgroundColor: coinColor),
                ),
                // Amount Container (Green Background with Text)
                _buildAmountContainer(amount, textColor: Colors.blue),
                // Prices
                SizedBox(
                  height: 30,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: '₹',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: ' $price  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                            decorationThickness: 2.5,
                          ),
                        ),
                        const TextSpan(
                          text: '₹',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: ' $discountedPrice  ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build the image with gold shadow
  Widget _buildImageWithGoldShadow(String assetImage) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.shade800.withOpacity(0.7),
            spreadRadius: 0.5,
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          assetImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
    );
  }

  // Helper widget to build the amount container
  Widget _buildAmountContainer(String amount, {Color textColor = Colors.white}) {
    return Container(
      width: 73,
      height: 18,
      decoration: ShapeDecoration(
        color: const Color(0xFFE8A3A3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Center(
        child: Text(
          amount,
          style: TextStyle(
            color: textColor,
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Widget for building package item
  Widget _buildPackageItem({
    required BuildContext context,
    required Color backgroundColor,
    required bool showImages,
    Stream<QuerySnapshot>? coinDataStream, // Added optional parameter
  }) {
    return Container(
        width: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: (showImages) // Left box
            ? Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/coins/coinsIn.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/coins/72%.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Use StreamBuilder to fetch and display data
            if (coinDataStream != null)
              StreamBuilder<QuerySnapshot>(
                stream: coinDataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading indicator while waiting
                  }

                  // Data is available, extract and display it
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return Column(
                      children: snapshot.data!.docs.map((document) {
                        Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                        String coins = data['coins'].toString();
                        String price = data['price'].toString();
                        String discountedPrice = data['discountPrice'].toString(); // Corrected name
                        String specialOfferId = document.id.toString(); // Special Offer Id

                        return InkWell(
                          onTap: () {
                            showPaymentDialog(context, limitedOfferId: null, specialOfferId: specialOfferId,callWithTimingId: null ); // Special offer id as the second parameter
                          },
                          child: Container(
                            width: 200,
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.white,
                                width: 3,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 194,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '\₹$discountedPrice \₹$price',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    '$coins coins',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return const Text("No data available.");
                  }
                },
              ),
          ],
        )
            : StreamBuilder<QuerySnapshot>(
          stream: coinDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator while waiting
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Text("No data available.");
            }

            //Extract the document list
            List<DocumentSnapshot> documents = snapshot.data!.docs;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: documents.map((document) {
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                String days = data['days'].toString();
                String minutes = data['minutes'].toString();
                String discountedPrice = data['discountPrice'].toString();
                String price = data['price'].toString();
                String callWithTimingId = document.id.toString();

                return InkWell( // Wrap the column with InkWell
                  onTap: () { // Add the onTap event
                    showPaymentDialog(context, limitedOfferId: null, specialOfferId: null, callWithTimingId: callWithTimingId); // open the dialog here and pass the callWithTimingId
                  },
                  child: Column(
                    children: [
                      // First Set of Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Align items vertically in the center
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(top: 5),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$days days',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          '$minutes min/per day',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          //discount price
                          '\₹$discountedPrice '
                          //price
                              '\₹$price',

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ));
  }

  void showPaymentDialog(BuildContext context, {String? limitedOfferId, String? specialOfferId, String? callWithTimingId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Payment Method",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CoinPaymentMethod(
                          limitedOfferId: limitedOfferId,
                          specialOfferId: specialOfferId,
                          callWithTimingId: callWithTimingId,
                        )),
                  );

                  print("Razorpay (Domestic) Selected");
                  if (limitedOfferId != null) {
                    print("Limited Offer Document Id: $limitedOfferId");
                  }
                  if (specialOfferId != null) {
                    print("Special Offer Document Id: $specialOfferId");
                  }
                  if(callWithTimingId != null){
                    print("Call With Timing Document Id : $callWithTimingId");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB3261E),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                ),
                child: const Text("Razorpay (Domestic)",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}