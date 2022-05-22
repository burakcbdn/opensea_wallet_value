import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet_value/models/models.export.dart';
import 'package:wallet_value/services/services.export.dart';

class FloorOptionWidget extends StatelessWidget {
  final FloorOption floorOption;
  final Function() onPressed;

  const FloorOptionWidget({
    Key? key,
    required this.floorOption,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: 25,
          constraints: BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            color: floorOption.selected ? Constants.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: floorOption.selected ? Border.fromBorderSide(BorderSide.none) : Border.all(color: Constants.primaryColor),
          ),
          child: Center(
            child: Text(
              floorOption.title,
              style: TextStyle(
                color: floorOption.selected ? Colors.white : Constants.primaryColor,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
