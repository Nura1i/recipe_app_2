import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_cubit.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_theme_view.dart';
import 'package:recipe_app/blocs/localization/localization_view.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/preferences_2.dart';
import 'package:recipe_app/utils/theme/themes.dart';

showdialogg(context) {
  AdaptiveCubit themeCubit = BlocProvider.of(context, listen: false);
  bool isdark = themeCubit.isdark;
  return showDialog(
      // Settings Page
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: .0,
          titlePadding: const EdgeInsets.only(left: 10, top: 10),
          backgroundColor: Colors.white,
          actionsPadding: const EdgeInsets.all(5),
          insetPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            translation(context).settings,
          ),
          actions: [
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                translation(context).theme,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(width: 80),
              CustomChip(
                  isSelected:
                      AppTheme.currentSavedTheme == AdaptiveThemeMode.light,
                  label: translation(context).light,
                  icon: Icons.sunny,
                  onTap: () {
                    context.light;
                    BlocProvider.of<AdaptiveCubit>(
                      context,
                    ).changeThemeee(AdaptiveThemeMode.light);
                  }),
              SizedBox(width: 5.w),
              CustomChip(
                  isSelected:
                      AppTheme.currentSavedTheme == AdaptiveThemeMode.dark,
                  label: translation(context).dark,
                  icon: Icons.nightlight_round_outlined,
                  onTap: () {
                    context.dark;
                    BlocProvider.of<AdaptiveCubit>(
                      context,
                    ).changeThemeee(AdaptiveThemeMode.dark);
                  }),
            ]),
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            ListTile(
                title: Text(translation(context).logOut,
                    style: const TextStyle(color: Colors.black))),
            const Divider(
              height: 2,
              color: Colors.grey,
            ),
            ListTile(
                title: Text(
                  translation(context).language,
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: DropdownLocal(context)),
          ],
        );
      });
}

// FOR THEME
extension on BuildContext {
  get light {
    AdaptiveTheme.of(this).setLight();
  }

  get dark {
    AdaptiveTheme.of(this).setDark();
  }

  ThemeData get theme {
    return AdaptiveTheme.of(this).theme;
  }

  get changeTheme {
    if (AdaptiveTheme.of(this).mode == AdaptiveThemeMode.dark) {
      light;
    } else {
      dark;
    }
  }
}
