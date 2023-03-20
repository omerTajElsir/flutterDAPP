## Flutter DAPP

<img src="/assets/1.jpg" width="100"">


#Discription
A  Flutter application to display top tokens with prices and price change over 24h from Binance with the ability to connect wallet. I wanted to also add unit tests but the time for the test was too short as I had 2 days for the project.

#Features:
- display top tokens with prices and price change over 24h from Binance.
- show price changes on candle chart and bar chart with intervals 15m,1h,id,1w with the ability to zoom and pan.
- show open,close,high and low price.
- connect to metamask using Wallet connect plugin with the validation ot navigate to app and play store if app is not installed.
- showing Metamask wallet address after connection.
- sharing wallet address through NFC.
- listing tokens(WETH,WBTC,USDT,BNB,BUSD) balances.
- import listed tokens to wallet.

#Imported packages:
- dio: ^4.0.4
- provider: ^6.0.2
- get_it: ^7.2.0
- url_launcher: ^6.1.10
- fluttertoast: ^8.2.1
- flutter_svg: ^2.0.3
- intl: ^0.17.0
- flutter_nfc_kit: ^3.3.1
- decimal: ^2.3.0
- web3dart: ^2.3.5

#Technologies used:
- Flutter v:3.7.0
- Used provider as a state management and MVVM as a design patterns.


#Notes: 
- I only had 1 phone so I didn't get to test NFC sharing. I just wrote the code and hope it works.
- The app has not been tested on iOS because I only have window PC
- APK link : (https://drive.google.com/file/d/1_7NZRlM5bMljCTzwXTnCdZKSI1vn5H9J/view?usp=share_link)
- I didn't use any package for the chart instead I did my own custom implementation for more flexibility.
- Walletconnect dart package has an issue with importing tokens in wallet so I forked the package, did some changes and added the updated package locally.
