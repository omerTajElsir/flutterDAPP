import 'package:flutter/material.dart';
import 'package:flutter_app/styles/colors.dart';

/// Define all the text styles used in the app

const _blackFont = 'AvenirLTStd-Black';

const _bookFont = 'AvenirLTStd-Book';

const _romanFont = 'AvenirLTStd-Roman';

const _mediumFont = 'Avenir-Medium';

const _heavyFont = 'Avenir-Heavy';

TextStyle primaryButtonStyle =
    TextStyle(fontFamily: _mediumFont, fontSize: 16, color: Colors.white);

TextStyle secondaryButtonStyle =
    TextStyle(fontFamily: _mediumFont, fontSize: 16, color: Color(0xFF4B4B4B));

TextStyle normalLabelStyle =
    TextStyle(fontFamily: _mediumFont, fontSize: 16, color: Colors.white);
TextStyle normalRedLabelStyle =
    TextStyle(fontFamily: _mediumFont, fontSize: 16, color: redTextColor);

TextStyle textFieldStyle =
    TextStyle(fontFamily: _mediumFont, fontSize: 16, color: Colors.white);

TextStyle headingStyle =
    TextStyle(fontFamily: _heavyFont, fontSize: 20, color: Colors.white);

TextStyle optionStyle =
    TextStyle(fontFamily: _mediumFont, fontSize: 16, color: Colors.white70);
