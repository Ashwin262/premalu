import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:flutter_star_border/flutter_star_border.dart';

class CoinPage extends StatefulWidget {
  @override
  _CoinPageState createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  //     body: Container(
  //       decoration: const BoxDecoration(color: Color(0xFF43AF55)),
  //       child: Stack(
  //         children: [
  //           Positioned(
  //             top: 0,
  //             left: 0,
  //             right: 0,
  //             child: Container(
  //               padding: const EdgeInsets.all(16),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     'Coin',
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 20,
  //                       fontFamily: 'Inter',
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                   ),
  //                   IconButton(
  //                     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //
  //
  //           Positioned(
  //             top: 100,
  //             left: 0,
  //             right: 0,
  //             bottom: 0,
  //             child: Container(
  //               decoration: ShapeDecoration(
  //                 color: Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //               ),
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //
  //                     Padding(
  //                       padding: const EdgeInsets.only(top:20, left: 16),
  //                       child:  Text(
  //                         'Limited Offer',
  //                         style: const TextStyle(
  //                           color: Color(0xFFB3261E),
  //                           fontSize: 32,
  //                           fontFamily: 'Oleo Script',
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ),
  //
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 16),
  //                       child:  Text(
  //                         'Callfrnd',
  //                         style: const TextStyle(
  //                           color: Color(0xFFF21B1B),
  //                           fontSize: 24,
  //                           fontFamily: 'Miltonian Tattoo',
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ),
  //
  //                     const Padding(
  //                       padding:  EdgeInsets.only(left: 16),
  //                       child:  SizedBox(height: 16),
  //                     ),
  //
  //
  //                     AnimationLimiter(
  //                       child: GridView.count(
  //                         physics: const NeverScrollableScrollPhysics(),
  //                         shrinkWrap: true,
  //                         padding: const EdgeInsets.all(16),
  //                         crossAxisCount: 3,
  //                         childAspectRatio: 0.70,
  //                         crossAxisSpacing: 16,
  //                         mainAxisSpacing: 16,
  //                         children: List.generate(4, (index) {
  //                           return AnimationConfiguration.staggeredGrid(
  //                             position: index,
  //                             duration: const Duration(milliseconds: 375),
  //                             columnCount: 3,
  //                             child: ScaleAnimation(
  //                               child: FadeInAnimation(
  //                                 child: _buildCoinOffer(index),
  //                               ),
  //                             ),
  //                           );
  //                         }),
  //                       ),
  //                     ),
  //
  //
  //                     Padding(
  //                       padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Container(
  //                               width: MediaQuery.of(context).size.width*0.45,
  //                               height: 300,
  //                               decoration:  ShapeDecoration(
  //                                 color: const Color(0x66F80000),
  //                                 shape: RoundedRectangleBorder(
  //                                   side: const BorderSide(
  //                                     width: 3,
  //                                     strokeAlign: BorderSide.strokeAlignOutside,
  //                                     color: Colors.white,
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(12),
  //                                 ),
  //                               ),
  //                               child: Stack(
  //                                 children: [
  //                                   Positioned(
  //                                     top: 30,
  //                                     left: 30,
  //                                     child: Container(
  //                                       width: 121,
  //                                       height: 138,
  //                                       decoration: const ShapeDecoration(
  //                                         color: Colors.white,
  //                                         shape: OvalBorder(),
  //                                       ),
  //                                     ),
  //                                   ),
  //
  //                                   Positioned(
  //                                     left: 10,
  //                                     top:10,
  //                                     child: Container(
  //                                       width: 63,
  //                                       height: 61,
  //                                       decoration: const BoxDecoration(
  //                                         image: DecorationImage(
  //                                           image: NetworkImage("https://via.placeholder.com/63x61"),
  //                                           fit: BoxFit.fill,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Positioned(
  //                                     left: 90,
  //                                     top: 10,
  //                                     child: Container(
  //                                       width: 47,
  //                                       height: 47,
  //                                       decoration: const BoxDecoration(
  //                                         image: DecorationImage(
  //                                           image: NetworkImage("https://via.placeholder.com/47x47"),
  //                                           fit: BoxFit.fill,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               )
  //                           ),
  //                           Container(
  //                               width: MediaQuery.of(context).size.width*0.45,
  //                               height: 300,
  //                               decoration: ShapeDecoration(
  //                                 color: const Color(0x66F80000),
  //                                 shape: RoundedRectangleBorder(
  //                                   side: const BorderSide(
  //                                     width: 3,
  //                                     strokeAlign: BorderSide.strokeAlignOutside,
  //                                     color: Colors.white,
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(12),
  //                                 ),
  //                               ),
  //                               child: Stack(
  //                                 children: [
  //                                   Positioned(
  //                                     top: 30,
  //                                     left: 30,
  //                                     child: Container(
  //                                       width: 121,
  //                                       height: 138,
  //                                       decoration: const ShapeDecoration(
  //                                         color: Colors.white,
  //                                         shape: OvalBorder(),
  //                                       ),
  //                                     ),
  //                                   ),
  //
  //                                   Positioned(
  //                                     left: 10,
  //                                     top:10,
  //                                     child: Container(
  //                                       width: 63,
  //                                       height: 61,
  //                                       decoration: const BoxDecoration(
  //                                         image: DecorationImage(
  //                                           image: NetworkImage("https://via.placeholder.com/63x61"),
  //                                           fit: BoxFit.fill,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Positioned(
  //                                     left: 90,
  //                                     top: 10,
  //                                     child: Container(
  //                                       width: 47,
  //                                       height: 47,
  //                                       decoration: const BoxDecoration(
  //                                         image: DecorationImage(
  //                                           image: NetworkImage("https://via.placeholder.com/47x47"),
  //                                           fit: BoxFit.fill,
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               )
  //                           ),
  //
  //                         ],
  //                       ),
  //                     ),
  //
  //                     _buildCoinPurchaseOffers()
  //
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  //
  // Widget _buildCoinOffer(int index) {
  //   List<Map<String, dynamic>> coinOffers = [
  //     {
  //       'coins': '10,000 Coins',
  //       'price': '99 ',
  //       'discountPrice':'49',
  //       'color':  const Color(0xFFF78C8C),
  //
  //     },
  //     {
  //       'coins': '20,000 Coins',
  //       'price': '199 ',
  //       'discountPrice':'99',
  //       'color':  const Color(0xE21FD6FF),
  //     },
  //     {
  //       'coins': '24,000 Coins',
  //       'price': '229',
  //       'discountPrice':'107',
  //       'color': const Color(0xFFF21B1B),
  //     },
  //     {
  //       'coins': '36,000 Coins',
  //       'price': '299 ',
  //       'discountPrice':'166',
  //       'color': const Color(0xFFC9E809),
  //     },
  //   ];
  //
  //   return Container(
  //     child: Stack(
  //       children: [
  //         Container(
  //           decoration: ShapeDecoration(
  //             color: coinOffers[index]['color'],
  //             shape: RoundedRectangleBorder(
  //               side: const BorderSide(width: 3, color: Colors.white),
  //               borderRadius: BorderRadius.circular(15),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           top: 20,
  //           left: 20,
  //           child:  Text(
  //             coinOffers[index]['coins'],
  //             style: const TextStyle(
  //               color: Color(0xFF0B5BC4),
  //               fontSize: 10,
  //               fontFamily: 'Inter',
  //               fontWeight: FontWeight.w700,
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           top: 80,
  //           left: 20,
  //           child: Text.rich(
  //             TextSpan(
  //               children: [
  //                 const TextSpan(
  //                   text: '₹',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 10,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w800,
  //                   ),
  //                 ),
  //                 TextSpan(
  //                   text:  coinOffers[index]['price'],
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 12,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w800,
  //                   ),
  //                 ),
  //                 const TextSpan(
  //                   text: '₹',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 10,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w800,
  //                   ),
  //                 ),
  //                 TextSpan(
  //                   text:  coinOffers[index]['discountPrice'],
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 12,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w800,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           left: 30,
  //           top: 40,
  //           child: Container(
  //             width: 50,
  //             height: 50,
  //             decoration:  const ShapeDecoration(
  //               color: Colors.black,
  //               shape: OvalBorder(),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           left: 37,
  //           top: 33,
  //           child:Container(
  //             width: 44,
  //             height: 56,
  //             decoration: const BoxDecoration(
  //               image: DecorationImage(
  //                 image: NetworkImage("https://via.placeholder.com/44x56"),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //         )
  //
  //       ],
  //     ),
  //   );
  // }
  // Widget _buildCoinPurchaseOffers() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16),
  //     child:   Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children:  [
  //
  //         Padding(
  //           padding: const EdgeInsets.only(left: 10,bottom: 10),
  //           child: Container(
  //             width: 174,
  //             height: 49,
  //             decoration: ShapeDecoration(
  //               color: Colors.white,
  //               shape: StarBorder(
  //                 side: const BorderSide(width: 3, color: Color(0xFFF21B1B)),
  //                 points: 5,
  //                 innerRadiusRatio: 0.98,
  //                 pointRounding: 30,
  //                 valleyRounding: 0,
  //                 rotation: 0,
  //                 squash: 0,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 25, top: 16, bottom: 16),
  //           child:   Text.rich(
  //             TextSpan(
  //               children: [
  //                 const TextSpan(
  //                   text: '1000',
  //                   style: TextStyle(
  //                     color: Color(0xFF0E23E5),
  //                     fontSize: 15,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 const TextSpan(
  //                   text: ' Coins - ',
  //                   style: TextStyle(
  //                     color: Color(0xFF0E23E5),
  //                     fontSize: 10,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 const TextSpan(
  //                   text: '1',
  //                   style: TextStyle(
  //                     color: Color(0xFF0E23E5),
  //                     fontSize: 15,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 const TextSpan(
  //                   text: ' min',
  //                   style: TextStyle(
  //                     color: Color(0xFF0E23E5),
  //                     fontSize: 10,
  //                     fontFamily: 'Inter',
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //
  //         Wrap(
  //           spacing: 8, // Horizontal space between children
  //           runSpacing: 8,
  //           children: [
  //             _buildCoinPurchaseCard(
  //                 coins: '60,000 Coins',
  //                 price: '399',
  //                 discountPrice:'266',
  //                 context: context
  //             ),
  //             _buildCoinPurchaseCard(
  //                 coins: '82,000 Coins',
  //                 price: '499',
  //                 discountPrice: '377',
  //                 context: context
  //             ),
  //             _buildCoinPurchaseCard(
  //                 coins: '120,000 Coins',
  //                 price: '799',
  //                 discountPrice: '537',
  //                 context: context
  //             ),
  //           ],
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top:16, bottom: 16),
  //           child:     Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               _buildCoinOfferCard(
  //                 '7 Days\n30 mins/Per day\n',
  //                 '1999',
  //                 '1127',
  //               ),
  //               _buildCoinOfferCard(
  //                 '15 Days\n30 mins/Per day\n',
  //                 '2999',
  //                 '2437',
  //               ),
  //
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(bottom: 16),
  //           child:    Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               _buildCoinOfferCard(
  //                 '30 Days\n30 mins/Per day\n',
  //                 '5999',
  //                 '4857',
  //               ),
  //               _buildCoinOfferCard(
  //                 '60 Days\n30 mins/Per day\n',
  //                 '9999',
  //                 '8999',
  //               ),
  //
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //
  //   );
  // }
  //
  // Widget _buildCoinPurchaseCard({required String coins, required String price, required String discountPrice, required BuildContext context}){
  //   return Container(
  //     width: MediaQuery.of(context).size.width*0.45,
  //     height: 70,
  //     clipBehavior: Clip.antiAlias,
  //     decoration: ShapeDecoration(
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(width: 3, color: Color(0xFFF5F5F5)),
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //     ),
  //     child: Stack(
  //       children: [
  //         Positioned(
  //           left: 21,
  //           top: 8,
  //           child:  const Text(
  //             ' ₹',
  //             style: TextStyle(
  //               color: Color(0xFFF21B1B),
  //               fontSize: 10,
  //               fontFamily: 'Inter',
  //               fontWeight: FontWeight.w800,
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           left: 23,
  //           top: 3,
  //           child:  SizedBox(
  //             width: 123,
  //             child: Text(
  //               coins,
  //               style: const TextStyle(
  //                 color: Color(0xFF9C1717),
  //                 fontSize: 14,
  //                 fontFamily: 'Inter',
  //                 fontWeight: FontWeight.w700,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           left: 2,
  //           top: 30,
  //           child: Container(
  //             width: 146,
  //             height: 28,
  //             decoration: const ShapeDecoration(
  //               color: Color(0xFFF6EE18),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(12),
  //                   topRight: Radius.circular(12),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           left: 20,
  //           top: 34,
  //           child:  SizedBox(
  //             width: 133,
  //             height: 21,
  //             child: Text.rich(
  //               TextSpan(
  //                 children: [
  //                   TextSpan(
  //                     text: '₹',
  //                     style: TextStyle(
  //                       color: Color(0xFF42123D),
  //                       fontSize: 16,
  //                       fontFamily: 'Inter',
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   TextSpan(
  //                     text: price,
  //                     style: const TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 16,
  //                       fontFamily: 'Inter',
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   TextSpan(
  //                     text: '₹ $discountPrice',
  //                     style: const TextStyle(
  //                       color: Color(0xFF42123D),
  //                       fontSize: 16,
  //                       fontFamily: 'Inter',
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           left: 45,
  //           top: 33,
  //           child: Container(
  //             width: 15.30,
  //             height: 20,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _buildCoinOfferCard(String offer, String price, String discountPrice) {
  //   return  Container(
  //     width: MediaQuery.of(context).size.width * 0.45,
  //     height: 120,
  //
  //     child: Stack(
  //         children: [
  //           Positioned(
  //             top: 10,
  //             left: 10,
  //             child: Text.rich(
  //               TextSpan(
  //                 children: [
  //                   TextSpan(
  //                     text: offer,
  //                     style: const TextStyle(
  //                       color: Color(0xFF0E23E5),
  //                       fontSize: 16,
  //                       fontFamily: 'Inter',
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   TextSpan(
  //                     text: '₹ $price',
  //                     style: const TextStyle(
  //                       color: Color(0xE21FD6FF),
  //                       fontSize: 16,
  //                       fontFamily: 'Inter',
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                   TextSpan(
  //                     text: ' ₹$discountPrice',
  //                     style: const TextStyle(
  //                       color: Color(0xFFF21B1B),
  //                       fontSize: 20,
  //                       fontFamily: 'Inter',
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //
  //         ]
  //     ),
    );

  }

}