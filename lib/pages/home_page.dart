import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_value/services/services.export.dart';
import 'package:wallet_value/widgets/widgets.export.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        ScreenType type = Utils.getScreenType(constraints);

        return Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
   
          ),
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Calculate your OpenSea wallet value',
                  style: TextStyle(
                    fontSize: 28,
                    color: Color(0xFF898989),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                SearchBox(
                  type: type,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
