import 'package:flutter/material.dart';
import 'package:flutter_app/styles/theme.dart';
import 'package:flutter_app/views/pages/home_page.dart';

import 'core/di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: HomePage(),
    );
  }
}
