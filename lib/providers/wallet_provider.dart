import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndef/ndef.dart' as ndef;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import '../utils/globals.dart';

class WalletProvider with ChangeNotifier {
  WalletProvider();

  Future<String> shareWithNFC(String address) async {
    String _writeResult = "Empty";
    try {
      NFCTag tag = await FlutterNfcKit.poll();
      if (tag.type == NFCTagType.mifare_ultralight ||
          tag.type == NFCTagType.mifare_classic ||
          tag.type == NFCTagType.iso15693 ||
          tag.type == NFCTagType.iso7816) {
        await FlutterNfcKit.writeNDEFRecords(
            [ndef.TextRecord(text: address, language: "en")]);
        return "Shared";
      } else {
        _writeResult = 'error: NDEF not supported: ${tag.type}';
        return _writeResult;
      }
    } catch (e, stacktrace) {
      _writeResult = 'error: $e';
      print(stacktrace);
      return _writeResult;
    } finally {
      await FlutterNfcKit.finish();
    }
  }

  Future<bool> connect() async {
    try {
      await globalConnector.createSession(onDisplayUri: (uri) async {
        try {
          deepLinkUri = "metamask://wc?uri=$uri";

          await launchUrl(Uri.parse(deepLinkUri),
              mode: LaunchMode.externalApplication);
        } catch (e) {
          Fluttertoast.showToast(
              msg: 'No wallet detected on your phone',
              backgroundColor: Colors.red[300]);

          if (Platform.isAndroid || Platform.isIOS) {
            final appId = Platform.isAndroid ? "io.metamask" : "1438144202";
            final url = Uri.parse(
              Platform.isAndroid
                  ? "wallet://details?id=$appId"
                  : "https://apps.apple.com/app/id$appId",
            );
            launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          }
        }
      });

      if (globalConnector.session.connected) {
        isWalletConnected = true;
        notifyListeners();
        return true;
      } else {
        isWalletConnected = false;
        notifyListeners();
        return false;
      }
    } catch (exp) {
      return false;
    }
  }

  Future<bool> addTokenToWallet(
      {required String address,
      required String symbol,
      required int decimals,
      required int chainID,
      required String image}) async {
    await launchUrlString(deepLinkUri, mode: LaunchMode.externalApplication);

    bool isSuccess = true;

    if (symbol.length > 11) {
      symbol = symbol.substring(0, 11);
    }

    Map params = {
      "type": 'ERC20',
      "options": {"address": address, "symbol": symbol, "decimals": decimals}
    };

    await globalConnector
        .sendCustomRequest(method: 'wallet_watchAsset', params: params)
        .onError((error, stackTrace) async {
      Fluttertoast.showToast(
          msg: 'Something went wrong!', backgroundColor: Colors.red[300]);

      isSuccess = false;
    });
    if (isSuccess) {
      Fluttertoast.showToast(
          msg: 'Token added', backgroundColor: Colors.green[300]);
      return true;
    }
    return false;
  }

  Future<Decimal> getBalanceErc20(String rpcUrl, String address,
      String contractAddress, int decimal) async {
    ///
    try {
      Web3Client client =
          Web3Client(rpcUrl, http.Client(), socketConnector: () {
        return IOWebSocketChannel.connect('').cast<String>();
      });
      String abiFile = await rootBundle.loadString("assets/erc20ABI.json");
      final contract = DeployedContract(
          ContractAbi.fromJson(abiFile, ''),
          //contractAddress
          EthereumAddress.fromHex(contractAddress));
      //TODO call balance of
      List<dynamic> balancePrams = [
        /*token address*/
        EthereumAddress.fromHex(address),
      ];
      var data = await client.call(
          contract: contract,
          function: contract.function('balanceOf'),
          params: balancePrams);
      BigInt balance = data[0];
      return (Decimal.fromBigInt(balance) / Decimal.one.shift(decimal))
          .toDecimal();
    } catch (e) {
      return Decimal.zero;
    }
  }

  Future<String> readNFC() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability != NFCAvailability.available) {
      // oh-no
    }

// timeout only works on Android, while the latter two messages are only for iOS
    var tag = await FlutterNfcKit.poll(
        timeout: Duration(seconds: 10),
        iosMultipleTagMessage: "Multiple tags found!",
        iosAlertMessage: "Scan your tag");

    print(jsonEncode(tag));
    String _result = "Empty";

    if (tag.standard == "ISO 14443-4 (Type B)") {
      String result1 = await FlutterNfcKit.transceive("00B0950000");
      String result2 =
          await FlutterNfcKit.transceive("00A4040009A00000000386980701");
      _result = '1: $result1\n2: $result2\n';
    } else if (tag.type == NFCTagType.iso18092) {
      String result1 = await FlutterNfcKit.transceive("060080080100");

      _result = '1: $result1\n';
    } else if (tag.type == NFCTagType.mifare_ultralight ||
        tag.type == NFCTagType.mifare_classic ||
        tag.type == NFCTagType.iso15693 ||
        tag.type == NFCTagType.iso7816) {
      var ndefRecords = await FlutterNfcKit.readNDEFRecords();
      var ndefString = '';
      for (int i = 0; i < ndefRecords.length; i++) {
        ndefString += '${i + 1}: ${ndefRecords[i]}\n';
      }
      _result = ndefString;
    } else if (tag.type == NFCTagType.webusb) {
      _result = await FlutterNfcKit.transceive("00A4040006D27600012401");
    }

// Call finish() only once
    await FlutterNfcKit.finish();
    return _result;
  }
}
