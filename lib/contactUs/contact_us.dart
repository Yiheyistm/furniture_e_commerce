import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        leading: const CommonBackButton(),
        title: const Text('Contact Us'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInLeft(
                from: 70,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppAssets.logo),
                      ),
                    ),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeInUp(
                child: Column(
                  children: [
                    const Text(
                      'Have questions or suggestions?\nWe\'d love to hear from you!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Feel free to reach out to us. We are here to help!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    ListTile(
                      leading: SvgPicture.asset(AppAssets.github),
                      title: const Text(
                        'Yiheyis Tamir',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: const Text('GitHub: @yiheyistm'),
                      onTap: () {
                        _launchURL('https://github.com/yiheyistm');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: SvgPicture.asset(AppAssets.gmail),
                      title: const Text(
                        'Yiheyis Tamir',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: const Text('Email: yiheyisyt23@gmail.com'),
                      onTap: () {
                        _launchEmail(
                            'yiheyisyt23@gmail.com?subject=Greetings&body=Hello%20World');
                      },
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

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(Uri.parse(emailLaunchUri.toString()))) {
      await launchUrl(Uri.parse(emailLaunchUri.toString()));
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }
}
