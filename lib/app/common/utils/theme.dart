import 'package:flutter/material.dart';

import 'package:expchk/app/common/utils/colors.dart';

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: primaryClrMaterial,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
    ),
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: darkGreyClrMaterial,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkGreyClr,
    ),
    useMaterial3: true,
  );
}
