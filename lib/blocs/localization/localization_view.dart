
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/blocs/localization/localization_cubit.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/language.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
Widget DropdownLocal(BuildContext context){
   LocaleCubit themeCubit=BlocProvider.of(context,listen: false);
  return  Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
      color: Colors.orange),
    child: DropdownButton(
      underline: const SizedBox(),
      icon: const Icon(
        Icons.arrow_drop_down_outlined,
      color: Colors.white,
      ),
      onChanged: (Language? language) async {   
        if (language != null) {
          Locale _locale = await setLocale(language.languageCode);
          AppProvider.setLLocale(context,_locale);
           BlocProvider.of<LocaleCubit>(context).chooseLocale(_locale);
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
                     style:const TextStyle(fontSize: 30),
                     ),
                   Text(e.name,style: Theme.of(context).textTheme.bodySmall,)
                ],
              ),
            ),
          )
      .toList(),
    ),
  );
}