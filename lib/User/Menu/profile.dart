import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFF21B1B)),
        child: Stack(
          children: [
            Positioned(
              left: 70, // Added margin
              top: 68,
              child: Text(
                'Profile',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 135,
              right: 0,
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
                left: 20,
                top: 158,
                child: Container(
                  width: 104,
                  height: 126,
                  decoration: const ShapeDecoration(shape: OvalBorder()),
                )),
            Positioned(
                left: 20,
                right: 20,
                top: 317,
                child: Container(
                  height: 52,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6EE18),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )),
            Positioned(
                left: 20,
                right: 20,
                top: 380,
                child: Container(
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6EE18),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )),
            Positioned(
              left: 20,
              right: 20,
              top: 498,
              child: Container(
                height: 43,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6EE18),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Positioned(
                left: 20,
                right: 20,
                top: 439,
                child: Container(
                  height: 48,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF6EE18),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )),
            Positioned(
              left: 41,
              top: 326,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'My Profile\n',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Edit Your Profile',
                      style: const TextStyle(
                        color: Color(0xFF9C1717),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 41,
              top: 395,
              child: const Text(
                'Terms & Conditions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 41,
              top: 454,
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 41,
              top: 510,
              child: const Text(
                'Career',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
                left: 332,
                top: 332,
                child: Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(5),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                )),
            Positioned(
              left: 332,
              top: 395,
              child: Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
              ),
            ),
            Positioned(
              left: 332,
              top: 451,
              child: Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
              ),
            ),
            Positioned(
              left: 332,
              top: 507,
              child: Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
              ),
            ),
            Positioned(
              left: 15,
              top: 60,
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 13.33,
                  right: 14.33,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x3F000000),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 132,
              top: 158,
              child: Container(
                width: 127,
                height: 116,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 127,
                        height: 116,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF21B1B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 32,
                      top: 18,
                      child: Container(
                        width: 62.79,
                        height: 78,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: SizedBox(
                                width: 90,
                                height: 89,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0.15,
                                      top: 0,
                                      child: SizedBox(
                                        width: 65,
                                        height: 76,
                                        child: Image.asset(
                                          "assets/images/logo/Group 153.png",
                                          fit: BoxFit.fill,
                                        ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
