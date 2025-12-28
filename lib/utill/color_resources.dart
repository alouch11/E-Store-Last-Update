import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorResources {

  static Color getColombiaBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF678cb5) : const Color(0xFF92C6FF);
  }
  static Color getLightSkyBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFc7c7c7) : const Color(0xFF8DBFF6);
  }
  static Color getHarlequin(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF257800) : const Color(0xFF3FCC01);
  }
  static Color getCheris(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF941546) : const Color(0xFFE2206B);
  }
  static Color getTextTitle(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFFFFFFF) : const Color(0xFF000743);
  }

  static Color getMenuIconColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFFFFFFF) : Theme.of(context).primaryColor;
  }

  static Color getGrey(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF808080) : const Color(0xFFF1F1F1);
  }


  static Color getRed(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF7a1c1c) : const Color(0xFFFF5555);
  }
  static Color getYellow(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF916129) : const Color(0xFFFFAA47);
  }
  static Color getYellow1(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFF8DD31) : const Color(0xFFFAEE06);
  }

  static Color getHint(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFc7c7c7) : const Color(0xFF9E9E9E);
  }
  static Color getGainsBoro(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF999999) : const Color(0xFFE6E6E6);
  }
  static Color getTextBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF414345) : const Color(0xFFF8FBFD);
  }
  static Color getIconBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF2e2e2e) : const Color(0xFFF9F9F9);
  }
  static Color getHomeBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF3d3d3d) : const Color(0xFFFCFCFC);
  }
  static Color getImageBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF3f4347) : Theme.of(context).primaryColor;
  }
  static Color getSellerTxt(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF517091) : const Color(0xFF92C6FF);
  }
  static Color getChatIcon(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFFFFFFF) : const Color(0xFFD4D4D4);
  }
  static Color getLowGreen(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF7d8085) : const Color(0xFFEFF6FE);
  }
  static Color getGreen(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF167d3c) : const Color(0xFF23CB60);
  }
  static Color getFloatingBtn(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF49698c) : const Color(0xFF7DB6F5);
  }
  static Color getPrimary(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFf0f0f0) : Theme.of(context).primaryColor;
  }
  static Color getSearchBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF585a5c) : const Color(0xFFF4F7FC);
  }
  static Color getArrowButtonColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFBE8551) : const Color(0xFFFE8551);
  }
  static Color getReviewRattingColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFF4F7FC) : const Color(0xFF66717C);
  }
  static Color visitShop(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF393939) : const Color(0xFFE9F3FF);
  }
  static Color whiteColor (BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFF4F7FC) : const Color(0xFFF3F5F9);
  }
  static Color cartBgColor (BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFF3F9FF) : const Color(0xFFF3F9FF);
  }

  static Color chattingSenderColor (BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFF646464) : const Color(0xFFE3EDFF);
  }

  static Color couponColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFC8E4FF) : const Color(0xFFC8E4FF);
  }

  static Color debitCreditColor(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme ? const Color(0xFFC8E4FF) : const Color(0xFFC8E4FF);
  }

  static Color iconBg() {
    return Provider.of<ThemeProvider>(Get.context!).darkTheme ? Theme.of(Get.context!).primaryColor.withOpacity(.05) : const Color(0xffF9F9F9);
  }


  static const Color black = Color(0xff000000);
  static const Color white = Color(0xFFE9EEF4);
  static const Color lightSkyBlue = Color(0xff8DBFF6);
  static const Color harlequin = Color(0xff3FCC01);
  static const Color cris = Color(0xffE2206B);
  static const Color grey = Color(0xffF1F1F1);
  static const Color red = Color(0xFFD32F2F);
  static  Color primaryColor =  Theme.of(Get.context!).primaryColor;
  static const Color yellow = Color(0xFFFFAA47);
  static const Color hintTextColor = Color(0xff9E9E9E);
  static const Color gainsBg = Color(0xffE6E6E6);
  static const Color textBg = Color(0xffF3F9FF);
  static const Color homeBg = Color(0xffF0F0F0);
  static const Color imageBg = Color(0xffE2F0FF);
  static const Color sellerText = Color(0xff92C6FF);
  static const Color chatIconColor = Color(0xffD4D4D4);
  static const Color lowGreen = Color(0xffEFF6FE);
  static const Color green = Color(0xff23CB60);
  static const Color blue = Color(0xFF1455AC);

  static const Map<int, Color> colorMap = {
    50: Color(0xFEE7600),
    100: Color(0x21EE7600),
    200: Color(0x30EE7600),
    300: Color(0x40EE7600),
    400: Color(0x4FEE7600),
    500: Color(0x61EE7600),
    600: Color(0x70EE7600),
    700: Color(0x80EE7600),
    800: Color(0x8FEE7600),
    900: Color(0xfffa7c02),
  };


  static const Map<String, Color> buttonTextColorMap ={
    'pending': Color(0xff0461A5),
    'accepted': Color(0xff2B95FF),
    'ongoing': Color(0xff2B95FF),
    'completed': Color(0xff16B559),
    'canceled': Color(0xffFF3737),
    'approved': Color(0xff16B559),
    'denied':  Color(0xffFF3737),
  };

  static const Map<String, Color> buttonBackgroundColorMap ={
    'pending': Color(0xffE6EFF6),
    'accepted': Color(0xffEAF4FF),
    'ongoing': Color(0xffEAF4FF),
    'completed': Color(0xffE8F8EE),
    'canceled': Color(0xffFFEBEB),
    'approved': Color(0xffFFEBEB),
    'denied': Color(0xffFFEBEB),
  };

  static const MaterialColor primaryMaterial = MaterialColor(0xffee7600, colorMap);
  //static const MaterialColor primaryMaterial = MaterialColor(0xFF1455AC, colorMap);
}
