import 'package:flutter/material.dart';
import 'package:flutter_app/providers/wallet_provider.dart';
import 'package:flutter_app/views/widgets/custom_widgets/loading_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../styles/textStyles.dart';
import '../../data/market/models/dropdown_items_model.dart';
import '../../utils/globals.dart';
import 'custom_widgets/alert.dart';

class HomeTopBarWidget extends StatefulWidget {
  const HomeTopBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTopBarWidget> createState() => _HomeTopBarWidgetState();
}

class _HomeTopBarWidgetState extends State<HomeTopBarWidget> {
  late DropdownItemsModel dropdownValue;

  WalletProvider _walletProvider = WalletProvider();

  String tokenBalance = "Loading..";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = dropdownItems[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isWalletConnected ? 190 : 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            height: 60,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/face.jpeg",
                  ),
                  radius: 25,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hello,",
                          style: optionStyle.copyWith(fontSize: 12),
                        ),
                        Text(
                          "John Doe",
                          style: headingStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (isWalletConnected) {
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return MyAlertDialog(
                              title: 'Disconnect',
                              confirmText: 'Disconnect',
                              content:
                                  "Your wallet will be disconnected from the app.\nAre you sure?",
                              onConfirm: () async {
                                Navigator.pop(context);
                                isWalletConnected = false;
                                setState(() {});
                              },
                            );
                          });
                    } else {
                      isWalletConnected = await _walletProvider.connect();
                      loadBalance(dropdownItems[0]);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white12,
                    radius: 25,
                    child: isWalletConnected
                        ? SvgPicture.asset(
                            "assets/connected.svg",
                            color: Colors.green,
                            width: 20,
                            height: 20,
                          )
                        : SvgPicture.asset(
                            "assets/disconnected.svg",
                            color: Colors.red,
                            width: 20,
                            height: 20,
                          ),
                  ),
                ),
              ],
            ),
          ),
          !isWalletConnected
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Address: ${globalConnector.session.accounts.first}",
                          style: optionStyle.copyWith(fontSize: 12),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
          !isWalletConnected
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            barrierColor: Colors.black45,
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder: (BuildContext buildContext,
                                Animation animation,
                                Animation secondaryAnimation) {
                              return LoadingDialog(
                                title: 'Sharing',
                                content:
                                    "Sharing your wallet address through NFC",
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                              );
                            });
                        String isShared = await _walletProvider.shareWithNFC(
                            globalConnector.session.accounts.first);
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: isShared, backgroundColor: Colors.red[300]);
                      },
                      child: Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(child: Text("Share address")),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            barrierColor: Colors.black45,
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder: (BuildContext buildContext,
                                Animation animation,
                                Animation secondaryAnimation) {
                              return LoadingDialog(
                                title: 'Reading',
                                content: "Reading wallet address through NFC",
                                onCancel: () {
                                  Navigator.pop(context);
                                },
                              );
                            });
                        String sharedAddress = await _walletProvider.readNFC();
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: sharedAddress,
                            backgroundColor: Colors.red[300]);
                      },
                      child: Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(child: Text("Reed address")),
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 10,
          ),
          !isWalletConnected
              ? Container()
              : Container(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Balance: ",
                        style: optionStyle.copyWith(fontSize: 12),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      Expanded(
                        child: Text(tokenBalance,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'Avenir-Heavy',
                                fontSize: 22,
                                color: Colors.white)),
                      ),
                      InkWell(
                        onTap: () {
                          _walletProvider.addTokenToWallet(
                              address: dropdownValue.address,
                              symbol: dropdownValue.symbol,
                              decimals: dropdownValue.decimals,
                              chainID: 1,
                              image: "");
                        },
                        child: Text(
                          "Import",
                          style: optionStyle.copyWith(
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        height: 30,
                        padding: EdgeInsets.only(left: 7, right: 7),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: DropdownButton(
                            items: new List.generate(dropdownItems.length,
                                (int index) {
                              return DropdownMenuItem(
                                value: dropdownItems[index],
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      dropdownItems[index].icon,
                                      width: 16,
                                      height: 16,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      dropdownItems[index].symbol,
                                      style: TextStyle(
                                          fontFamily: 'Avenir-Medium',
                                          fontSize: 12,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            value: dropdownValue,
                            underline: Container(),
                            onChanged: (value) async {
                              setState(() {
                                dropdownValue = value as DropdownItemsModel;
                              });
                              loadBalance(dropdownValue);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> loadBalance(DropdownItemsModel dropdownValue) async {
    tokenBalance = "Loading..";
    setState(() {});
    tokenBalance = (await _walletProvider.getBalanceErc20(
            ethRPC,
            globalConnector.session.accounts.first,
            dropdownValue.address,
            dropdownValue.decimals))
        .toString();
    setState(() {});
  }
}
