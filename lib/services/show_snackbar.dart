import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String msg,
  Color? color,
  int duration = 750,
}) {
  color ??= Theme.of(context).snackBarTheme.backgroundColor;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(msg),
      backgroundColor: color,
      duration: Duration(milliseconds: duration),
    ),
  );
}