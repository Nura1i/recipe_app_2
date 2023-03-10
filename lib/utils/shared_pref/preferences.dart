import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipe_app/utils/theme/theme_configg.dart';
import 'package:shared_preferences/shared_preferences.dart' as ShP;

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
    const CircularProgressIndicator();
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

/////////////////////////////////////////////
class ThemeService {
  ThemeService._();
  static late ShP.SharedPreferences prefs;
  static ThemeService? _instance;

  static Future<ThemeService> get instance async {
    
    if (_instance == null) {
     
      prefs = await ShP.SharedPreferences.getInstance();
      _instance = ThemeService._();
    }
    return _instance!;
  }

  final allThemes = <String, ThemeData>{
    'dark': AppTTheme.darkkTheme,
    'light': AppTTheme.whiteeTheme
  };

  String get previousThemeName {
    String? themeName = prefs.getString('previousThemeName');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'light' : 'dark';
    }
    return themeName;
  }

  get initial {
    String? themeName = prefs.getString('theme');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'dark' : 'light';
    }
    return allThemes[themeName.toString()];
  }

  save(String newThemeName) {
    var currentThemeName = prefs.getString('theme');
    if (currentThemeName != null) {
      log('!null');
      prefs.setString('previousThemeName', currentThemeName);
    }
    prefs.setString('theme', newThemeName);
    log('Saved your theme');
  }

  ThemeData getByName(String name) {
    return allThemes[name]!;
  }
}
