import 'package:flutter/material.dart';

class userNameField extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _userNameField();
  }

}

class _userNameField extends State<userNameField>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: 61,
              top: 0,
              child: Container(
                width: 258,
                height: 258,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/OTP_page_Image/premium_photo-1723651367108-abf5f94c0fa7-removebg-preview 1.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
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

          ],
        ),
      ),
    );
  }

}