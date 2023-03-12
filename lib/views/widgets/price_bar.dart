import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/chart/models/chart_model.dart';

class CurrentPrice extends StatelessWidget {
  const CurrentPrice({
    Key? key,
    required List<ChartCandleModel> listData,
  })  : _listData = listData,
        super(key: key);

  final List<ChartCandleModel> _listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Open: " + _listData[0].open.toString(),
                style: TextStyle(fontSize: 16),
              ),
              Expanded(child: Container()),
              Text(
                "Close: " + _listData[0].close.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "High: " + _listData[0].high.toString(),
                style: TextStyle(fontSize: 16),
              ),
              Expanded(child: Container()),
              Text(
                "Low: " + _listData[0].low.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
