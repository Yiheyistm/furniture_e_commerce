import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/utils/app_color.dart';

enum AppTheme { darkTheme, lightTheme }

final Map<AppTheme, ThemeData> appThemesData = {
  AppTheme.lightTheme: ThemeData.light(useMaterial3: true).copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.bgLight,
      dividerColor: AppColors.dividerColor,
      canvasColor: AppColors.secondaryLight,
      shadowColor: AppColors.greyColor,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(12),
        filled: true,
        fillColor: AppColors.whiteColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      )),
  AppTheme.darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.bgDark,
      canvasColor: AppColors.secondaryDark,
      shadowColor: AppColors.blackColor,
      dividerColor: const Color(0xFF424242),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(12),
        filled: true,
        fillColor: Color(0xFF424242),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ))
};
