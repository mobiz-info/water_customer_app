import 'package:flutter/material.dart';
import 'package:water_customer_app/utils/Common.dart';
import 'package:water_customer_app/utils/globals.dart' as globals;


class CustomColors {
  static const Color transparentColor = Colors.transparent;
  static const Color text = Color(0xFF44575B);
  static const Color containerBorder = Color(0xFFCEDCDF);
  static const Color white = Color(0xFFffffff);
  static const Color whiteOP = Color(0xCCffffff);
  static const Color homeListIconBg = Color(0xFFCCD7DA);
  static const Color datePickerBg = Color(0xFFCCD7DA);
  static const Color symbolColor = Color(0xFF75DBFB);
  static const Color gridColor = Color(0xFFEBE8F5);

  static const Color buttonGray = Color(0xFFD4D4D4);
  static const Color cardTextColor = Color(0xFF0063BF);


  static const Color textBoxBorderColor = Color(0xFFCEDCDF);

  static const Color otpTextBoxColor =Color(0x550063BF);
  static const Color snackBarSuccessColor = Colors.white;
  static const Color snackBarErrorColor = Colors.yellow;
  static Color primaryColor =  primary;
  static  Color secondaryColor = secondary;
  static  Color accentColor = accent;

  static LinearGradient lightBlueGradientNational() {
    return const LinearGradient(
      colors: [
        Color(0xFF75DBFB), // Top color
        Color(0xFF0063BF), // Bottom color
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }


  static LinearGradient lightBlueGradient() {
    return  themeGradient;
  }

  static LinearGradient lightRedGradientNational() {
    return const LinearGradient(
      colors: [
        Color(0xFFFB7575), // Top color
        Color(0xFFBF0000), // Bottom color
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static LinearGradient transparentGradient() {
    return const LinearGradient(
      colors: [
        Colors.transparent, // Top color
        Colors.transparent, // Top color

      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
  static LinearGradient lightGrayGradient() {
    return const LinearGradient(
      colors: [
        Color(0xFFEEEEEE), // Top color
        Color(0xFFCCCCCC), // Bottom color
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
  static LinearGradient lightGreenGradient() {
    return const LinearGradient(
      colors: [
        Color(0xFF68F57F), // Top color
        Color(0xFF15CE32), // Bottom color
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

class CustomThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.cardTextColor,
    scaffoldBackgroundColor: CustomColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: CustomColors.text),
      titleTextStyle: TextStyle(
        color: CustomColors.text,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: CustomColors.text),
      titleMedium: TextStyle(color: CustomColors.text),
      titleLarge: TextStyle(color: CustomColors.text),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      fillColor: CustomColors.transparentColor,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.textBoxBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.cardTextColor),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.textBoxBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    cardTheme: CardTheme(
      color: CustomColors.white,
      shadowColor: Colors.black26,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    iconTheme: IconThemeData(
      color: CustomColors.text,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: CustomColors.cardTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      fillColor: Colors.transparent,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white70),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.black,
      shadowColor: Colors.black45,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
