
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_state.dart';
import 'package:recipe_app/utils/theme/themes.dart';

class AdaptiveCubit extends Cubit<ThemeState> {
    AdaptiveCubit() : super(ThemeLight(mode:AppTheme.currentSavedTheme));  
    final bool _isdark=false;
    bool get isdark =>_isdark;
  changeThemeee(AdaptiveThemeMode mode){  
      if (_isdark!=isdark) {
        emit(ThemeDark(mode:AdaptiveThemeMode.dark ));
      }else{
        emit(ThemeLight(mode: AdaptiveThemeMode.light));
        
      }
    } 
   }
