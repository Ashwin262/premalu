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


  void _sendOtp() async {
    String phoneNumber = countrycode + _phoneNumberController.text.trim();


    if (_phoneNumberController.text.isEmpty || _phoneNumberController.text.length != 10) {
      _showErrorDialog("Please enter a valid 10-digit mobile number.");
      return; // Stop further execution if validation fails
    } else if (!_isAgree) {
      _showErrorDialog("Please agree to the terms and conditions.");
      return;
    }



    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        verificationCompleted: (PhoneAuthCredential credential) async {
          // AUTO-RETRIEVAL (Android only, sometimes iOS)
          await _auth.signInWithCredential(credential);

          if (mounted) { // Add a mounted check before navigating
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  HomePage()),
            );
          }
        },

        verificationFailed: (FirebaseAuthException e) {
          _showErrorDialog("Verification failed: ${e.message}");

        },

        codeSent: (String verificationId, int? resendToken) {
          // Navigate to the OTP verification screen and pass the verificationId
          if(mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerifyOTP(verificationId: verificationId),
              ),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {

      _showErrorDialog("Failed to send OTP. Please try again later. ${e.toString()}");
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                      'assets/images/OTP_page_Image/Ellipse 68 (1).png'),

                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Image(
                    image: AssetImage(
                        'assets/images/OTP_page_Image/premium_photo-1723651367108-abf5f94c0fa7-removebg-preview 1.png'),
                    width: 170,
                    height: 170,
                  ),
                ),
                Image(
                  image: AssetImage(
                      'assets/images/OTP_page_Image/Ellipse 68.png'),

                ),
              ],
            ),

            // Padding(
            //   padding:
            //   const EdgeInsets.only(top: 100),
            //   child: Text(
            //     'Enter Your Mobile Number',
            //     style: TextStyle(
            //         fontSize: 25,
            //         fontWeight: FontWeight.bold,
            //         color: const Color(0xFFEC271C)),
            //   ),
            // ),


          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: GestureDetector(
              onTap: () {
                // Navigate to the desired screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(), // Replace with your screen
                  ),
                );
                // Or, for named routes:
                // Navigator.pushNamed(context, '/yourRouteName');
              },
              child: Text(
                'Enter Your Mobile Number',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFEC271C),
                  decoration: TextDecoration.underline, // Optional: add underline to indicate navigability
                ),
              ),
            ),
          ),

            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, left: 40.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('+91', style: TextStyle(fontSize: 20)),
                    ),
                    SizedBox(
                      width: 242,
                      child: TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Mobile number',

                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.0),
                          prefixText: "+91 ",
                        ),

                        keyboardType: TextInputType.number,
                        maxLength: 10,

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, top: 30),
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
                      side: BorderSide(
                        color: Colors.red, //
                        width: 1,
                      ),

                    ),
                  ),
                  Text(
                    'I agree to the Terms & condition and \n Privacy policy',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                          WidgetStatePropertyAll(Color(0xFFEC271C)),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          textStyle: MaterialStatePropertyAll<TextStyle>(
                              const TextStyle(fontSize: 17))),


                      onPressed: () async {
                        _sendOtp();
                        },
                      child: (Text("Send OTP")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
