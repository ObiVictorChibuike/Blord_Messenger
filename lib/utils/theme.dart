import 'package:flutter/material.dart';

class CustomTheme {
  static bool isLightTheme = true;

  static ThemeData getTheme() {
    return lightTheme();
  }

  static ThemeData lightTheme() {
    Color primaryColor = Color(0xff4866F8);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: Colors.black,
      secondary: Colors.black,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: HexColor("#005CEE"),
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: const Color(0xffFFFFFF),
      canvasColor: Colors.white,
      backgroundColor: const Color(0xff0000000),
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      // textTheme: _buildTextTheme(base.textTheme),
      // primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      // accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
      cursorColor: primaryColor,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
