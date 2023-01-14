
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

abstract class ThemeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ThemeInit extends ThemeState {}

class LightTheme extends ThemeState {
  final  lightchange; 
   LightTheme(this.lightchange,);

}
class DarkTheme extends ThemeState {
  final  darkchange;
  
   DarkTheme(this.darkchange);

}

class SystemTheme extends ThemeState {
  final ThemeSwitcher  systemchange;
   SystemTheme(this.systemchange,);

}


