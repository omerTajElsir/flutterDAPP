import 'package:flutter/material.dart';
import 'package:flutter_app/data/market/models/market_model.dart';
import 'package:flutter_app/providers/market_provider.dart';
import 'package:flutter_app/styles/textStyles.dart';
import 'package:provider/provider.dart';

import '../../core/di/locator.dart';
import '../../core/livedata/ui_state.dart';
import '../../data/market/market_repository.dart';
import '../widgets/home_live_prices_widget.dart';
import '../widgets/home_top_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MarketProvider _marketProvider = MarketProvider(locator<MarketRepository>());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marketProvider.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: ChangeNotifierProvider<MarketProvider>(create: (ctx) {
        return _marketProvider;
      }, child: Consumer<MarketProvider>(builder: (ctx, data, _) {
        var state = data.getLiveData().getValue();
        if (state is Success) {
          List<Market> listData = state.data;
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeTopBarWidget(),
                SizedBox(
                  height: 20,
                ),
                //HomeAvtionBarWidget(),
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 24, right: 24, top: 24),
                          child: Row(
                            children: [
                              Text(
                                "Live prices",
                                style: headingStyle,
                              ),
                            ],
                          ),
                        ),
                        HomeLivePricesWidget(livePrices: listData)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      })),
    );
  }
}
