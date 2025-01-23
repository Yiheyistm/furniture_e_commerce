import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/features/auth/view/signup_view.dart';
import 'package:furniture_e_commerce/core/features/main/view/main_view.dart';
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
        Logger().i('Connection State: ${snapshot.connectionState}');
        Logger().i('User Data: ${snapshot.data}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data != null) {
            Logger().i('User logged in: ${snapshot.data!.uid}');

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
