import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:premalu/User/Home_callPage/HomePage.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); // Added Email Controller
  int _userNumberId = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _emailController.dispose(); // Dispose Email Controller
    super.dispose();
  }


  Future<int?> _generateNumericUserId() async {
    try {
      final counterRef =
      FirebaseFirestore.instance.collection('counters').doc('userCounter');

      return await FirebaseFirestore.instance.runTransaction<int>((transaction) async {
        final counterSnapshot = await transaction.get(counterRef);
        int newCount;
        if (!counterSnapshot.exists) {
          newCount = 1000;
          transaction.set(counterRef, {'count': newCount});
        } else {
          newCount = (counterSnapshot.data()?['count'] ?? 999) + 1;
          transaction.update(counterRef, {'count': newCount});
        }
        return newCount;
      });
    } catch (e) {
      _showErrorDialog('Failed to generate user ID: $e');
      return null;
    }
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorDialog('User not logged in');
        return;
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('userdata')
          .where('firebaseUserId', isEqualTo: user.uid)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Retrieve the first document
        DocumentSnapshot document = querySnapshot.docs.first;
        var userData = document.data() as Map<String, dynamic>;

        _userNumberId = userData['userId'] ?? 0;
        _nameController.text = userData['name'] ?? '';
        _ageController.text = (userData['age'] ?? '').toString();
        _stateController.text = userData['state'] ?? '';
        _countryController.text = userData['country'] ?? '';
        _emailController.text = userData['email'] ?? ''; // Load Email

      } else {
        print("No user data found for this user.");
        _userNumberId = 0;
      }
    } catch (e) {
      _showErrorDialog('Failed to load user data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          _showErrorDialog('User not logged in');
          return;
        }

        final data = {
          'name': _nameController.text,
          'age': int.parse(_ageController.text),
          'state': _stateController.text,
          'country': _countryController.text,
          'email': _emailController.text, //Save Email
          'firebaseUserId': user.uid,
        };

        if (_userNumberId != 0) {
          // User ID exists, update the existing document based on userId

          QuerySnapshot existingUserSnapshot = await FirebaseFirestore.instance
              .collection('userdata')
              .where('userId', isEqualTo: _userNumberId)
              .get();

          if (existingUserSnapshot.docs.isNotEmpty) {
            String docIdToUpdate = existingUserSnapshot.docs.first.id;
            await FirebaseFirestore.instance
                .collection('userdata')
                .doc(docIdToUpdate)
                .update(data);

          } else {
            //Should ideally never happen, but handle case where userId exists
            //but document is not found
            _showErrorDialog("Inconsistent State: User ID found but no document.  Please contact support.");
            return;

          }
        } else {
          // User ID doesn't exist, create a new document and generate a new userId
          int? userId = await _generateNumericUserId();
          if (userId == null) {
            return;
          }
          data['userId'] = userId;
          _userNumberId = userId; // update userId with newly generated id
          await FirebaseFirestore.instance.collection('userdata').add(data);
        }

        _showSuccessDialog();
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        });
        _loadUserData(); // Reload data after saving
      } catch (e) {
        _showNetworkErrorDialog();
        print('Error saving data: $e');
      }
    }
  }

  void _showSuccessDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: "Saved",
      desc: "Profile Updated ",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    ).show();
  }

  void _showNetworkErrorDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: "Network Error",
      desc: "Profile not Updated. Please check your internet connection",
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  void _showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: "Error",
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFF21B1B)),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 61,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              left: 80,
              top: 68,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  child: Text(
                    'My Profile',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 118,
              bottom: 0,
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 45,
              right: 0,
              top: 153,
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Data are  highly protected with \nPremalu',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFFF21B1B),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 225,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.76,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Name',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFF21B1B),
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.50,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 281,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.84,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _ageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Age',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFF21B1B),
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your age';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number for age';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 337,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.80,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFF21B1B),
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 45,
              right: 0,
              top: 393,
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Select Your State',
                  style: TextStyle(
                    color: Color(0xFFB3261E),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 428,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.54,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                                controller: _stateController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'State',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFF21B1B),
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your state';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 484,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.80,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                                controller: _countryController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Country',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFF21B1B),
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your country';
                                  }
                                  return null;
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: 548,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 241,
                  height: 44,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 3,
                        top: 26,
                        child: const Text(
                          'and Privacy Policy',
                          style: TextStyle(
                            color: Color(0xFFB3261E),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: const Text(
                          'I agree to the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 95,
                        top: 0,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: const TextStyle(
                                  color: Color(0xFF9C1717),
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 600,
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: const Color(0xFFF21B1B),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1, color: Color(0xFFF6EE18)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadowColor: const Color(0x3F000000),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 21,
              top: 61,
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 13.33,
                  right: 14.33,
                  bottom: 10,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
              ),
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}