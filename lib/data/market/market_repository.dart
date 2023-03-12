import 'market_api_client.dart';
import 'models/market_model.dart';

class MarketRepository {
  final MarketApiClient marketApiClient;

  MarketRepository({required this.marketApiClient});

  Future<List<Market>> getMarketData() async =>
      await marketApiClient.fetchMarketData();
}
