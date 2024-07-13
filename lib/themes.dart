import 'package:flutter/material.dart';

List<ThemeData> getThemes() {
  return [
    ThemeData(colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: Colors.grey[300])
      .copyWith(onPrimary: Colors.black)
      .copyWith(secondary: Colors.grey[100])
    ),
    ThemeData(colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: Colors.green[300])
      .copyWith(onPrimary: Colors.black)
      .copyWith(secondary: Colors.green[100])
    ),
    ThemeData(colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: Colors.purple[300])
      .copyWith(onPrimary: Colors.black)
      .copyWith(secondary: Colors.purple[100])
    ),
    ThemeData(colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: Colors.grey[300])
      .copyWith(onPrimary: Colors.black)
      .copyWith(secondary: Colors.grey[100])
    ),
    ThemeData(colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: Colors.grey[300])
      .copyWith(onPrimary: Colors.black)
      .copyWith(secondary: Colors.grey[100])
    ),
    ThemeData(colorScheme: ColorScheme.fromSwatch()
      .copyWith(primary: Colors.grey[300])
      .copyWith(onPrimary: Colors.black)
      .copyWith(secondary: Colors.grey[100])
    ),
  ];
}