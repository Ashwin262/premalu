import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premalu/User/login/verify_otp.dart';

import '../Home_callPage/HomePage.dart';

class otp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _otp();
  }
}

class _otp extends State<otp> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isAgree = false;
  String countrycode = "+91";
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize _auth
  bool _isLoading = false; // Add a loading state

  void _sendOtp() async {
    String phoneNumber = countrycode + _phoneNumberController.text.trim();

    if (_phoneNumberController.text.isEmpty ||
        _phoneNumberController.text.length != 10) {
      _showErrorDialog("Please enter a valid 10-digit mobile number.");
      return; // Stop further execution if validation fails
    } else if (!_isAgree) {
      _showErrorDialog("Please agree to the terms and conditions.");
      return;
    }

    setState(() {
      _isLoading = true; // Set loading to true when sending OTP
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // AUTO-RETRIEVAL (Android only, sometimes iOS)
          setState(() {
            _isLoading = false; // Set loading to false on completion
          });
          await _auth.signInWithCredential(credential);

          if (mounted) {
            // Add a mounted check before navigating
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false; // Set loading to false on failure
          });
          _showErrorDialog("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isLoading = false; // Set loading to false when code is sent
          });
          // Navigate to the OTP verification screen and pass the verificationId AND the phone number
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyOTP(
                    verificationId: verificationId,
                    phoneNumber: phoneNumber), //Pass phone number here
              ),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isLoading = false; // Set loading to false on timeout
          });
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      setState(() {
        _isLoading = false; // Set loading to false if there's an error
      });
      _showErrorDialog(
          "Failed to send OTP. Please try again later. ${e.toString()}");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: -28,
            top: -148,
            child: Opacity(
              opacity: 0.65,
              child: Container(
                width: 445,
                height: 434,
                decoration: const ShapeDecoration(
                  color: Color(0xFFF21B1B),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ),
          // Left Image positioned at the top-left
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              "assets/images/OTP_page_Image/Ellipse 68 (1).png",
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/images/OTP_page_Image/Ellipse 68.png",
              width: 100,
              height: 100,
            ),
          ),
          // Wrap the content in a Padding widget to remove the right gap
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            // Set right padding to 0
            child: Container(
              width: MediaQuery.of(context).size.width,
              // Use screen width
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: 400,
                    height: 200,
                    // Adjusted height
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/OTP_page_Image/premium_photo-1723651367108-abf5f94c0fa7-removebg-preview 1.png",
                              ),
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                Color.fromRGBO(242, 27, 27, 0.5),
                                BlendMode.srcATop,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 110, bottom: 40.0),
                    // Removed GestureDetector and onTap
                    child: const Text(
                      'Enter Your Mobile Number',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEC271C),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: const Text('+91', style: TextStyle(fontSize: 20)),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneNumberController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Mobile number',
                              contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                              counterText: "",
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            value: _isAgree,
                            onChanged: (bool? checkedvalue) {
                              setState(() {
                                _isAgree = checkedvalue!;
                              });
                            },
                            checkColor: Colors.red,
                            fillColor: MaterialStateProperty.all<Color>(Colors.white),
                            activeColor: Colors.green,
                            side: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'I agree to the Terms & condition and Privacy policy',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Color(0xFFEC271C)),
                      foregroundColor: const MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      textStyle: const MaterialStatePropertyAll<TextStyle>(
                        TextStyle(fontSize: 17),
                      ),
                    ),
                    onPressed: () async {
                      _sendOtp();
                    },
                    child: _isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : const Text("Send OTP"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}