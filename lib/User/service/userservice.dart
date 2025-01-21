// userservice.dart
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';


class userservice {
  final _fire = FirebaseFirestore.instance;

  Future<void> saveUserProfile(String name, int age, String state, String country) async {
    try {
      await _fire.collection('users').add({
        'name': name,
        'age': age,
        'state': state,
        'country': country,
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
      });
      log('User profile data saved successfully!');
    } catch (e) {
      log('Error saving user profile: $e');
      rethrow;
    }
  }
}