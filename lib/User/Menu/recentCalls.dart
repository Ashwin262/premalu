// RecentCalls.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package
import 'package:firebase_auth/firebase_auth.dart';

class RecentCalls extends StatefulWidget {
  const RecentCalls({Key? key}) : super(key: key); // Added Key? key for constructor

  @override
  State<StatefulWidget> createState() => _RecentCallsState();
}

class _RecentCallsState extends State<RecentCalls> {
  List<Map<String, dynamic>> _callHistory = []; // Store call history data
  bool _isLoading = true; // Loading indicator flag

  @override
  void initState() {
    super.initState();
    _loadCallHistory(); // Load call history when the widget initializes
  }

  // Fetch call history from Firestore
  Future<void> _loadCallHistory() async {
    setState(() {
      _isLoading = true; // Set loading to true while fetching data
    });

    try {
      final userId = FirebaseAuth.instance.currentUser?.uid; // Get current user's ID
      if (userId != null) {
        _callHistory = await getCallHistory(userId); // Fetch call history
      } else {
        print("No user logged in"); // Handle case where no user is logged in
      }
    } catch (e) {
      print("Error loading call history: $e"); // Log any errors
      // Optionally, display an error message to the user
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false after data is fetched (or on error)
      });
    }
  }

  // Function to retrieve call history from Firestore
  Future<List<Map<String, dynamic>>> getCallHistory(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('callHistory') // Access the 'callHistory' collection
          .where('callerId', isEqualTo: userId) // Filter by the current user's ID as the caller
          .orderBy('startTime', descending: true) // Order by start time, newest first
          .get(); // Get the data

      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList(); // Convert to List<Map>
    } catch (e) {
      print('Error fetching call history: $e');
      return []; // Return an empty list in case of an error
    }
  }

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
            Navigator.pop(context); // Handle back button press
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
        child: _isLoading // Show loading indicator if data is loading
            ? const Center(child: CircularProgressIndicator())
            : _callHistory.isEmpty // Show message if there's no call history
            ? const Center(child: Text('No recent calls.'))
            : ListView.builder( // Build the list of call history items
          itemCount: _callHistory.length,
          itemBuilder: (context, index) {
            return buildCallItem(_callHistory[index]); // Pass call data to buildCallItem
          },
        ),
      ),
    );
  }

  // Widget to build a single call history item
  Widget buildCallItem(Map<String, dynamic> call) {
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
                    image: NetworkImage("https://via.placeholder.com/93x87"), // Placeholder image
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
            Expanded( // Use Expanded for the text section
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call['calleeId'] ?? 'Unknown', // Display callee's ID or 'Unknown'
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    call['startTime']?.toDate().toString() ?? 'Unknown', // Display formatted start time or 'Unknown'
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