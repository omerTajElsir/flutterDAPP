import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/network/i_api_request_manager.dart';

import 'models/chart_model.dart';
import 'models/chart_request_model.dart';
import 'models/chart_response_model.dart';

class ChartApiClient {
  final IApiRequestManager requestManager;

  ChartApiClient({required this.requestManager});

  Future<List<ChartCandleModel>> fetchChartData(
      ChartRequestModel requestModel) async {
    List<ChartCandleModel> chartModel = <ChartCandleModel>[];
    final result = await requestManager
        .getRequest(path: '/api/v3/klines', //path after base url,
            parameters: {
          'symbol': requestModel.symbol,
          'interval': requestModel.interval,
          'limit': requestModel.limit
        });

    List<List<dynamic>> datas = chartDataModelFromJson(jsonEncode(result));
    for (var data in datas) {
      chartModel.add(ChartCandleModel(
          openTime: DateTime.fromMillisecondsSinceEpoch(data[0]),
          open: double.parse(data[1]),
          high: double.parse(data[2]),
          low: double.parse(data[3]),
          close: double.parse(data[4]),
          volume: double.parse(data[5])));
    }
    return chartModel;
  }
}
