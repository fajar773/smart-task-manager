import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.grey.shade100,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.grey.shade900,
  );
}
