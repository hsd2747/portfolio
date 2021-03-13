import 'package:flutter/material.dart';

class CustomThemeData {
  Color mainColor;
  Color mainColorLight50;
  Color mainColorLight30;
  Color strokeColor;
  Color unSelectColor;
  Color mainTextColor;
  Color subTextColor1;
  Color subTextColor2;
  Color subTextColor3;
  Color subTextColor4;
  Color cardBackground;
  Color lightBackground;
  Color background;
  Color dividerColor;

  // flag
  bool isDark;

  CustomThemeData({
    this.mainColor,
    this.mainColorLight50,
    this.mainColorLight30,
    this.strokeColor,
    this.unSelectColor,
    this.mainTextColor,
    this.subTextColor1,
    this.subTextColor2,
    this.subTextColor3,
    this.subTextColor4,
    this.cardBackground,
    this.lightBackground,
    this.background,
    this.dividerColor,
    this.isDark,
  });

  static CustomThemeData lerp(CustomThemeData a, CustomThemeData b, double t) {
    assert(a != null);
    assert(b != null);
    assert(t != null);

    return CustomThemeData(
      mainColor: Color.lerp(a.mainColor, b.mainColor, t),
      mainColorLight50: Color.lerp(a.mainColorLight50, b.mainColorLight50, t),
      mainColorLight30: Color.lerp(a.mainColorLight30, b.mainColorLight30, t),
      strokeColor: Color.lerp(a.strokeColor, b.strokeColor, t),
      unSelectColor: Color.lerp(a.unSelectColor, b.unSelectColor, t),
      mainTextColor: Color.lerp(a.mainTextColor, b.mainTextColor, t),
      subTextColor1: Color.lerp(a.subTextColor1, b.subTextColor1, t),
      subTextColor2: Color.lerp(a.subTextColor2, b.subTextColor2, t),
      subTextColor3: Color.lerp(a.subTextColor3, b.subTextColor3, t),
      subTextColor4: Color.lerp(a.subTextColor4, b.subTextColor4, t),
      cardBackground: Color.lerp(a.cardBackground, b.cardBackground, t),
      lightBackground: Color.lerp(a.lightBackground, b.lightBackground, t),
      background: Color.lerp(a.background, b.background, t),
      dividerColor: Color.lerp(a.dividerColor, b.dividerColor, t),
      isDark: b.isDark,
    );
  }
}

class LightThemeData implements CustomThemeData {
  @override
  Color mainColor = Color(0xff0c1c62);
  @override
  Color mainColorLight50 = Color(0xff0c1c62).withOpacity(0.5);
  @override
  Color mainColorLight30 = Color(0xff0c1c62).withOpacity(0.3);
  @override
  Color strokeColor = Color(0xffbabbc2);
  @override
  Color unSelectColor = Color(0xff7f8497);
  @override
  Color mainTextColor = Color(0xff151826);
  @override
  Color subTextColor1 = Color(0xff151826).withOpacity(0.7);
  @override
  Color subTextColor2 = Color(0xff151826).withOpacity(0.5);
  @override
  Color subTextColor3 = Color(0xff151826).withOpacity(0.3);
  @override
  Color subTextColor4 = Color(0xff151826).withOpacity(0.1);
  @override
  Color cardBackground = Color(0x0d151826);
  @override
  Color lightBackground = Color(0xfff0f1f6);
  @override
  Color background = Colors.white;
  @override
  Color dividerColor = Color(0xfff5f5f5);

  @override
  bool isDark = false;
}

class DarkThemeData implements CustomThemeData {
  @override
  Color mainColor = Color(0xff4281c9);
  @override
  Color mainColorLight50 = Color(0xff4281c9).withOpacity(0.5);
  @override
  Color mainColorLight30 = Color(0x4c151826).withOpacity(0.3);
  @override
  Color strokeColor = Color(0xffbabbc2);
  @override
  Color unSelectColor = Colors.white54;
  @override
  Color mainTextColor = Colors.white;
  @override
  Color subTextColor1 = Colors.white60;
  @override
  Color subTextColor2 = Colors.white54;
  @override
  Color subTextColor3 = Colors.white38;
  @override
  Color subTextColor4 = Colors.white24;
  @override
  Color cardBackground = Colors.white12;
  @override
  Color lightBackground = Color(0xff2f2f2f);
  @override
  Color background = Color(0xff121212);
  @override
  Color dividerColor = Color(0xff2f2f2f);

  @override
  bool isDark = true;
}
