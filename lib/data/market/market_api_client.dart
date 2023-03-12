import 'package:flutter_app/core/network/i_api_request_manager.dart';

import 'models/market_model.dart';

class MarketApiClient {
  final IApiRequestManager requestManager;

  MarketApiClient({required this.requestManager});

  Future<List<Market>> fetchMarketData() async {
    List<Market> markets = [];
    List<dynamic> list = await requestManager.getRequest(
      path: '/api/v3/ticker/24hr', parameters: {}, //path after base url,
    );

    var filteredList = list.where((element) =>
        element['symbol'].toString().contains("USDT") &&
        element['lastPrice'].toString().contains(RegExp(r'[1-9]')) &&
        (element['count'] > 54022));

    markets = filteredList.map((e) {
      return Market(
        symbol: e['symbol'],
        lastPrice: e['lastPrice'],
        priceChangePercent: e['priceChangePercent'],
      );
    }).toList();

    return markets;
  }
}
