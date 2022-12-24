
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// Shared preferences for Localization
const String LAGUAGE_CODE ='languageCode';
const String ENGLISH='en';
const String RUSSIAN='ru';
const String UZBEK='uz';
Future<Locale> setLocale(String languageCode) async {
SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}
Future<Locale> getLocale() async {
SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? RUSSIAN;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case RUSSIAN:
      return const Locale(RUSSIAN, "");
     case UZBEK:
      return const Locale(UZBEK, " ");
    default:
      return const Locale(RUSSIAN, '');
  }
}
AppLocalizations translation(context){
  return AppLocalizations.of(context)!;
}
  