import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  _AboutUsViewState createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  final String emailAddress = 'yiheyisyt23@gmail.com';
  final TextEditingController _feedbackController = TextEditingController();

  void _launchEmail() async {
    final String feedback = _feedbackController.text;
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': 'Feedback',
        'body': feedback,
      },
    );

    try {
      if (await canLaunchUrlString(emailLaunchUri.toString())) {
        await launchUrl(emailLaunchUri);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('No Email App Found'),
            content: const Text(
              'There seems to be no default email app installed on your device. Please install an email app to send feedback.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        throw 'Could not launch email. Make sure an email app is installed.';
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2,
        title: Text('About Us',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            )),
        leading: const CommonBackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInLeftBig(
                from: 70,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(32),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppAssets.logo),
                      ),
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeInUp(
                child: Column(
                  children: [
                    Text('RoomifyAR',
                        style: GoogleFonts.pacifico(
                            fontSize: 34, color: AppColors.primaryColor)),
                    const SizedBox(height: 10),
                    Text(
                      '--------------------------------------------\nRoomifyAR is dedicated to providing furniture e-commerce solutions with AR features',
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Our mission is to enhance the shopping experience by enabling users to visualize products in their real-world spaces.\n\nContact us for inquiries or feedback.',
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _feedbackController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Enter your feedback here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _launchEmail,
                      icon: const Icon(Icons.email),
                      label: Text(
                        'Email Us',
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
