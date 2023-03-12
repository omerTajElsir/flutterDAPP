import 'package:flutter/material.dart';

import 'colors.dart';

var appTheme = ThemeData(
    textTheme: TextTheme(),
    backgroundColor: Color(0xFF2B3041),
    primaryColor: Color(0xff121621),
    primaryColorLight: Color(0xff2A3043),
    accentColor: Color(0xffF16B5D),
    brightness: Brightness.dark,
    cardColor: Color(0xffF2F3F8),
    fontFamily: 'AvenirBlack',
    primaryTextTheme: TextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity);
