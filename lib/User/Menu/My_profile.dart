import 'package:flutter/material.dart';
import 'package:premalu/User/service/userservice.dart';

class My_profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _My_profile();
  }
}

class _My_profile extends State<My_profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  final userservice _userService = userservice();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    try {
      String name = _nameController.text.trim();
      int? age = int.tryParse(_ageController.text.trim());
      String state = _stateController.text.trim();
      String country = _countryController.text.trim();

      if (name.isEmpty || age == null || state.isEmpty || country.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields must be filled')),
        );
        return;
      }

      await _userService.saveUserProfile(name, age, state, country);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );

      // Clear text field after successful update
      _nameController.clear();
      _ageController.clear();
      _stateController.clear();
      _countryController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFF21B1B)),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 61,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              left: 80,
              top: 68,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  child: Text(
                    'My Profile',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 118,
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
              left: 45,
              right: 0,
              top: 153,
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Data are  highly protected with \nPremalu',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFFF21B1B),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 225,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.76,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Name',
                                hintStyle: TextStyle(
                                  color: Color(0xFFF21B1B),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.50,
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
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 281,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.84,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _ageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Age',
                                hintStyle: TextStyle(
                                  color: Color(0xFFF21B1B),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.50,
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
            ),
            Positioned(
              left: 45,
              right: 0,
              top: 339,
              child: Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Select Your State',
                  style: TextStyle(
                    color: Color(0xFFB3261E),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 374,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.54,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: _stateController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Tamil Nadu',
                                hintStyle: TextStyle(
                                  color: Color(0xFFF21B1B),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.50,
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
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 430,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: 330,
                    height: 46,
                    padding: const EdgeInsets.only(
                      top: 1,
                      left: 4,
                      bottom: 5.80,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF6EE18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              controller: _countryController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'India',
                                hintStyle: TextStyle(
                                  color: Color(0xFFF21B1B),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.50,
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
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 494,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 241,
                  height: 44,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 3,
                        top: 26,
                        child: const Text(
                          'and Privacy Policy',
                          style: TextStyle(
                            color: Color(0xFFB3261E),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: const Text(
                          'I agree to the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 95,
                        top: 0,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: const TextStyle(
                                  color: Color(0xFF9C1717),
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
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
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 546,
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _updateProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    backgroundColor: const Color(0xFFF21B1B),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFF6EE18)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadowColor: const Color(0x3F000000),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 21,
              top: 61,
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 13.33,
                  right: 14.33,
                  bottom: 10,
                ),
                child: const Row(
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
    );
  }
}