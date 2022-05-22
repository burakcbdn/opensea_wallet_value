import 'package:flutter/material.dart';
import 'package:wallet_value/pages/pages.export.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(WalletValueApp());
}

class WalletValueApp extends StatefulWidget {
  const WalletValueApp({Key? key}) : super(key: key);

  @override
  State<WalletValueApp> createState() => _WalletValueAppState();
}

class _WalletValueAppState extends State<WalletValueApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
    );
  }
}
