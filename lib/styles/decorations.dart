
import 'package:flutter/material.dart';
import 'package:flutter_app/styles/colors.dart';

import 'textStyles.dart';

InputDecoration buildTextFieldDecoration(String hint, IconData? prefixIcon, IconData? suffixIcon) {
  return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(prefixIcon, color: Colors.white),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(suffixIcon, color: Colors.white),
      ),

      hintStyle: textFieldStyle,
      filled: true,
     // fillColor: Theme.of(context).primaryColorLight,
    //  fillColor: whiteColor,
      hintText: hint,
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 8.0),
      isCollapsed: false,
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30.0)));
}