
import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_state.dart';
import 'package:recipe_app/utils/theme/themes.dart';
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInit()) ;
   bool changedLight=false;
   bool changedDark=false;
 // ThemeSwitcher switcher;
    lightTheme() {   
     log('Light');
    ThemeSwitcher.withTheme(builder:(_, switcher, theme) {
       return IconButton(onPressed:() {
        switcher.changeTheme(theme: theme.brightness == Brightness.light
                              ? whiteTheme
                              : whiteTheme,);
         }, icon:Icon(Icons.brightness_3, size: 25));
     },);  
     emit(LightTheme(changedLight));
        changedLight=!changedLight;
}

    DarkkTheme() {    
       changedDark=!changedDark; 
        ThemeSwitcher.withTheme(builder:(_, switcher, theme) {
          return IconButton(onPressed:() {
            switcher.changeTheme(theme:theme.brightness == Brightness.dark
              ?darkTheme
                : darkTheme, );
             }, icon:Icon(Icons.brightness_3, size: 25));
          },);  
     emit(LightTheme(changedDark));
   log('Dark');      
}
}
 



