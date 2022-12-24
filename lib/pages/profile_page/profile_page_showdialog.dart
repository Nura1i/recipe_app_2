import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_cubit.dart';
import 'package:recipe_app/blocs/adaptive_theme/adaptive_theme_view.dart';
import 'package:recipe_app/blocs/localization/localization_view.dart';
import 'package:recipe_app/utils/theme/themes.dart';

showdialogg(context){
   AdaptiveCubit themeCubit=BlocProvider.of(context,listen: false);
     bool isdark=themeCubit.isdark;
        return showDialog(context:context,
           builder:(context) {
             return AlertDialog(
                elevation:.0,
                 titlePadding: EdgeInsets.only(left: 10,top: 10),
                    backgroundColor: Colors.white,
                      actionsPadding: EdgeInsets.all(5),
                        insetPadding: EdgeInsets.all(20),
                       shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                      title: Text('Settings',),
                  actions: [
                 Divider(height: 2,color:Colors.grey,),         
                Row(
               mainAxisAlignment: MainAxisAlignment.end,
             children: [
          Text('Theme',style: TextStyle(color: Colors.black),),
       SizedBox(width:80),
         CustomChip(
           isSelected: AppTheme.currentSavedTheme ==  AdaptiveThemeMode.light,                                     
            label: 'Light',
             icon: Icons.sunny,
                 onTap: () {
                   context.light;
                     BlocProvider.of<AdaptiveCubit>(context,).changeThemeee(AdaptiveThemeMode.light);         
                      }), 
                     SizedBox(
                   width: 5.w),
                CustomChip(
             isSelected: AppTheme.currentSavedTheme ==
          AdaptiveThemeMode.dark,
         label: 'Dark',
        icon: Icons.nightlight_round_outlined,
      onTap: () {
        context.dark;
         BlocProvider.of<AdaptiveCubit>(context,).changeThemeee(AdaptiveThemeMode.dark);
          }),
          ]),
           Divider(height: 2,color:Colors.grey,), 
             ListTile(title:Text('Loga Out',style: TextStyle(color: Colors.black))),
               Divider(height: 2,color:Colors.grey,),  
                ListTile(
                  title:Text('Language',style: TextStyle(color: Colors.black),),
                   trailing: DropdownLocal(context)
                     ),       
                     ],);});}

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