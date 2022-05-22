import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wallet_value/services/services.export.dart';
import 'package:flutter/foundation.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator.adaptive(
          backgroundColor: !kIsWeb ?  Platform.isIOS ? null : Constants.primaryColor :Constants.primaryColor ,
          valueColor:!kIsWeb ? Platform.isIOS ? null : AlwaysStoppedAnimation(Colors.white): AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
  }
}
