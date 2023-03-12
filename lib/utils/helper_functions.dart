import 'dart:math';

import 'package:intl/intl.dart';

class HelperFunctions {
  static double log10(num x) => log(x) / ln10;

  static double getRoof(double number) {
    int log = log10(number).floor();
    return (number ~/ pow(10, log) + 1) * pow(10, log).toDouble();
  }

  static String addMetricPrefix(double price) {
    if (price < 1) price = 1;
    int log = log10(price).floor();
    if (log > 9)
      return "${price ~/ 1000000000}B";
    else if (log > 6)
      return "${price ~/ 1000000}M";
    else if (log > 3)
      return "${price ~/ 1000}K";
    else
      return "${price.toStringAsFixed(0)}";
  }

  static String priceToString(double value) {
    int decimal = 2;
    if (value > 0.001 && value < 0.009) {
      decimal = 3;
    }
    String retVal;
    if (value == 0) {
      retVal = "0";
    } else if (value < 0.001) {
      retVal = "<0.001";
    } else if (value < 1000.0) {
      retVal = value.toStringAsFixed(decimal);
    } else {
      retVal = NumberFormat.compactCurrency(
        decimalDigits: 3,
        symbol: '',
      ).format(value);
    }

    return retVal;
  }
}
