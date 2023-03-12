import 'package:walletconnect_dart/walletconnect_dart.dart';

import '../data/market/models/dropdown_items_model.dart';

/// Token list variables
List dropdownItems = [
  const DropdownItemsModel('WETH', "assets/logo/ETHUSDT.png",
      "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2", 18),
  const DropdownItemsModel('WBTC', "assets/logo/BTCUSDT.png",
      "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599", 8),
  const DropdownItemsModel('USDT', "assets/logo/usdt.png",
      "0xdAC17F958D2ee523a2206206994597C13D831ec7", 6),
  const DropdownItemsModel('BNB', "assets/logo/BNBUSDT.png",
      "0xB8c77482e45F1F44dE1745F52C74426C631bDD52", 18),
  const DropdownItemsModel('BUSD', "assets/logo/BUSDUSDT.png",
      "0x4Fabb145d64652a948d72533023f6E7A623C7C53", 18),
];

const List<String> coinLogos = [
  "BTCUSDT",
  "ADAUSDT",
  "ATOMUSDT",
  "AVAXUSDT",
  "BNBUSDT",
  "BUSDUSDT",
  "DARUSDT",
  "DOGEUSDT",
  "ETHUSDT",
  "FETUSDT",
  "FTMUSDT",
  "LINKUSDT",
  "LTCUSDT",
  "MATICUSDT",
  "NEARUSDT",
  "OPUSDT",
  "SANDUSDT",
  "SCUSDT",
  "SHIBUSDT",
  "SOLUSDT",
  "STORJUSDT",
  "TRXUSDT",
  "WAVEUSDT",
  "XRPUSDT",
];

/// wallet connection variables
String ethRPC = "https://eth.llamarpc.com";
bool isWalletConnected = false;

String deepLinkUri = "";

WalletConnect globalConnector = WalletConnect(
  bridge: 'https://bridge.walletconnect.org',
  //create on uuid for each user
  clientMeta: const PeerMeta(
    name: 'Test application',
    description: 'Your favorite trading app want to connect to your wallet',
    url: 'https://test.vai.com',
    icons: [],
  ),
);
