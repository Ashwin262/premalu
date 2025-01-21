import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactUsState();
  }
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFF21B1B)),
        child: Stack(
          children: [
            Positioned(
              left: 18,
              top: 68,
              child: Image.asset( // Replace with your back button asset
                'assets/back_button.png', // Example path
                width: 42,
                height: 24,
              ),
              // You were using FlutterLogo here which isn't appropriate for a back button
            ),


            Positioned(
              left: 84,
              top: 68,
              child: const Text(
                'Contact Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 17,
              top: 118,
              child: Container(
                width: 355,
                height: 533,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 33,
              top: 153,
              child: Container(
                width: 322,
                height: 41,
                decoration: const ShapeDecoration(
                  color: Color(0xFFF21B1B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 150,
              top: 161,
              child: const Text(
                'Contact Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 33,
              top: 194,
              child: Container(
                width: 322,
                height: 191,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFF9C1717)),
                  ),
                ),
              ),
            ),


            Positioned( // Replace FlutterLogo with appropriate icons
              left: 45, // Adjusted position for better alignment
              top: 290,  // Adjusted position
              child: const Icon(Icons.email, size: 30, color: Color(0xFFB3261E)), // Example: Email Icon
            ),
            Positioned(
              left: 45,  // Adjusted position
              top: 335,  // Adjusted position
              child: const Icon(Icons.phone, size: 30, color: Color(0xFFB3261E)), // Example: Phone Icon
            ),

            Positioned(
              left: 39,
              top: 204,
              child: SizedBox(
                width: 310,
                child: const Text(
                  'You can contact us if you feel any issues upon\naccessing the Premalu app,using its services,\nor facing any issues while making the payment.\nOur team is always there to help you ',
                  style: TextStyle(
                    color: Color(0xFFB3261E),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
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