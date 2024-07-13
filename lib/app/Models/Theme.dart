import 'package:flutter/material.dart';
import 'package:stacked_themes/stacked_themes.dart';
import '../Controllers/ThemeController.dart';
import 'package:stacked/stacked.dart';

class ThemeModel {
  final int index;
  final Color? color;

  ThemeModel({required this.index, required this.color});
}

class MultipleThemesViewModel extends BaseViewModel {
  final ThemeService _themeService = locator<ThemeService>();
  List<ThemeModel> get themes => List<ThemeModel>.generate(6, (index) => ThemeModel(index: index, color: _getColorForIndex(index)));
  Color? _getColorForIndex(int index) {
    switch (index) {
      case 0:
        return Colors.grey[100];
      case 1:
        return Colors.green[100];
      case 2:
        return Colors.purple[100];
      case 3:
        return Colors.grey[100];
      case 4:
        return Colors.grey[100];
      case 5:
        return Colors.grey[100];
    }

    return Colors.grey[100];
  }
  void setTheme(ThemeModel themeData) => _themeService.selectThemeAtIndex(themeData.index);
}