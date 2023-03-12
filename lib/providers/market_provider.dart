import 'dart:async';

import 'package:flutter/material.dart';

import '../core/livedata/live_data.dart';
import '../core/livedata/ui_state.dart';
import '../data/market/market_repository.dart';
import '../data/market/models/market_model.dart';

class MarketProvider with ChangeNotifier {
  final MarketRepository marketRepository;
  MarketProvider(this.marketRepository);

  LiveData<UIState<List<Market>>> _marketData =
      LiveData<UIState<List<Market>>>();

  LiveData<UIState<List<Market>>> getLiveData() {
    return this._marketData;
  }

  Future<List<Market>> fetchData() async {
    _marketData.setValue(IsLoading());
    notifyListeners();
    try {
      List<Market> dataResult = await marketRepository.getMarketData();
      _marketData.setValue(Success(dataResult));
      notifyListeners();

      return dataResult;
    } on FormatException catch (exc) {
      _marketData.setValue(Failure(exc.message));
      throw exc;
    }
  }
}
