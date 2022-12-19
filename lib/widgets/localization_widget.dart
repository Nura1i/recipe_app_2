

import 'package:flutter/material.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/utils/shared_pref/language.dart';
import 'package:recipe_app/utils/shared_pref/preferences.dart';

// ignore: non_constant_identifier_names
Widget DropdownLocalization(BuildContext context,){
  return  DropdownButton(
                underline: const SizedBox(),
                icon: const Icon(
                  Icons.language,
                  color: Colors.red,
                ),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale _locale = await setLocale(language.languageCode);
                    AppProvider.setLocale(context,_locale);
                  }
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Text(e.name)
                          ],
                        ),
                      ),
                    )
                 .toList()
              );
}


