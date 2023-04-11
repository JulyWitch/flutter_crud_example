import 'package:flutter/material.dart';

const _textTheme = TextTheme(
  headline1: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 51,
    fontWeight: FontWeight.w700,
  ),
  headline2: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 36,
    fontWeight: FontWeight.w600,
  ),
  headline3: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 30,
    letterSpacing: .25,
    fontWeight: FontWeight.w500,
  ),
  headline4: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 25,
    letterSpacing: .25,
    fontWeight: FontWeight.w500,
  ),
  headline5: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 21,
    fontWeight: FontWeight.w500,
    letterSpacing: .25,
  ),
  headline6: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 14,
    letterSpacing: -.3,
    height: 1.5,
    fontWeight: FontWeight.w600,
  ),
  bodyText1: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  ),
  bodyText2: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 18,
    letterSpacing: -.1,
    fontWeight: FontWeight.w700,
  ),
  subtitle1: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 17,
    fontWeight: FontWeight.w500,
  ),
  subtitle2: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 17,
    fontWeight: FontWeight.w700,
    letterSpacing: .15,
  ),
  button: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 21,
    height: 1.5,
    color: Color(0xFFF0F0F0),
    fontWeight: FontWeight.w500,
    letterSpacing: -.3,
  ),
  caption: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: -.3,
  ),
  overline: TextStyle(
    fontFamily: 'Nunito',
    fontSize: 8,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: -.3,
  ),
);

const _colorScheme = ColorScheme.light(
  primary: Color(0xff8CB1EB),
);

final blueLightTheme = ThemeData(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
);
