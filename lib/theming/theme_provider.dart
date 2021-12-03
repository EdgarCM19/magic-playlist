import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  

  bool get isDarkMode {
    if(themeMode == ThemeMode.system){
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool dark){
    themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {

  static final theme = ThemeData();

  static final darkTheme = theme.copyWith(
    scaffoldBackgroundColor: const Color(0xFF292929),
    colorScheme: theme.colorScheme.copyWith(
      primary: const Color(0xFFC7DFBC),
      primaryVariant: const Color(0xFFEFEAE0),
      secondary: const Color(0xFFFFFFFF),
      secondaryVariant: const Color(0xFF666161),
      background: const Color(0xFF292929),
    ),
  );

  static final lightTheme = theme.copyWith(
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: theme.colorScheme.copyWith(
      primary: const Color(0xFFC7DFBC),
      primaryVariant: const Color(0xFFEFEAE0),
      secondary: const Color(0xFF929292),
      secondaryVariant: const Color(0xFF666161),
      background: const Color(0xFF292929),
    )
  );

}