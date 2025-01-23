import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furniture_e_commerce/core/components/custom_back_button.dart';
import 'package:furniture_e_commerce/core/components/custom_button.dart';
import 'package:furniture_e_commerce/core/components/custom_text.dart';
import 'package:furniture_e_commerce/core/components/custom_text_field.dart';
import 'package:furniture_e_commerce/core/provider/auth_provider.dart';
import 'package:furniture_e_commerce/core/utils/app_assets.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';
import 'package:provider/provider.dart';

class FogotPassword extends StatefulWidget {
  const FogotPassword({super.key});

  @override
  State<FogotPassword> createState() => _FogotPasswordState();
}

class _FogotPasswordState extends State<FogotPassword> {
  final GlobalKey<FormState> _forgetPasswordFormKey = GlobalKey<FormState>();
  late TextEditingController _forgetEmailController;

  @override
  void initState() {
    // TODO: implement initState
    _forgetEmailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _forgetPasswordFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: CommonBackButton(),
                  ),
                  const CustomText(
                    "Forgot Passsword",
                    fontSize: 25,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    AppAssets.logo,
                    width: 200,
                    height: 190,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const CustomText(
                    "Please enter your email address. You will recieved a link to create a new password via email.",
                    fontSize: 14,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomerTextField(
                    hintText: "Enter your Email",
                    controller: _forgetEmailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email can't Be Empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Consumer<MyAuthProvider>(builder: (context, value, child) {
                    return CustomButton(
                      text: "Sent Email",
                      isLoading: value.isLoading,
                      onTap: () {
                        if (_forgetPasswordFormKey.currentState!.validate()) {
                          value.sendPasswordResetEmail(
                              resetEmail: _forgetEmailController.text,
                              context: context);
                        }
                      },
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  EmailAuthButton(
                    onPressed: () {},
                    style: const AuthButtonStyle(
                      buttonType: AuthButtonType.secondary,
                      iconType: AuthIconType.secondary,
                    ),
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
