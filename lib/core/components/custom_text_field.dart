// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';

class CustomerTextField extends StatelessWidget {
  CustomerTextField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      this.suffix,
      this.validator,
      required this.controller,
      this.keyboardType = TextInputType.text});

  TextEditingController controller;
  String? Function(String?)? validator;
  TextInputType keyboardType;
  bool? obscureText;
  Widget? suffix;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPhysics: const BouncingScrollPhysics(),
      onTapOutside: (value) => FocusScope.of(context).unfocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText!,
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        focusedErrorBorder:
            Theme.of(context).inputDecorationTheme.focusedErrorBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        errorStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: AppColors.requiredColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 10),
      ),
      validator: validator,
    );
  }
}
