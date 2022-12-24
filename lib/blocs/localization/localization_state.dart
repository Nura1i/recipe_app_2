import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocaleState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitLanguage  extends LocaleState{

}
class ChooseLanguage extends LocaleState{
   Locale?  locale;
  ChooseLanguage({this.locale});
}
// }
// class LanguageEnglish extends LocaleState {
//     final Locale? locale;
//   LanguageEnglish({ this.locale});
// }
// class LanguageRussian extends LocaleState {
//     final Locale? locale;
//   LanguageRussian({ this.locale});
// }
// class LanguageUzbek extends LocaleState {
//     final Locale? locale;
//   LanguageUzbek({ this.locale});
// }
