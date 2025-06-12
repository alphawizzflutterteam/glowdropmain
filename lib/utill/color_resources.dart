import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorResources {
  static Color getColombiaBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF678cb5)
        : const Color(0xFF92C6FF);
  }

  static Color getSecondary(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFE50019)
        : const Color(0xFFE50019);
  }

  static Color getLightSkyBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFc7c7c7)
        : const Color(0xFF8DBFF6);
  }

  static Color getHarlequin(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF257800)
        : const Color(0xFF3FCC01);
  }

  static Color getCheris(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF941546)
        : const Color(0xFFE2206B);
  }

  static Color getTextTitle(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF000743);
  }

  static Color getGrey(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF808080)
        : const Color(0xFFF1F1F1);
  }

  static Color getRed(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF7a1c1c)
        : const Color(0xFFFF5555);
  }

  static Color getYellow(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF916129)
        : const Color(0xFFFFAA47);
  }

  static Color getHint(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFc7c7c7)
        : const Color(0xFF9E9E9E);
  }

  static Color getGainsBoro(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF999999)
        : const Color(0xFFE6E6E6);
  }

  static Color getTextBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF414345)
        : const Color(0xFFF8FBFD);
  }

  static Color getIconBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF2e2e2e)
        : const Color(0xFFF9F9F9);
  }

  static Color getHomeBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFF4F1EC)
        : const Color(0xFFF4F1EC);
  }

  static Color getImageBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF3f4347)
        : const Color(0xFFE2F0FF);
  }

  static Color getSellerTxt(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF517091)
        : const Color(0xFF92C6FF);
  }

  static Color getChatIcon(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFebebeb)
        : const Color(0xFFD4D4D4);
  }

  static Color getLowGreen(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF7d8085)
        : const Color(0xFFEFF6FE);
  }

  static Color getGreen(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF167d3c)
        : const Color(0xFF23CB60);
  }

  static Color getFloatingBtn(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF49698c)
        : const Color(0xFF7DB6F5);
  }

  static Color getPrimary(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFf0f0f0)
        : Theme.of(context).primaryColor;
  }

  static Color getSearchBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFF585a5c)
        : const Color(0xFFF4F7FC);
  }

  static Color getArrowButtonColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFBE8551)
        : const Color(0xFFFE8551);
  }

  static Color getReviewRattingColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFF4F7FC)
        : const Color(0xFF66717C);
  }

  static Color visitShop(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFF4F7FC)
        : const Color(0xFFF3F5F9);
  }

  static Color couponColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFC8E4FF)
        : const Color(0xFFC8E4FF);
  }

  static Color debitCreditColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? const Color(0xFFC8E4FF)
        : const Color(0xFFC8E4FF);
  }
// lib/constants/app_colors.dart

  static const Color primary = Color(0xFF245D5F);         // Example purple
  static const Color dividercolor = Color(0xFFFFC107);       // Amber
  static const Color loginText = Color(0xFF716C6C);       // Light gray
  static const Color textPrimary = Color(0xFF212121);      // Dark gray
  static const Color textcolor = Color(0xFF787878);    // Medium gray
  static const Color backGroundcolor = Color(0xFFF4F1EC);           // Cyan
  static const Color pc = Color(0xFF9DC5C5);            // Red
  static const Color pinkcl = Color(0xFFF5DFD4);          // Green
  static const Color greencl = Color(0xFFD7E8D2);          // Green
  static const Color discountc = Color(0xFFFF4A4A);          // Green



  static const Color black = Color(0xff000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color lightSkyBlue = Color(0xff8DBFF6);
  static const Color harlequin = Color(0xff3FCC01);
  static const Color cris = Color(0xffE2206B);
  static const Color grey = Color(0xffF1F1F1);
  static const Color red = Color(0xFFD32F2F);
  static const Color redLight = Color(0xFFE50019);
  static const Color redFDark = Color(0xFFBF3526);
  static const Color yellow = Color(0xFFFFAA47);
  static const Color hintTextColor = Color(0xff9E9E9E);
  static const Color gainsBg = Color(0xffE6E6E6);
  static const Color textBg = Color(0xffF3F9FF);
  static const Color iconBg = Color(0xffF9F9F9);
  static const Color homeBg = Color(0xffF0F0F0);
  static const Color imageBg = Color(0xffE2F0FF);
  static const Color sellerText = Color(0xff92C6FF);
  static const Color chatIconColor = Color(0xffD4D4D4);
  static const Color lowGreen = Color(0xffEFF6FE);
  static const Color green = Color(0xff23CB60);
  static const Color secondryPrimaryColor = Color(0xff245D5F);

  static const Map<int, Color> colorMap = {
    50: Color(0x20002643),
    100: Color(0x33002643),
    200: Color(0x46002643),
    300: Color(0x59002643),
    400: Color(0x6C002643),
    500: Color(0x80002643),
    600: Color(0x99002643),
    700: Color(0xB2002643),
    800: Color(0xCC002643),
    900: Color(0xE5002643)
  };

  static const MaterialColor primaryMaterial =
      MaterialColor(0xff0007a3, colorMap);
}
