import 'package:flutter/material.dart';

class MyTheme {
  MyTheme(
      {this.name,
      this.brightness,
      this.backgroundColor,
      this.scaffoldBackgroundColor,
      this.primaryColor,
      this.primaryColorBrightness,
      this.accentColor,
        this.bottomAppBarColor,
        this.dividerColor,
        this.buttonColor,
        this.secondaryHeaderColor,
        this.cardColor
      });

  String name;
  Brightness brightness;
  Color backgroundColor;
  Color scaffoldBackgroundColor;
  Color primaryColor;
  Brightness primaryColorBrightness;
  Color accentColor;
  Color bottomAppBarColor;
  Color dividerColor;
  Color buttonColor;
  Color secondaryHeaderColor;
  Color cardColor;


}
