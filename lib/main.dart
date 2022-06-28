import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallet_value/pages/pages.export.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      title: 'Opensea Wallet Value',
      home: HomePage(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
    );
  }
}
