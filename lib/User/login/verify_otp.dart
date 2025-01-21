import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premalu/User/login/otp.dart';

import '../Home_callPage/HomePage.dart';


class VerifyOTP  extends StatefulWidget
{

  final String verificationId;
  const VerifyOTP({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _verify_otp();
  }
}

class _verify_otp extends State<VerifyOTP> {

  final List<TextEditingController> _otpVerify = List.generate(6, (index) => TextEditingController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _otp = '';
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEC271C),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  otp()),
              );
            },
          ),
        ),
        backgroundColor: Color(0xFFEC271C),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 130, bottom: 35),
              child: Text(
                'Verify OTP',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),

            // SizedBox(height: 20),
            Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFE9EAEE),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 50, left: 50, bottom: 20),
                      child: Text(
                        'Enter Your 6 Digit Code',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Color(0xFFB3261E),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 55, bottom: 50),
                      child: Text(
                        'OTP has been send you',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                  // SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 6; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0),
                          child: SizedBox(
                            width: 42,
                            height: 40,
                            child: TextField(
                              controller: _otpVerify[i],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFF9D1818),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                counterText: "",
                              ),
                              onChanged: (value) {
                                if (value.length == 1) {
                                  FocusScope.of(context).nextFocus();
                                } else if (value.isEmpty && i > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _isLoading ? // Show loading indicator
                  const CircularProgressIndicator() :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, right: 70, bottom: 37),
                        child: InkWell(  // Make "Resend OTP" tappable for resending
                          onTap: () {
                            // Implement resend OTP logic here.  You'll need to call the Firebase function to resend the OTP to the user's phone number.
                          },
                          child: const Text( // Use const for Text widget
                            'Resend OTP',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Color(0xFFB3261E),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xFFEC271C)),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true; // Start loading indicator
                          });

                          _otp = _otpVerify.map((controller) => controller.text).join();
                          try {
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: _otp,
                            );
                            await _auth.signInWithCredential(credential);


                            // Navigate to home page on successful verification
                            if (mounted) { // Check if the widget is still mounted
                              Navigator.pushReplacement(  // Use pushReplacement to prevent going back to OTP screen
                                context,
                                MaterialPageRoute(builder: (context) =>  HomePage()),
                              );
                            }
                          } catch (e) {
                            // Handle error, e.g., incorrect OTP
                            setState(() {
                              _isLoading = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Invalid OTP")), // Show error message to the user
                            );

                            print("Error during OTP verification: $e");
                          }
                        },
                        child: Text('Verify OTP')
                    ),
                  ),
                  // Add your OTP input fields and other widgets here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
