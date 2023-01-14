
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/blocs/localization/localization_state.dart';
class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit():super(InitLanguage()) ;
     Locale? _locale;
   @override

Locale?locale=Locale('ru');
 void chooseLocale(Locale newLocale){
      if (newLocale==locale) {
      emit(ChooseLanguage(locale: newLocale));
     }
    }
  }
 