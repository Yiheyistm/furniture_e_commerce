import 'package:flutter/material.dart';
import 'package:furniture_e_commerce/core/features/main/services/storage_service.dart';
import 'package:furniture_e_commerce/core/locator/locator.dart';
import 'package:furniture_e_commerce/core/utils/app_theme.dart';

class ThemeModeProvider extends ChangeNotifier {
  final StorageService _storageService = locator<StorageService>();

  ThemeData _themeMode = appThemesData[AppTheme.lightTheme]!;

  ThemeData get themeMode => _themeMode;

  void toggleTheme(isOn) {
    _themeMode = isOn
        ? appThemesData[AppTheme.darkTheme]!
        : appThemesData[AppTheme.lightTheme]!;
    saveTheme(isOn);
    notifyListeners();
  }

  void loadTheme() {
    bool isDarkMode = _storageService.getData("isDarkMode") ?? false;
    print(isDarkMode);
    _themeMode = isDarkMode
        ? appThemesData[AppTheme.darkTheme]!
        : appThemesData[AppTheme.lightTheme]!;
    notifyListeners();
  }

  void saveTheme(bool isDarkMode) {
    _storageService.setData("isDarkMode", isDarkMode);
  }
}
