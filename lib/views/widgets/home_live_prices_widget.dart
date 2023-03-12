import 'package:flutter/material.dart';
import 'package:flutter_app/utils/helper_functions.dart';
import 'package:flutter_app/views/pages/btc_graph.dart';

import '../../../../styles/textStyles.dart';
import '../../data/market/models/market_model.dart';

class HomeLivePricesWidget extends StatefulWidget {
  final List<Market> livePrices;
  const HomeLivePricesWidget({Key? key, required this.livePrices})
      : super(key: key);

  @override
  _HomeLivePricesWidgetState createState() => _HomeLivePricesWidgetState();
}

class _HomeLivePricesWidgetState extends State<HomeLivePricesWidget> {
  late List<Market> livePrices;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    livePrices = widget.livePrices;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: livePrices.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext ctxt, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BTCGraph(
                              token: livePrices[index],
                            )));
              },
              child: Container(
                height: 80,
                margin: EdgeInsets.only(left: 24, right: 24),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white12,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          coinLogos.contains(livePrices[index].symbol)
                              ? AssetImage(
                                  'assets/logo/${livePrices[index].symbol}.png',
                                )
                              : AssetImage("assets/empty.png"),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          livePrices[index].symbol.replaceAll("USDT", ""),
                          style: optionStyle,
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$" +
                              HelperFunctions.priceToString(
                                  double.parse(livePrices[index].lastPrice)),
                          style: primaryButtonStyle,
                        ),
                        Row(
                          children: [
                            Icon(
                              double.parse(livePrices[index]
                                          .priceChangePercent) >
                                      0
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: double.parse(livePrices[index]
                                          .priceChangePercent) >
                                      0
                                  ? Colors.green
                                  : Colors.red,
                              size: 16,
                            ),
                            Text(livePrices[index].priceChangePercent + "%",
                                style: TextStyle(
                                    fontFamily: 'Avenir-Heavy',
                                    fontSize: 16,
                                    color: double.parse(livePrices[index]
                                                .priceChangePercent) >
                                            0
                                        ? Colors.green
                                        : Colors.red)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
