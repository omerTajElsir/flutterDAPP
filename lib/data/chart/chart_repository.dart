

import 'chart_api_client.dart';
import 'models/chart_model.dart';
import 'models/chart_request_model.dart';

class ChartRepository {
  final ChartApiClient chartApiClient;

  ChartRepository({required this.chartApiClient});

  Future<List<ChartCandleModel>> getBTCData(ChartRequestModel requestModel) async =>
      await chartApiClient.fetchChartData(requestModel);
}
