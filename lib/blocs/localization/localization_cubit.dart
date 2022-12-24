// class AdaptiveCubit extends Cubit<ThemeState> {
//     AdaptiveCubit() : super(ThemeLight(mode: AdaptiveThemeMode.light));  
//     final bool _isdark=false;
//     bool get isdark =>_isdark;
//   changeThemeee(AdaptiveThemeMode mode){  
//       if (_isdark!=isdark) {
//         emit(ThemeDark(mode:AdaptiveThemeMode.dark ));
//       }else{
//         emit(ThemeLight(mode: AdaptiveThemeMode.light));
//       }
//     } 
//    }
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/blocs/localization/localization_state.dart';
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit():super(InitLanguage()) ;
     Locale? _locale;
   @override
//   ssetLocale(Locale newLocale) {
//  setState(() {
//      _locale = newLocale;
//     });
//   }
Locale?locale=Locale('ru');
 void chooseLocale(Locale newLocale){
      if (newLocale==locale) {
      emit(ChooseLanguage(locale: newLocale));
     }
    }
  }
 