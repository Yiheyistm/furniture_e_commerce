// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:furniture_e_commerce/core/components/custom_button.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/components/custom_text_field.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:provider/provider.dart';

class ProfileUpdateForm extends StatefulWidget {
  const ProfileUpdateForm({super.key});

  @override
  _ProfileUpdateFormState createState() => _ProfileUpdateFormState();
}

class _ProfileUpdateFormState extends State<ProfileUpdateForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<MyAuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const Row(
                children: [
                  CommonBackButton(),
                  Spacer(),
                  CustomText(
                    "Edit Profile",
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                color: Theme.of(context).canvasColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CustomerTextField(
                        hintText: "New Username",
                        controller: _usernameController,
                      ),
                      const SizedBox(height: 10),
                      CustomerTextField(
                        hintText: "Old Password",
                        obscureText: true,
                        controller: _oldPasswordController,
                      ),
                      const SizedBox(height: 10),
                      CustomerTextField(
                        hintText: "New Password",
                        obscureText: true,
                        controller: _newPasswordController,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: "Update Profile",
                        onTap: () {
                          if (_oldPasswordController.text.isEmpty ||
                              _newPasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Fill all fields")));
                            return;
                          }
                          if (_usernameController.text.isNotEmpty) {
                            authProvider.updateUserProfile(
                                context, _usernameController.text);
                          }
                          if (_oldPasswordController.text.isNotEmpty &&
                              _newPasswordController.text.isNotEmpty) {
                            authProvider.oldPassword.text =
                                _oldPasswordController.text;
                            authProvider.newPassword.text =
                                _newPasswordController.text;
                            authProvider.resetPassword(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
