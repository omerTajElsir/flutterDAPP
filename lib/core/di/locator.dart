import 'package:flutter_app/core/network/dio_request_manager.dart';
import 'package:flutter_app/core/network/i_api_request_manager.dart';
import 'package:get_it/get_it.dart';

import '../../data/chart/chart_api_client.dart';
import '../../data/chart/chart_repository.dart';
import '../../data/market/market_api_client.dart';
import '../../data/market/market_repository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<IApiRequestManager>(DioRequestManager());

  locator.registerFactory<ChartApiClient>(
      () => ChartApiClient(requestManager: locator<IApiRequestManager>()));

  locator.registerFactory<ChartRepository>(
      () => ChartRepository(chartApiClient: locator<ChartApiClient>()));

  locator.registerFactory<MarketApiClient>(
      () => MarketApiClient(requestManager: locator<IApiRequestManager>()));

  locator.registerFactory<MarketRepository>(
      () => MarketRepository(marketApiClient: locator<MarketApiClient>()));
}
