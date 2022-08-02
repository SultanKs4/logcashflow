import 'package:flutter/material.dart';
import 'package:logcashflow/app/modules/views/theme/app_colors.dart';

class Themes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
    // colorScheme: const ColorScheme.light(
    //   primary: AppColors.lavender,
    //   onPrimary: Colors.black,
    //   secondary: AppColors.spaceBlue,
    //   onSecondary: AppColors.spaceCadet,
    //   background: AppColors.babyPink,
    // ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    // colorScheme: const ColorScheme.dark(
    //   primary: AppColors.spaceBlue,
    //   secondary: AppColors.burgundy,
    //   onSecondary: AppColors.spaceCadet,
    //   background: AppColors.spaceCadet,
    // ),
  );
}
