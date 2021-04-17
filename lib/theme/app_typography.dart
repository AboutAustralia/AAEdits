import 'package:flutter/cupertino.dart';
import 'package:about_australia/theme/app_colors.dart';

class AppTypography {
  static const header = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 40,
    letterSpacing: 2,
  );
  static const header2 = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 32,
    height: 0.9,
    letterSpacing: 2,
  );
  static const header3 = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 24,
    height: 0.9,
    letterSpacing: 2,
  );

  static const headerMedium = TextStyle(
    fontFamily: "Montserrat",
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 2,
  );

  static const bodySmall = TextStyle(
      letterSpacing: 2,
      fontFamily: "Montserrat",
      fontSize: 12,
      fontWeight: FontWeight.w100,
      height: 1.5);
  static const bodyNormal = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 2,
      height: 24 / 16);

  static const bodyNormal2 = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 2,
      height: 2);
  static const bodyMedium2 = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 2);
  static const bodyMedium = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 14,
      letterSpacing: 2,
      fontWeight: FontWeight.w500,
      height: 24 / 16);
  static const answerPreview = TextStyle(
      fontFamily: "Montserrat",
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.6);
}
