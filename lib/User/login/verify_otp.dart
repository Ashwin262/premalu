import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Home_callPage/HomePage.dart';
import '../Menu/My_profile.dart';

class VerifyOTP extends StatefulWidget {
  final String verificationId;
  final String phoneNumber; // Receive phone number
  const VerifyOTP({Key? key, required this.verificationId, required this.phoneNumber}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _verify_otp();
  }
}

class _verify_otp extends State<VerifyOTP> {
  final List<TextEditingController> _otpVerify =
  List.generate(6, (index) => TextEditingController());
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
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: const Color(0xFFEC271C),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130, bottom: 35),
                child: const Text(
                  'Verify OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 16), // Add horizontal margin
                height: 400,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9EAEE),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
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
                          'OTP has been sent to ${widget.phoneNumber}', //display phone number
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 6; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3.0),
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
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 70, bottom: 37),
                          child: InkWell(
                            onTap: () {
                              _resendOTP(context);
                            },
                            child: const Text(
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
                          const MaterialStatePropertyAll(Color(0xFFEC271C)),
                          foregroundColor:
                          const MaterialStatePropertyAll(Colors.white),
                          shape:
                          MaterialStatePropertyAll<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          _otp = _otpVerify
                              .map((controller) => controller.text)
                              .join();
                          try {
                            PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: _otp,
                            );
                            await _auth.signInWithCredential(credential);

                            if (mounted) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyProfile()));
                            }
                          } catch (e) {
                            setState(() {
                              _isLoading = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Invalid OTP")),
                            );

                            print("Error during OTP verification: $e");
                          }
                        },
                        child: const Text('Verify OTP'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Resend OTP
  Future<void> _resendOTP(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          if (mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyProfile()));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Resend failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _isLoading = false;
            // Update the verificationId, important for subsequent verification.
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Resend OTP successful')),
          );

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => VerifyOTP(verificationId: verificationId, phoneNumber: widget.phoneNumber,)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Auto Retrieval TimeOut')),
          );
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resend failed: ${e.toString()}')),
      );
    }
  }

}