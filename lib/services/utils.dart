import 'package:flutter/material.dart';
import 'services.export.dart';

class Utils {
  static ScreenType getScreenType(BoxConstraints constraints) {
    double width = constraints.maxWidth;

    if (width < 480) {
      return ScreenType.MOBILE;
    } else if (width < 800) {
      return ScreenType.TABLET;
    } else if (width < 1024) {
      return ScreenType.LAPTOP;
    } else {
      return ScreenType.LARGE;
    }
  }
}
