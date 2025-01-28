import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5)).then((_) {
        if (mounted) {
          GoRouter.of(context).goNamed(RouteName.authWrapper);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/banner2.jpg',
            fit: BoxFit.cover,
          ),
          // Overlay with opacity
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Lottie.asset(
                    'assets/lottie/splashScreen.json',
                    
                  ),
                ),
                const SizedBox(height: 72),
                FadeInUp(
                  child: const CustomText(
                    "Roomify AR",
                    fontSize: 24,
                    textAlign: TextAlign.center,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Progress indicator
                const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
