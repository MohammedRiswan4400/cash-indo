import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final GetStorage _storage = GetStorage(); // For persisting theme preference
  final String _themeKey = "isDarkMode";

  // Initialize theme mode
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the saved theme preference or default to dark mode
    isDarkMode.value = _storage.read(_themeKey) ?? true;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Toggle between dark and light mode
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemePreference();
  }

  // Save the user's theme preference
  void _saveThemePreference() {
    _storage.write(_themeKey, isDarkMode.value);
  }
}
