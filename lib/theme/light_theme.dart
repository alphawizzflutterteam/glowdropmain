import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: const Color(0xffF4F1EC),
  hintColor : const Color(0xFF212121),
brightness: Brightness.light,
  highlightColor: const Color(0xFF9DC5C5),
  // highlightColor: Colors.white,
  // hintColor: const Color(0xFF9E9E9E),
  colorScheme: const ColorScheme.light(
    primary: Color(0xffF4F1EC),
    secondary: Color(0xFFBF3526),
    tertiary: Color(0xFFF9D4A8),
    tertiaryContainer: Color(0xFFADC9F3),
    onTertiaryContainer: Color(0xFF33AF74),
    primaryContainer: Color(0xFF9AECC6),
    secondaryContainer: Color(0xFFF2F2F2),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
