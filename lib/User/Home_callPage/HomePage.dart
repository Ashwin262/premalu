import 'package:flutter/material.dart';
import 'package:premalu/User/Menu/My_profile.dart';
import 'package:premalu/User/Menu/contact_us.dart';
import 'package:premalu/User/Menu/hearers.dart';
import 'package:premalu/User/Menu/profile.dart';

import '../Menu/recentCalls.dart';
import '../coins/coinPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 390,
        height: 844,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFFF21B1B)),
        child: Stack(
          children: [
            Positioned(
              left: 144,
              top: 332,
              child: Text(
                'Caller name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 118,
              child: Container(
                width: 390,
                height: 726,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 70.34,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.01),
                child: Container(
                  width: 37,
                  height: 35.28,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.62, vertical: 8.82),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 70.34,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.01),
                child: Container(
                  width: 70,
                  height: 35.28,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.62, vertical: 8.82),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu), // Menu icon
                        onPressed: () {
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6, // 60% width
                                        height: MediaQuery.of(context)
                                            .size
                                            .height, // Full screen height
                                        color: Colors.white, // Background color
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 100.0),
                                          // Add padding at the top
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.home),
                                                title: Text('Home'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  print('Navigate to Home');
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.phone),
                                                title: Text('Call Logs'),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RecentCalls()),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.phone),
                                                title: Text('coin'),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CoinPage()),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.hearing),
                                                title: Text('Hearers'),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            hearers()),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.person),
                                                title: Text('Profile'),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            My_profile()),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading:
                                                    Icon(Icons.contact_mail),
                                                title: Text('Contact Us'),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ContactUs()),
                                                  );
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.arrow_back),
                                                title: Text('Return'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  print('Return action');
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
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 277,
              top: 64,
              child: Container(
                width: 106,
                height: 38,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 103,
                        height: 38,
                        decoration: ShapeDecoration(
                          color: Color(0xFF1ADF51),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 5,
                      child: Container(
                        width: 101,
                        height: 28,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 28.17,
                              top: 6,
                              child: SizedBox(
                                width: 72.83,
                                height: 21,
                                child: Text(
                                  'Add Coin',
                                  style: TextStyle(
                                    color: Color(0xFF9C1717),
                                    fontSize: 15,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 27.17,
                                height: 28,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2.26, vertical: 2.33),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [],
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
            Positioned(
              left: 26,
              top: 137.08,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.01),
                child: Container(
                  width: 336,
                  height: 106,
                  decoration: ShapeDecoration(
                    color: Color(0xFF0B5BC4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    shadows: [
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
                          width: 318,
                          height: 89,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
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
                                text: 'Hello User Id...',
                                style: TextStyle(
                                  color: Color(0xFFE00808),
                                  fontSize: 16,
                                  fontFamily: 'Courgette',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: '.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 111,
                        top: 42.43,
                        child: Text(
                          'Welcome to Callfrnd Application',
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
                        child: Text(
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/67x75"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 235.81,
                        top: 113.09,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(0.01),
                          child: Container(
                            width: 115,
                            height: 30,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..translate(0.0, 0.0)
                                      ..rotateZ(0.01),
                                    child: Container(
                                      width: 112.45,
                                      height: 30,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFFF21B1B)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 34.94,
                                  top: 5.32,
                                  child: SizedBox(
                                    width: 80,
                                    height: 20,
                                    child: Transform(
                                      transform: Matrix4.identity()
                                        ..translate(0.0, 0.0)
                                        ..rotateZ(0.01),
                                      child: Text(
                                        'Coins',
                                        style: TextStyle(
                                          color: Color(0xFFF5F5F5),
                                          fontSize: 15,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
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
              ),
            ),
            Positioned(
              left: 21,
              top: 248,
              child: SizedBox(
                width: 140,
                height: 33,
                child: Text(
                  'Our Specialist',
                  style: TextStyle(
                    color: Color(0xFFE21F1F),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 284,
              child: Container(
                width: 370,
                height: 548,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Color(0xFFA2DBE1)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 370,
                        height: 106,
                        decoration: ShapeDecoration(
                          color: Color(0xFF95E2D7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF0E23E5),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        // image
                        child: Stack(
                          children: [
                            // Positioned(
                            //   left: 15,
                            //   top: 9.92,
                            //   child: Transform(
                            //     transform: Matrix4.identity()
                            //       ..translate(0.0, 0.0)
                            //       ..rotateZ(-0.01),
                            //     child: Container(
                            //       width: 93,
                            //       height: 87,
                            //       decoration: ShapeDecoration(
                            //         image: DecorationImage(
                            //           image: NetworkImage(
                            //               "https://via.placeholder.com/93x87"),
                            //           fit: BoxFit.fill,
                            //         ),
                            //         shape: RoundedRectangleBorder(
                            //           side: BorderSide(
                            //             width: 1,
                            //             color: Colors.black
                            //                 .withOpacity(0.20000000298023224),
                            //           ),
                            //           borderRadius: BorderRadius.circular(12),
                            //         ),
                            //         shadows: [
                            //           BoxShadow(
                            //             color: Color(0x3F000000),
                            //             blurRadius: 4,
                            //             offset: Offset(0, 4),
                            //             spreadRadius: 0,
                            //           )
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   left: 130,
                            //   top: 6,
                            //   child: Text(
                            //     'Executive Name',
                            //     style: TextStyle(
                            //       color: Colors.black,
                            //       fontSize: 16,
                            //       fontFamily: 'Inter',
                            //       fontWeight: FontWeight.w800,
                            //     ),
                            //   ),
                            // ),
                            Positioned(
                              left: 129.82,
                              top: 40.59,
                              child: Text(
                                'Gender-Age\n1000 Coins/1 Min',
                                style: TextStyle(
                                  color: Color(0xFF0E23E5),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 300,
                              top: 18.45,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 49.18,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 3.70,
                                        top: 20.93,
                                        child: Transform(
                                          transform: Matrix4.identity()
                                            ..translate(0.0, 0.0)
                                            ..rotateZ(-0.01),
                                          child: Container(
                                            width: 44,
                                            height: 44,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 44,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF1ADF51)),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 9.09,
                                                  top: 8.92,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 26,
                                                      height: 26,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 2.17,
                                                        left: 2.29,
                                                        right: 2.17,
                                                        bottom: 2.24,
                                                      ),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0.18,
                                        top: -0,
                                        child: Text(
                                          'Online',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                          ),
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
                    ),
                    Positioned(
                      left: 0,
                      top: 115,
                      child: Container(
                        width: 370,
                        height: 106,
                        decoration: ShapeDecoration(
                          color: Color(0xFF95E2D7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF0E23E5),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 15,
                              top: 9.92,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 93,
                                  height: 87,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/93x87"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black
                                            .withOpacity(0.20000000298023224),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 130,
                              top: 6,
                              child: Text(
                                'Executive Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 129.82,
                              top: 40.59,
                              child: Text(
                                'Gender-Age\n1000 Coins/1 Min',
                                style: TextStyle(
                                  color: Color(0xFF0E23E5),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 301,
                              top: 18.45,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 49.18,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 3.70,
                                        top: 20.93,
                                        child: Transform(
                                          transform: Matrix4.identity()
                                            ..translate(0.0, 0.0)
                                            ..rotateZ(-0.01),
                                          child: Container(
                                            width: 44,
                                            height: 44,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 44,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF1ADF51)),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 9.09,
                                                  top: 8.92,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 26,
                                                      height: 26,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 2.17,
                                                        left: 2.29,
                                                        right: 2.17,
                                                        bottom: 2.24,
                                                      ),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0.18,
                                        top: -0,
                                        child: Text(
                                          'Online',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                          ),
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
                    ),
                    Positioned(
                      left: 0,
                      top: 230,
                      child: Container(
                        width: 370,
                        height: 106,
                        decoration: ShapeDecoration(
                          color: Color(0xFF95E2D7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF0E23E5),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 15,
                              top: 9.92,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 93,
                                  height: 87,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/93x87"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black
                                            .withOpacity(0.20000000298023224),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 130,
                              top: 6,
                              child: Text(
                                'Executive Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 129.82,
                              top: 40.59,
                              child: Text(
                                'Gender-Age\n1000 Coins/1 Min',
                                style: TextStyle(
                                  color: Color(0xFF0E23E5),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 301,
                              top: 18.45,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 51.18,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 3.70,
                                        top: 20.93,
                                        child: Transform(
                                          transform: Matrix4.identity()
                                            ..translate(0.0, 0.0)
                                            ..rotateZ(-0.01),
                                          child: Container(
                                            width: 44,
                                            height: 44,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 44,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFFF21B1B)),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 9.09,
                                                  top: 8.92,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 26,
                                                      height: 26,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 2.17,
                                                        left: 2.29,
                                                        right: 2.17,
                                                        bottom: 2.24,
                                                      ),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0.18,
                                        top: -0,
                                        child: Text(
                                          'Offline',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                          ),
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
                    ),
                    Positioned(
                      left: 0,
                      top: 345,
                      child: Container(
                        width: 370,
                        height: 106,
                        decoration: ShapeDecoration(
                          color: Color(0xFF95E2D7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF0E23E5),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 15,
                              top: 9.92,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 93,
                                  height: 87,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/93x87"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black
                                            .withOpacity(0.20000000298023224),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 130,
                              top: 6,
                              child: Text(
                                'Executive Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 129.82,
                              top: 40.59,
                              child: Text(
                                'Gender-Age\n1000 Coins/1 Min',
                                style: TextStyle(
                                  color: Color(0xFF0E23E5),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 301,
                              top: 18.45,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 51.18,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 3.70,
                                        top: 20.93,
                                        child: Transform(
                                          transform: Matrix4.identity()
                                            ..translate(0.0, 0.0)
                                            ..rotateZ(-0.01),
                                          child: Container(
                                            width: 44,
                                            height: 44,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 44,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFFF21B1B)),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 9.09,
                                                  top: 8.92,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 26,
                                                      height: 26,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 2.17,
                                                        left: 2.29,
                                                        right: 2.17,
                                                        bottom: 2.24,
                                                      ),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0.18,
                                        top: -0,
                                        child: Text(
                                          'Offline',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                          ),
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
                    ),
                    Positioned(
                      left: 0,
                      top: 460,
                      child: Container(
                        width: 370,
                        height: 106,
                        decoration: ShapeDecoration(
                          color: Color(0xFF95E2D7),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF0E23E5),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 15,
                              top: 9.92,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 93,
                                  height: 87,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/93x87"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: Colors.black
                                            .withOpacity(0.20000000298023224),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 130,
                              top: 6,
                              child: Text(
                                'Executive Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 129.82,
                              top: 40.59,
                              child: Text(
                                'Gender-Age\n1000 Coins/1 Min',
                                style: TextStyle(
                                  color: Color(0xFF0E23E5),
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 301,
                              top: 18.45,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(-0.01),
                                child: Container(
                                  width: 54.18,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 3.70,
                                        top: 20.93,
                                        child: Transform(
                                          transform: Matrix4.identity()
                                            ..translate(0.0, 0.0)
                                            ..rotateZ(-0.01),
                                          child: Container(
                                            width: 44,
                                            height: 44,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 44,
                                                      height: 44,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFFEAB54F)),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 9.09,
                                                  top: 8.92,
                                                  child: Transform(
                                                    transform:
                                                        Matrix4.identity()
                                                          ..translate(0.0, 0.0)
                                                          ..rotateZ(-0.01),
                                                    child: Container(
                                                      width: 26,
                                                      height: 26,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 2.17,
                                                        left: 2.29,
                                                        right: 2.17,
                                                        bottom: 2.24,
                                                      ),
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0.18,
                                        top: -0,
                                        child: Text(
                                          'On Call',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w800,
                                          ),
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
                    ),
                    Positioned(
                      left: 330,
                      top: 462.34,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.01),
                        child: Container(
                          width: 37,
                          height: 48,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.62, vertical: 12),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 155,
              top: 35,
              child: Container(
                width: 62.79,
                height: 78,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 62.79,
                        height: 68,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0.15,
                              top: 0,
                              child: Container(
                                width: 62.64,
                                height: 68,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://via.placeholder.com/63x68"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 60,
                      child: Text(
                        'Premalu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 272,
              top: 251,
              child: Container(
                width: 18,
                height: 24,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/18x24"),
                    fit: BoxFit.cover,
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
