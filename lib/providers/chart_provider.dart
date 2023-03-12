import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/livedata/live_data.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';

import '../data/chart/chart_repository.dart';
import '../data/chart/models/chart_model.dart';
import '../data/chart/models/chart_request_model.dart';

class ChartProvider with ChangeNotifier {
  final ChartRepository btcRepository;
  ChartProvider(this.btcRepository);

  LiveData<UIState<List<ChartCandleModel>>> _btcData =
      LiveData<UIState<List<ChartCandleModel>>>();

  LiveData<UIState<List<ChartCandleModel>>> getLiveData() {
    return this._btcData;
  }

  Future<List<ChartCandleModel>> fetchData(ChartRequestModel requestModel) async {
    _btcData.setValue(IsLoading());
    notifyListeners();
    try {
      final dataResult = await btcRepository.getBTCData(requestModel);
      _btcData.setValue(Success(dataResult));
      notifyListeners();

      return dataResult;
    } on FormatException catch (exc) {
      _btcData.setValue(Failure(exc.message));
      throw exc;
    }
  }
}
