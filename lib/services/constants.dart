import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_value/models/models.export.dart';

class Constants {
  static const Color primaryColor = Color(0xFF0f8bf7);
  static const Color successColor = Color(0xFF9CE567);
  static const Color errorColor = Color(0xFFD56565);
  static TextStyle titleTextStyle = GoogleFonts.quicksand(
      textStyle: TextStyle(
    fontSize: 21,
  ));

  static TextStyle statsTextStyle = GoogleFonts.quicksand(
      textStyle: TextStyle(
    fontSize: 17,
  ));

  static TextStyle buttonText = GoogleFonts.quicksand(
      textStyle: TextStyle(
    color: Colors.white,
    fontSize: 22,
  ));

  static List<FloorOption> priceOptions = [
    FloorOption(
      title: '30 Day Average',
      selected: true,
      id: '30-day-average',
    ),
    FloorOption(
      title: '7 Day Average',
      selected: false,
      id: '7-day-average',
    ),
    FloorOption(
      title: '1 Day Average',
      selected: false,
      id: '1-day-average',
    ),
    FloorOption(
      title: 'Floor prices',
      selected: false,
      id: 'floor',
    ),
  ];
}
