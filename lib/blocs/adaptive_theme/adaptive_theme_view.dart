
// // import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// // import 'package:flutter/material.dart';
// // import 'package:recipe_app/utils/theme/themes.dart';

// // import 'package:flutter/material.dart';
// // import 'package:flutter/src/widgets/container.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:recipe_app/pages/On%20open/into_card.dart';
// // import 'package:recipe_app/pages/profile_page/cubit_my_page/cubit_state.dart';
// // import 'package:recipe_app/pages/profile_page/cubit_my_page/page_cubit.dart';

// // class ColorPage1 extends StatefulWidget {
// //   const ColorPage1({super.key});


// //   @override
// //   State<ColorPage1> createState() => _ColorPage1State();
// // }

// // class _ColorPage1State extends State<ColorPage1> {
// //   @override
// //   Widget build(BuildContext context){ 

// //     return Scaffold(
// //       body: BlocBuilder<ColorCubit,ColorState>(builder:(context, state) {
// //      bool onchoose=false;
// //       if (state is ChangeColor) {
// //         onchoose= state.change!;
// //        return InkWell(
// //           onTap:() {
// //             BlocProvider.of<ColorCubit>(context).isOpenFun();
// //           },child: Container(width: 100,height: 100,color: onchoose==false?Colors.red:Colors.yellow,),
// //         );
// //       }  return InkWell(
// //           onTap:() {
// //             BlocProvider.of<ColorCubit>(context).isOpenFun();
// //           },child: Container(width: 100,height: 100,color: onchoose==false?Colors.red:Colors.yellow,),
// //         );
// //       },),
// //     );
// //   }
// // }

// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:recipe_app/blocs/adaptive_theme/adaptive_cubit.dart';
// import 'package:recipe_app/blocs/adaptive_theme/adaptive_state.dart';
// import 'package:recipe_app/pages/profile_page/profile_drawer_page.dart';
// import 'package:recipe_app/utils/theme/themes.dart';

// class ThemePage extends StatefulWidget {
//   const ThemePage({super.key});

//   @override
//   State<ThemePage> createState() => _ThemePageState();
// }

// var lightt;
// var darkk;
// class _ThemePageState extends State<ThemePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<ThemeCubit,ThemeState>(builder:(context, state) {
//         if (state is LightTheme) {
//          lightt = state.lightchange;
//         }
//         if(state is DarkTheme){
//           darkk= state.darkchange;
//         }
//        return ThemeBottomSheet(context, lightt);
//        //ThemeBottomSheett(context, lightt, darkk); 
//        //CustomDrawer();
       
//      //  alert(context, lightt, darkk); 
//       // alert(context,lightt,darkk);
//       },),
//     );
//   }
// }
// alert(ctx,ligt,dark){
//   return AlertDialog(actions: [
//       IconButton(onPressed: (){
//           ligt==true? BlocProvider.of<ThemeCubit>(ctx).changedLight:BlocProvider.of<ThemeCubit>(ctx).changedDark;}, icon: Icon(Icons.dark_mode)
//       )
//     // BlocProvider.of<ThemeCubit>(ctx).lightTheme(),
//     //   BlocProvider.of<ThemeCubit>(ctx).DarkkTheme()
//         ],
     
//   );
       

// }



//    ThemeBottomSheett(BuildContext context, ligt, dark) {
//     showModalBottomSheet(
//       shape:RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top:Radius.circular(20))),
//          context: context,
//           builder: (ctx) {
//             return Container(
//              height: MediaQuery.of(context).size.height * 0.30,
//                child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 10,top: 10,bottom: 20),
//                       child: Text('Theme'),),
//                 IconButton(onPressed: (){
//                   lightt==true? BlocProvider.of<ThemeCubit>(ctx).changedLight:BlocProvider.of<ThemeCubit>(ctx).changedDark;}, icon: Icon(Icons.dark_mode)),
//           // IconButton(onPressed: (){BlocProvider.of<ThemeCubit>(ctx).changedDark;}, icon: Icon(Icons.sunny))          
//                ]
//              ))
//          );         
//     });
//    }












          

   

