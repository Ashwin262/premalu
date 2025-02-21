import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The maker of this Protection Approach guarantees a unfaltering commitment to Your security with respect to the security of your important data merely may share over this Stage. This protection arrangement contains information around the stage. To supply you with Our continuous utilize of the Stage, We may collect and, in a few circumstances, unveil data almost you together with your consent. To guarantee way better assurance of your protection, We offer this take note clarifying Our data collection and divulgence arrangements, and the choices You make almost the way Your data is collected and utilized. Any capitalized words utilized from this time forward might have the meaning agreed to them beneath this understanding. Assist, All heading utilized In this are as it were for the Reason of orchestrating the different arrangements of the understanding in any way. Not one or the other the client nor the makers of this protection approach may utilize the heading to Decipher the arrangements cointained Inside it in any way.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Data WE COLLECT',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We are committed to regarding your online security. We advance recognize your require for suitable security and administration of any Individual Data You share with us. We may collect the taking after data:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'a. Individual information counting but not restricted to Title, Phone Number, Mail ID, Address, City, Sex, Age, Installment Points of interest as per Installment Portal Rules',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'b. Data collected through consent determined by the Stage. for Area get to, and capacity',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}