import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF225FA6),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD5E3FF),
  onPrimaryContainer: Color(0xFF001C3B),
  secondary: Color(0xFF1860A5),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD3E3FF),
  onSecondaryContainer: Color(0xFF001C39),
  tertiary: Color(0xFFA7391E),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFDAD2),
  onTertiaryContainer: Color(0xFF3D0700),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFAFCFF),
  onBackground: Color(0xFF001F2A),
  surface: Color(0xFFFAFCFF),
  onSurface: Color(0xFF001F2A),
  surfaceVariant: Color(0xFFE0E2EC),
  onSurfaceVariant: Color(0xFF43474E),
  outline: Color(0xFF74777F),
  onInverseSurface: Color(0xFFE1F4FF),
  inverseSurface: Color.fromARGB(255, 7, 7, 7),
  inversePrimary: Color(0xFFA7C8FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF225FA6),
  outlineVariant: Color(0xFFC4C6CF),
  scrim: Color(0xFF000000),
);

ThemeData mainTheme = ThemeData(
  colorScheme: lightColorScheme,
);
