
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/theme_data.dart';

import '../../data/chart/models/chart_model.dart';

class CandleInfoText extends StatelessWidget {
  const CandleInfoText({
    Key? key,
    required this.candle,
  }) : super(key: key);

  final ChartCandleModel candle;

  String numberFormat(int value) {
    return "${value < 10 ? 0 : ""}$value";
  }

  String dateFormatter(DateTime date) {
    return "${date.year}-${numberFormat(date.month)}-${numberFormat(date.day)} ${numberFormat(date.hour)}:${numberFormat(date.minute)}";
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: dateFormatter(candle.openTime),
        style: TextStyle(color: Theme.of(context).grayColor, fontSize: 10),
        children: <TextSpan>[
          TextSpan(text: " O:"),
          TextSpan(
              text: candle.open.toStringAsFixed(2),
              style: TextStyle(
                  color: candle.isBull
                      ? Theme.of(context).primaryGreen
                      : Theme.of(context).primaryRed)),
          TextSpan(text: " H:"),
          TextSpan(
              text: candle.high.toStringAsFixed(2),
              style: TextStyle(
                  color: candle.isBull
                      ? Theme.of(context).primaryGreen
                      : Theme.of(context).primaryRed)),
          TextSpan(text: " L:"),
          TextSpan(
              text: candle.low.toStringAsFixed(2),
              style: TextStyle(
                  color: candle.isBull
                      ? Theme.of(context).primaryGreen
                      : Theme.of(context).primaryRed)),
          TextSpan(text: " C:"),
          TextSpan(
              text: candle.close.toStringAsFixed(2),
              style: TextStyle(
                  color: candle.isBull
                      ? Theme.of(context).primaryGreen
                      : Theme.of(context).primaryRed)),
        ],
      ),
    );
  }
}
