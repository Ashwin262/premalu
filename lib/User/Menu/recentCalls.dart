import 'package:flutter/material.dart';

class RecentCalls extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecentCallsState();
}

class _RecentCallsState extends State<RecentCalls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF21B1B), // Set background color here
      appBar: AppBar(
        backgroundColor: const Color(0xFFF21B1B),
        title: const Text('Recent Calls'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press, e.g., Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity, // Use double.infinity for full width
        height: double.infinity, // Use double.infinity for full height
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.only(top: 16.0), // Add padding to the top
        child: ListView.builder(
          itemCount: 5, // Replace with the actual number of calls
          itemBuilder: (context, index) {
            return buildCallItem(index);
          },
        ),
      ),
    );
  }

  Widget buildCallItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: double.infinity,
        height: 106,
        decoration: ShapeDecoration(
          color: const Color(0xFF95E2D7),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFF0E23E5),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 93,
                height: 87,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/93x87"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.2),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: const [
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
            Expanded(  // Use Expanded for the text section
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Executive Name $index', // Dynamically set name
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'DD/MM/YYYY\nHH:MM:SS', // Replace with actual date and time
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}