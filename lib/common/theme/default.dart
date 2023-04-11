import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _colorScheme = ColorScheme(
  brightness: Brightness.light,
  background: Color(0xFFFFFFFF),
  onBackground: Color(0xFF1B1B1B),
  primary: Color(0xff333366),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color.fromRGBO(200, 50, 100, 1),
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  surface: Color(0x28FBFBFB),
  onSurface: Color(0xFF1B1B1B),
  onTertiary: Colors.black,
  primaryContainer: Color.fromRGBO(113, 117, 217, 1),
  onInverseSurface: Color.fromRGBO(35, 197, 31, 1),
);

final defaultThemeData = ThemeData(
  scaffoldBackgroundColor: _colorScheme.background,
  colorScheme: _colorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: _colorScheme.background,
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF1B1B1B),
    ),
    centerTitle: true,
    titleTextStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xff1B1B1B),
    ),
  ),
);
