
import 'package:flutter/material.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/utils/shared_pref/language_prefs/language.dart';
Widget LanguageIntro(Text text1,String text2,Locale locale,BuildContext context){
   var size=MediaQuery.of(context).size;
  return   MaterialButton( 
           onPressed:() async{
             Language? language;              
               AppProvider.setLLocale(context,locale);},           
                  child: Container(
                    height: size.height/13,
                    //width: size.width/7,           
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2,color: Colors.red
                    ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                         text1,
                        SizedBox(width:size.width/30,),
                        Text(text2)
                      ],),
                    ),
                  ) ,);
}