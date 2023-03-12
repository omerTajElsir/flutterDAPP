
import 'package:flutter/material.dart';

import '../../data/chart/models/chart_model.dart';

/// This widget extends [LeafRenderObjectWidget]
/// And uses CandleStickRenderObject for painting the chart.
class VolumeWidget extends LeafRenderObjectWidget {
  final List<ChartCandleModel> candles;
  final int index;
  final double barWidth;
  final double high;
  final Color bullColor;
  final Color bearColor;

  VolumeWidget({
    required this.candles,
    required this.index,
    required this.barWidth,
    required this.high,
    required this.bearColor,
    required this.bullColor,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return VolumeRenderObject(
      candles,
      index,
      barWidth,
      high,
      bearColor,
      bullColor,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    VolumeRenderObject candlestickRenderObject =
        renderObject as VolumeRenderObject;
    candlestickRenderObject._candles = candles;
    candlestickRenderObject._index = index;
    candlestickRenderObject._barWidth = barWidth;
    candlestickRenderObject._high = high;
    candlestickRenderObject._bearColor = bearColor;
    candlestickRenderObject._bullColor = bullColor;
    candlestickRenderObject.markNeedsPaint();
    super.updateRenderObject(context, renderObject);
  }
}

/// This render object is responsible for
/// drawing the configured chart on the canvas.
class VolumeRenderObject extends RenderBox {
  late List<ChartCandleModel> _candles;
  late int _index;
  late double _barWidth;
  late double _high;
  late Color _bearColor;
  late Color _bullColor;

  VolumeRenderObject(
    List<ChartCandleModel> candles,
    int index,
    double barWidth,
    double high,
    Color bearColor,
    Color bullColor,
  ) {
    _candles = candles;
    _index = index;
    _barWidth = barWidth;
    _high = high;
    _bearColor = bearColor;
    _bullColor = bullColor;
  }

  /// set size as large as possible
  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  /// draws a single candle
  void paintBar(PaintingContext context, Offset offset, int index,
      ChartCandleModel candle, double range) {
    Color color = candle.isBull ? _bullColor : _bearColor;

    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    var path = Path()
      ..addRect(Rect.fromPoints(
          Offset(size.width + offset.dx - (index * _barWidth + 0.5),
              offset.dy + (_high - candle.volume) / range),
          Offset(size.width + offset.dx - ((index + 1) * _barWidth - 0.5),
              offset.dy + size.height)));
    context.canvas.drawPath(path, paint);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double range = (_high) / size.height;
    for (int i = 0; (i + 1) * _barWidth < size.width; i++) {
      if (i + _index >= _candles.length || i + _index < 0) continue;
      var candle = _candles[i + _index];
      paintBar(context, offset, i, candle, range);
    }
    context.canvas.save();
    context.canvas.restore();
  }
}
