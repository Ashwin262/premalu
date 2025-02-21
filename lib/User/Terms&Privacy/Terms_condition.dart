import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Terms & Conditions',
          style: TextStyle(color: Colors.brown),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Rules and requirements in India',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0), // Adding some spacing
              Text(
                'This legal agreement is an online document according to the Indian Information Technology Act, 2000, and its rules, including any updates made to laws about electronic records by this act. This electronic record is made by a computer and does not need any handwritten or digital signatures.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0), // Adding more spacing
              Text(
                'This document is made according to the rules set out in the Indian Information Technology (Intermediaries guidelines) Rules, 2011, and the Information Technology (Reasonable security practices and procedures and sensitive personal data or information) Rules, 2011. These rules, part of the Information Technology Act from 2000 and updated in 2008, say that we need to share the Terms of Use and how to access and use our platform.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'GDPR Privacy Rights means the rules that help protect your personal information.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'The General Data Protection Regulation, or GDPR, gives people specific rights about their personal information. We are pleased to provide clear information and access controls to help Users make the most of their rights. Individuals have certain rights, unless the law says otherwise.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Right of access means you have the right to know and ask for the information we',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}