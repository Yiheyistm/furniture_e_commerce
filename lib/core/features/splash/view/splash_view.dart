import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Logger().d("Splash Screen");
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Provider.of<AuthProvider>(context, listen: false)
            .initializedUser(context);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const AppLogo(
            //   width: 331,
            //   height: 331,
            // ),
            Lottie.asset(
              // Replace with your Lottie JSON file path
              'assets/lottie/splashScreen.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 72,
            ),
            FadeInUp(
              child: const CustomText(
                "Build your own Reality with Us..\nExplore the world of AR E-Furniture",
                fontSize: 20,
                textAlign: TextAlign.center,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
