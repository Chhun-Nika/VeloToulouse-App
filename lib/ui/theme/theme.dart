import 'dart:ui';

import 'package:flutter/material.dart';

// App Color
class AppColor {
  static Color primary = const Color(0xFFF95454);
  static Color neutralDark = const Color(0xFF393838);
  static Color neutral = const Color(0xFF868E96);
  static Color neutralLight = const Color(0xFF9A9A9A);

  static Color surface = const Color(0xFFFAFAFA);

  static Color success = const Color(0xFF44C459);

  static Color white = const Color(0xFFFFFFFF);

  // get color for text
  static Color get textNormal {
    return AppColor.neutralDark;
  }

  static Color get textLight {
    return AppColor.neutral;
  }

  static Color get textLighter {
    return AppColor.neutralLight;
  }

  static Color get iconNormal {
    return AppColor.neutral;
  }
}

//  App Text
class AppText {
  static TextStyle heading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
  static TextStyle body = TextStyle(fontSize: 16);
  static TextStyle label = TextStyle(fontSize: 13);

  static TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}

// Spacing
class AppSpacing {
  static const double s = 12;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 40;

  static const double radius = 14;
  static const double radiusLarge = 50;
}

// Gradient color
class AppGradient {
  static LinearGradient primary = LinearGradient(colors: [AppColor.primary, Color(0xFF666666)]);
}

///
/// Definition of App Theme.
///
ThemeData blaTheme = ThemeData(
  fontFamily: 'DMSans',
  scaffoldBackgroundColor: Colors.white,
);
