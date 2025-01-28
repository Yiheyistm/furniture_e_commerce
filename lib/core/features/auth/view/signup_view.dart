// ignore_for_file: use_build_context_synchronously, library_prefixes, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_button.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/components/custom_text_field.dart';
import 'package:furniture_e_commerce/core/components/google_auth_btn.dart';
import 'package:furniture_e_commerce/core/helper/alert_helper.dart';
import 'package:furniture_e_commerce/core/helper/show_loading_dialog.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/core/routes/route_name.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              key: _registerFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      AppAssets.logo,
                      width: 120,
                      height: 120,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      "Sign Up",
                      fontSize: 30,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 41,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomerTextField(
                      hintText: "Username",
                      controller: _usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomerTextField(
                    hintText: "Email",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomerTextField(
                    hintText: "Password",
                    obscureText: _obscurePassword,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be empty";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(_obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed(RouteName.loginView);
                        },
                        child: const Text(
                          " Login",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<MyAuthProvider>(
                    builder: (context, authProvider, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: "Sign up",
                          isLoading: authProvider.isLoading,
                          onTap: () {
                            if (_registerFormKey.currentState!.validate()) {
                              authProvider.startSignup(
                                  userName: _usernameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  context: context);
                            }
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or",
                          style: TextStyle(
                            color: Theme.of(context).dividerColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Consumer<MyAuthProvider>(
                    builder: (context, authProvider, child) {
                      return GoogleBtn(
                        text: "Continue with Google",
                        onPressed: authProvider.isLoading
                            ? () {
                                showLoadingDialog(context);
                              }
                            : () {
                                authProvider.signInWithGoogle(context);
                              },
                      );
                    },
                   
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
