import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';

class GoogleBtn extends StatefulWidget {
  const GoogleBtn({super.key, required this.onPressed, required this.text});
  // function onPressed
  final Function() onPressed;
  final String text;

  @override
  State<GoogleBtn> createState() => _GoogleBtnState();
}

class _GoogleBtnState extends State<GoogleBtn> {
  @override
  Widget build(BuildContext context) {
    return GoogleAuthButton(
      onPressed: widget.onPressed,
      style: const AuthButtonStyle(
          textStyle: TextStyle(
              color: AppColors.bgDark,
              fontSize: 15,
              fontWeight: FontWeight.w300),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          buttonType: AuthButtonType.secondary,
          buttonColor: AppColors.whiteColor,
          iconBackground: AppColors.whiteColor,
          iconSize: 20,
          separator: 20,
          elevation: 0),
    );
  }
}
