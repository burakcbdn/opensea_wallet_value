import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_value/services/services.export.dart';

class CustomTextField extends StatelessWidget {
  final ScreenType screenType;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    required this.screenType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Constants.primaryColor,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'ETH Address',
        hintStyle: GoogleFonts.quicksand(),
        enabledBorder: getBorder(),
        border: getBorder(),
        errorBorder: getBorder(),
        focusedBorder: getBorder(),
        disabledBorder: getBorder(),
        focusedErrorBorder: getBorder(),
        constraints: BoxConstraints(maxWidth: 600),
      ),
    );
  }
}

InputBorder getBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: Constants.primaryColor,
    ),
    borderRadius: BorderRadius.circular(20),
  );
}
