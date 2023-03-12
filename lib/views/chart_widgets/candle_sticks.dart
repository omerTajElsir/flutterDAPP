import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/constants/intervals.dart';

import '../../data/chart/models/chart_model.dart';
import 'mobile_chart.dart';
import 'toolbar.dart';

/// StatefulWidget that holds Chart's State (index of
/// current position and candles width).
class Candlesticks extends StatefulWidget {
  final List<ChartCandleModel> candles;

  /// callback calls wshen user changes interval
  final Future<void> Function(String) onIntervalChange;

  final String interval;

  final List<String>? intervals;

  Candlesticks({
    required this.candles,
    required this.onIntervalChange,
    required this.interval,
    this.intervals,
  });

  @override
  _CandlesticksState createState() => _CandlesticksState();
}

/// [Candlesticks] state
class _CandlesticksState extends State<Candlesticks> {
  /// index of the newest candle to be displayed
  /// changes when user scrolls along the chart
  int index = -10;

  double lastX = 0;
  int lastIndex = -10;

  @override
  void didUpdateWidget(Candlesticks oldWidget) {
    if (oldWidget.interval != widget.interval) {
      index = -10;
      lastX = 0;
      lastIndex = -10;
    }
    super.didUpdateWidget(oldWidget);
  }

  /// candleWidth controls the width of the single candles.
  ///  range: [2...10]
  double candleWidth = 6;

  bool showIntervals = false;

  @override
  Widget build(BuildContext context) {
    if (widget.candles.length == 0)
      return Center(
        child: CircularProgressIndicator(),
      );
    return Column(
      children: [
        ToolBar(
            onZoomInPressed: () {
              setState(() {
                candleWidth += 2;
                candleWidth = min(candleWidth, 10);
              });
            },
            onZoomOutPressed: () {
              setState(() {
                candleWidth -= 2;
                candleWidth = max(candleWidth, 2);
              });
            },
            interval: widget.interval,
            intervals: widget.intervals ?? intervals,
            onIntervalChange: widget.onIntervalChange),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: TweenAnimationBuilder(
            tween: Tween(begin: 6.toDouble(), end: candleWidth),
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOutCirc,
            builder: (_, width, __) {
              return Container(
                padding:
                    EdgeInsets.only(top: 30, bottom: 30, right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: MobileChart(
                  onScaleUpdate: (double scale) {
                    setState(() {
                      candleWidth *= scale;
                      candleWidth = min(candleWidth, 10);
                      candleWidth = max(candleWidth, 2);
                      candleWidth.toInt();
                    });
                  },
                  onPanEnd: () {
                    lastIndex = index;
                  },
                  onHorizontalDragUpdate: (double x) {
                    setState(() {
                      x = x - lastX;
                      index = lastIndex + x ~/ candleWidth;
                      index = max(index, -10);
                      index = min(index, widget.candles.length - 1);
                    });
                  },
                  onPanDown: (double value) {
                    lastX = value;
                    lastIndex = index;
                  },
                  candleWidth: width as double,
                  candles: widget.candles,
                  index: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
