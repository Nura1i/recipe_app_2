import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/utils/theme/themes.dart';

abstract class ThemeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ThemeDark extends  ThemeState {
final AdaptiveThemeMode? mode;
  ThemeDark({ this.mode});
}

class ThemeLight extends  ThemeState {
   final AdaptiveThemeMode? mode;
ThemeLight({this.mode});
}

// AppTheme.currentSavedTheme = AppTheme.currentSavedTheme;
//     changeTheme(AdaptiveThemeMode mode) {
//     AppTheme.currentSavedTheme = mode;
//   }