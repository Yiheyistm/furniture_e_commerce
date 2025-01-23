import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2,
        title: Text('Terms and Conditions',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            )),
        leading: const CommonBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, 'Introduction'),
              _buildSectionContent(context,
                  'Welcome to RoomifyAR furniture e-commerce mobile application!'),
              const Divider(height: 40),
              _buildSectionTitle(context, 'Acceptance of Terms'),
              _buildSectionContent(context,
                  'By using Roomify AR, you agree to comply with and be bound by these Terms and Conditions.'),
              const Divider(height: 40),
              _buildSectionTitle(context, 'Terms and Conditions'),
              _buildSectionContent(context, '''
1. Usage: The content and services provided in this app are for personal use only.

2. Privacy: Your personal data will be handled in accordance with our privacy policy.

3. Liability: We are not liable for any damages resulting from the use of this app.

4. Changes: We reserve the right to modify these terms at any time.
              '''),
              const Divider(height: 40),
              _buildSectionTitle(context, 'Contact Us'),
              _buildSectionContent(context,
                  'If you have any questions or concerns about these Terms and Conditions, please contact us at yiheyisyt23@gmail.com.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    return Text(
      content,
      style: GoogleFonts.roboto(
        fontSize: 16,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }
}
