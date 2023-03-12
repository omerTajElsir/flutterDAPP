import 'package:flutter/material.dart';
import 'package:flutter_app/core/di/locator.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';
import 'package:flutter_app/providers/chart_provider.dart';
import 'package:flutter_app/views/chart_widgets/candle_sticks.dart';
import 'package:flutter_app/views/widgets/price_bar.dart';
import 'package:provider/provider.dart';

import '../../data/chart/chart_repository.dart';
import '../../data/chart/models/chart_model.dart';
import '../../data/chart/models/chart_request_model.dart';
import '../../data/market/models/market_model.dart';

class BTCGraph extends StatefulWidget {
  final Market token;
  const BTCGraph({Key? key, required this.token}) : super(key: key);

  @override
  _BTCGraphState createState() => _BTCGraphState();
}

class _BTCGraphState extends State<BTCGraph> {
  ChartProvider _btcProvider = ChartProvider(locator<ChartRepository>());
  late ChartRequestModel requestModel;
  List<ChartCandleModel> candles = [];
  List intervals = ["15m", "1h", "1d", "1w"];
  String _currentInterval = "15m";

  void populate(String interval) async {
    requestModel = ChartRequestModel();
    _currentInterval = interval;
    requestModel.symbol = widget.token.symbol;
    requestModel.interval = interval;
    requestModel.limit = 500;
    await _btcProvider.fetchData(requestModel).then((value) {
      setState(() {
        candles.clear();
        _currentInterval = interval;
        for (int i = value.length - 1; i >= 0; i--) {
          candles.add(ChartCandleModel(
              openTime: value[i].openTime,
              high: value[i].high,
              low: value[i].low,
              open: value[i].open,
              close: value[i].close,
              volume: value[i].volume));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    populate(_currentInterval);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: Text(
          widget.token.symbol.replaceAll("USDT", ""),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),

            /// Current Price
            ///
            ///
            ChangeNotifierProvider<ChartProvider>(create: (ctx) {
              return _btcProvider;
            }, child: Consumer<ChartProvider>(builder: (ctx, data, _) {
              var state = data.getLiveData().getValue();
              if (state is Success) {
                return CurrentPrice(
                  listData: candles,
                );
              } else {
                return Container(
                  height: 40,
                );
              }
            })),

            SizedBox(
              height: 5,
            ),

            /// Charts card
            ///
            ///
            Expanded(
              child: Container(
                child: ChangeNotifierProvider<ChartProvider>(create: (ctx) {
                  return _btcProvider;
                }, child: Consumer<ChartProvider>(builder: (ctx, data, _) {
                  var state = data.getLiveData().getValue();
                  if (state is Success) {
                    for (int i = 0; i < state.data.length; i++) {
                      candles.add(ChartCandleModel(
                          openTime: state.data[i].openTime,
                          high: state.data[i].high,
                          low: state.data[i].low,
                          open: state.data[i].open,
                          close: state.data[i].close,
                          volume: state.data[i].volume));
                    }
                    return Candlesticks(
                      onIntervalChange: (String value) async {
                        populate(value);
                      },
                      candles: candles,
                      interval: _currentInterval,
                    );
                    //     },
                    //   ),
                    // );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
