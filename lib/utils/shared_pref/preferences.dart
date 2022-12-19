import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' as ShP;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Prefs {
  ///save data
  static Future<bool?> saveData<T>(
      {required String? key, required T? data}) async {
    final prefs = await ShP.SharedPreferences.getInstance();
    switch (T) {
      case String:
        return prefs.setString(key!, data as String);
      case int:
        return prefs.setInt(key!, data as int);
      case double:
        return prefs.setDouble(key!, data as double);
      case bool:
        return prefs.setBool(key!, data as bool);
      case List<String>:
        return prefs.setStringList(key!, data as List<String>);
      case Map<String, dynamic>:
        String? dataString = jsonEncode(data!);
        return prefs.setString(key!, dataString);
    }
    return null;
  }

  ///load data
  static Future<T> loadData<T>({required String? key}) async {
    final prefs = await ShP.SharedPreferences.getInstance();
    if (T is Map<String, dynamic>) {
      final String data = prefs.get(key!) as String;
      return jsonDecode(data);
    }
    return prefs.get(key!) as T;
  }

  ///update data
  static Future<bool?> updateData<T>(
      {required String? key, required T? data}) async {
    final prefs = await ShP.SharedPreferences.getInstance();
    if (prefs.containsKey(key!) && prefs.get(key) != null) {
      await deleteData(key: key);
    }
    return saveData(key: key, data: data);
  }

  ///delete data
  static Future<bool?> deleteData({required String? key}) async {
    final prefs = await ShP.SharedPreferences.getInstance();
    return prefs.remove(key!);
  }
}








// Shared preferences for Localization

const String Language_code='languagecode';
const String ENGLISH='en';
const String RUSSIAN='ru';
const String UZBEK='uz';

Future<Locale> setLocale(String languageCode) async {
  ShP.SharedPreferences _prefs = await ShP.SharedPreferences.getInstance();
  await _prefs.setString(Language_code, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  ShP.SharedPreferences _prefs = await ShP.SharedPreferences.getInstance();
  String languageCode = _prefs.getString(Language_code) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case RUSSIAN:
      return const Locale(RUSSIAN, "");
     case UZBEK:
      return const Locale(UZBEK, "");
    default:
      return const Locale(ENGLISH, '');
  }
}

AppLocalizations translation(BuildContext context){
  return AppLocalizations.of(context)!;
}

