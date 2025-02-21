import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premalu/User/Menu/contact_us.dart';
import 'package:premalu/User/Menu/hearers.dart';
import 'package:premalu/User/Menu/recentCalls.dart';
import 'package:premalu/User/coins/coinPage.dart';
import 'package:premalu/User/login/otp.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../Menu/profile.dart';

const String EXECUTIVE_PROFILES_COLLECTION = 'ExecutiveProfiles';
const String PROFILE_IMAGES_PATH = 'profile_images';
const Color PRIMARY_COLOR = Color(0xFFF21B1B);
const String DEFAULT_PROFILE_IMAGE = "assets/images/logo/Group 153.png";

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  final _scrollController = ScrollController();
  final _refreshThreshold = 100.0;
  final _streamController = BehaviorSubject<QuerySnapshot>();
  late Stream<QuerySnapshot> _debouncedStream;
  bool _isScrollingDown = false;
  double _previousScrollPosition = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userID = '';
  String userName = '';
  int appID = 840437617;
  String appSign =
      'bc49613e29dc350e493c51a541774eb5cc9bdda049f21985e9c128ea52d8c0bf';

  int _userCoins = 0; // Store user's coin balance
  final int _coinsPerMinute = 100; // Cost per minute of call

  String _planStatus = 'Inactive'; // Store user's plan status
  DateTime? _planValidity; // Store user's plan validity

  @override
  void initState() {
    super.initState();
    _debouncedStream = _streamController.stream
        .debounceTime(const Duration(milliseconds: 200));
    _scrollController.addListener(_onScroll);
    _fetchData();
    _loadCurrentUser(); // Load current user info and initialize Zego
  }

  // Load current user info and initialize Zego
  Future<void> _loadCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          userID = user.uid;
        });
        await _fetchUserNameFromFirestore();
        await _initializeZegoCloud();
        await _fetchUserData(); // Load user data including coins, plan info
      } else {
        // Handle the case where there's no logged-in user.  Maybe navigate to login?
        print("No user currently logged in.");
        // Consider navigating to login page here
      }
    } catch (e) {
      print("Error loading current user: $e");
      // Optionally, show an error message to the user.
    }
  }

  // Fetch the user's name from Firestore based on firebaseUserId
  Future<void> _fetchUserNameFromFirestore() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userdata') // Replace 'users' with your collection name
          .where('firebaseUserId', isEqualTo: userID) // Match firebaseUserId with current user's ID
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming only one document matches the firebaseUserId
        final userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          userName = userData['name'] ?? 'User'; // Get the name from the document, default to 'User'
        });
      } else {
        print('No user data found for firebaseUserId: $userID');
        userName = 'User'; // Default name if no user data is found
      }
    } catch (e) {
      print('Error fetching user name: $e');
      userName = 'User'; // Default name in case of error
    }
  }

  // Combined function to fetch all user data (coins, minutes, plan info)
  Future<void> _fetchUserData() async {
    try {
      final DocumentSnapshot userDocSnapshot = await FirebaseFirestore.instance
          .collection('userTotalCoins') // Collection name
          .doc(userID) // Document ID
          .get();

      if (userDocSnapshot.exists) {
        final data = userDocSnapshot.data() as Map<String, dynamic>?;

        setState(() {
          _userCoins = data?['totalcoins'] as int? ?? 0;
          _planStatus = (data?['planStatus'] as bool? ?? false) ? 'Active' : 'Inactive'; // Firestore stores boolean, not string

          // Convert Firestore Timestamp to DateTime
          final timestamp = data?['planValidity'];
          if (timestamp is Timestamp) {
            _planValidity = timestamp.toDate();
          } else {
            _planValidity = null;
          }
        });
      } else {
        print("User data document not found for user ID: $userID");
        _setDefaultValues();
      }
    } catch (e) {
      print("Error fetching user data: $e");
      _setDefaultValues();
    }
  }

  void _setDefaultValues() {
    setState(() {
      _userCoins = 0;
      _planStatus = 'Inactive'; // Default false for boolean
      _planValidity = null;

    });
  }


  //Initialize Zego Cloud
  Future<void> _initializeZegoCloud() async {
    try {
      // Initialize the PrebuiltCallInvitationService
      ZegoUIKitPrebuiltCallInvitationService().init(
        appID: appID,
        appSign: appSign,
        userID: userID,
        userName: userName,
        plugins: [ZegoUIKitSignalingPlugin()],
      );
      print("ZegoCloud initialized successfully.");
    } catch (e) {
      print("Error initializing ZegoCloud: $e");
      // Consider showing an error message to the user, or taking other appropriate action.
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _streamController.close();
    _uninitializeZegoCloud(); // Uninit on dispose
    super.dispose();
  }

  //Uninitialize ZegoCloud
  Future<void> _uninitializeZegoCloud() async {
    try {
      ZegoUIKitPrebuiltCallInvitationService().uninit(); // Uninit on dispose
      print("ZegoCloud uninitialized successfully.");
    } catch (e) {
      print("Error uninitializing ZegoCloud: $e");
    }
  }

  void _fetchData() {
    FirebaseFirestore.instance
        .collection(EXECUTIVE_PROFILES_COLLECTION)
        .snapshots()
        .listen((snapshot) {
      _streamController.add(snapshot);
    });
  }

  Future<void> _onRefresh() async {
    _fetchData();
    await _fetchUserData(); // Refresh all user data on pull-to-refresh.
    await _fetchUserNameFromFirestore(); // Refresh username on pull-to-refresh
  }

  void _onScroll() {
    final currentScrollPosition = _scrollController.position.pixels;
    final scrollDelta = currentScrollPosition - _previousScrollPosition;

    if (scrollDelta > 0) {
      if (currentScrollPosition > _refreshThreshold && !_isScrollingDown) {
        _isScrollingDown = true;
        _onRefresh();
      }
    } else {
      _isScrollingDown = false;
    }

    _previousScrollPosition = currentScrollPosition;
  }

  //Logout function with Uninitialize ZegoCloud
  Future<void> _logout() async {
    try {
      await _uninitializeZegoCloud(); // Ensure Zego is uninitialized.
      await _auth.signOut();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => otp()),
        );
      }
    } catch (e) {
      print('Error during logout: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to logout')),
      );
    }
  }

  void _showSideMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Home'),
                          onTap: () {
                            Navigator.pop(context);
                            print('Navigate to Home');
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: const Text('Call Logs'),
                          onTap: () {
                            Navigator.pop(context); // Close the dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecentCalls()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: const Text('Coins'),
                          onTap: () {
                            Navigator.pop(context); // Close the dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CoinPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.hearing),
                          title: const Text('Hearers'),
                          onTap: () {
                            Navigator.pop(context); // Close the dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => hearers()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () {
                            Navigator.pop(context); // Close the dialog
                            _logout();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Profile'),
                          onTap: () {
                            Navigator.pop(context); // Close the dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.contact_mail),
                          title: const Text('Contact Us'),
                          onTap: () {
                            Navigator.pop(context); // Close the dialog
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactUs()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView( // Added SingleChildScrollView
        child: Container(
          height: screenHeight,
          width: screenWidth,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: PRIMARY_COLOR),
          child: Stack(
            children: [
              Positioned(
                top: screenHeight * 0.14,
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: screenHeight * 0.08,
                child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _showSideMenu(context),
                ),
              ),
              Positioned(
                right: 15,
                top: screenHeight * 0.08,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CoinPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,  // Remove the fixed width.  Let the content determine the size
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1ADF51),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1),
                    ),
                    child: Padding( // Add Padding around the Row
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),  // Add horizontal padding
                      child: Row(
                        mainAxisSize: MainAxisSize.min,  // Important:  Make the Row size to fit the content
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/coins/single.webp',
                            width: 30,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Add Coin',
                            style: TextStyle(
                              color: const Color(0xFF9C1717),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: screenHeight * 0.16,
                child: Container(
                  width: screenWidth - 52,
                  height: screenHeight * 0.13,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B5BC4),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 9,
                        top: 7.43,
                        child: Container(
                          width: screenWidth - 70,
                          height: screenHeight * 0.11,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F3F3),
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 117,
                        top: 14.43,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Hello ${userName}',
                                style: TextStyle(
                                  color: Color(0xFFE00808),
                                  fontSize: 16,
                                  fontFamily: 'Courgette',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 111,
                        top: 42.43,
                        child: const Text(
                          'Welcome to Premalu Application',
                          style: TextStyle(
                            color: Color(0xFF0B5BC4),
                            fontSize: 15,
                            fontFamily: 'Kelly Slab',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 108,
                        top: 68.43,
                        child: const Text(
                          'Find your Emotional Soulmate',
                          style: TextStyle(
                            color: Color(0xFF9C1717),
                            fontSize: 15,
                            fontFamily: 'Leckerli One',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 23.88,
                        top: 14.14,
                        child: Container(
                          width: 66.89,
                          height: 75.30,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/logo/Screenshot_2024-08-31-15-42-47-460_com.google.android.googlequicksearchbox-removebg-preview 1 (3).png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 21,
                top: screenHeight * 0.3,
                right: 21, // Add right positioning to constrain the Row's width
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed to spaceBetween
                  children: [
                    const Text(
                      'Our Specialist',
                      style: TextStyle(
                        color: Color(0xFFE21F1F),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 10), // Add some spacing between the text and the image
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container( // Moved Container here
                          width: 120,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start, // Change to MainAxisAlignment.start
                            children: [
                              Image.asset(
                                'assets/images/coins/single.webp',
                                width: 27, // smaller coin image
                                height: 27,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '$_userCoins', // Display user's coin balance
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Positioned(
                left: 10,
                top: screenHeight * 0.30,
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: SizedBox(
                    width: screenWidth - 20,
                    height: screenHeight * 0.70,
                    child: _buildExecutiveList(),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.4,
                top: screenHeight * 0.06,
                child: Container(
                  width: 50,
                  height: 60,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo/Group 153.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExecutiveList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _debouncedStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No executive profiles found.'));
        }
        return ListView.builder(
          controller: _scrollController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            return _buildExecutiveCard(doc);
          },
        );
      },
    );
  }

  Widget _buildExecutiveCard(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final executiveUserId = doc.id;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FutureBuilder<String>(
        future: _getProfileImageUrl(executiveUserId),
        builder: (context, imageSnapshot) {
          if (imageSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          String imageUrl = DEFAULT_PROFILE_IMAGE; // Provide default
          if (imageSnapshot.hasData && imageSnapshot.data!.isNotEmpty) {
            imageUrl = imageSnapshot.data!;
          }
          return _buildExecutiveCardContent(data, imageUrl, executiveUserId);
        },
      ),
    );
  }

  Widget _buildExecutiveCardContent(
      Map<String, dynamic> data, String imageUrl, String executiveUserId) {
    return Container(
      width: double.infinity, // Use all available width
      height: 106,
      decoration: BoxDecoration(
        color: const Color(0xFFFBFDFD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: const Color(0xFFAC107F),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 9.92,
            child: Container(
              width: 93,
              height: 87,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    print('Error loading image: $exception');
                  },
                ),
              ),
            ),
          ),
          Positioned(
            left: 130,
            top: 6,
            child: Text(
              data['name'] ?? 'N/A',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            left: 130,
            top: 40,
            child: Text(
              '${data['gender'] ?? 'N/A'} - ${data['age'] ?? 'N/A'}\n$_coinsPerMinute Coins/Min', // Added coinsPerMinute
              style: const TextStyle(
                color: Color(0xFF0E23E5),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add padding here
              child: _buildCallButton(executiveUserId, data['name'] ?? 'User'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton(String executiveUserId, String executiveName) {
    final canCallWithCoins = _userCoins >= _coinsPerMinute;

    String tooltipMessage;
    bool absorbing;

    if (!canCallWithCoins) {
      tooltipMessage = "You need coins to make a call";
      absorbing = true;
    }  else {
      tooltipMessage = "Call $executiveName (using coins)";
      absorbing = false;
    }

    return Tooltip(
      message: tooltipMessage,
      child: GestureDetector(
        onTap: () {
          if (!canCallWithCoins) {
            _showInsufficientCoinsDialog(
                "You need coins to make a call");
          }
        },
        child: AbsorbPointer(
          absorbing: absorbing, // Disable interactions if no minutes or coins
          child: ZegoSendCallInvitationButton(
            isVideoCall: false,
            resourceID: "zegouikit_call",
            invitees: [
              ZegoUIKitUser(
                id: executiveUserId,
                name: executiveName,
              ),
            ],
            onPressed: (String code, String message, List<String> invitees) {
              print("Initiating call with $executiveName (ID: $executiveUserId) using coins");
              _deductCoins(_coinsPerMinute, executiveUserId);
            },
          ),
        ),
      ),
    );
  }


  void _showInsufficientCoinsDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: "Insufficient Coins",
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  Future<String> _getProfileImageUrl(String userId) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final listResult =
      await storageRef.child('profile_images/$userId/').listAll();
      if (listResult.items.isNotEmpty) {
        final fileRef = listResult.items.first;
        return await fileRef.getDownloadURL();
      }
      return "";
    } catch (e) {
      print("Error getting image url $e");
      return "";
    }
  }

  // Deduct coins, passing the executiveUserId for potential logging or use
  Future<void> _deductCoins(int amount, String executiveUserId) async {
    try {
      DocumentReference userCoinsRef = FirebaseFirestore.instance.collection('userTotalCoins').doc(userID);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(userCoinsRef);
        if (!snapshot.exists) {
          throw Exception("User coins document does not exist!");
        }

        final data = snapshot.data() as Map<String, dynamic>?;
        int currentCoins = data?['totalcoins'] as int? ?? 0;

        if (currentCoins < amount) {
          throw Exception("Insufficient coins!");
        }

        int newCoins = currentCoins - amount;
        transaction.update(userCoinsRef, {'totalcoins': newCoins});
      });

      await _fetchUserData();
      print("Deducted $amount coins for call with executive ID: $executiveUserId"); // Log the deduction
    } catch (e) {
      print("Error deducting coins: $e");
      _showError("Failed to deduct coins: ${e.toString()}");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}