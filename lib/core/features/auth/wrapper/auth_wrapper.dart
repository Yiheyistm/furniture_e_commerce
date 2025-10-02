import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:furniture_e_commerce/core/features/auth/view/signup_view.dart';
import 'package:furniture_e_commerce/core/features/main/view/main_view.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:logger/logger.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Logger().i('Connection State: ${snapshot.connectionState}');
        Logger().i('User Data: ${snapshot.data}');
        Logger().i('Connection state: ${snapshot.connectionState}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitSpinningLines(
                    color: AppColors.primaryColor,
                    lineWidth: 4,
                    size: 70.0,
                  ),
                  Text("Loading..."),
                ],
              ));
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data != null) {
            Logger().i('User logged in: ${snapshot.data!.displayName}');
            
            return const MainView();
          } else {
            Logger().i('No user found, navigating to SignupView.');
            return const SignupView();
          }
        } else {
          Logger().e(
              'Error: Snapshot connection state is ${snapshot.connectionState}');
          return const Center(child: Text('Error occurred'));
        }
      },
    );
  }
}
