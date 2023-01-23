import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/utils/cubit_my_page/cubit_state.dart';
import 'package:recipe_app/utils/cubit_my_page/page_cubit.dart';
class ColorPage1 extends StatefulWidget {
  const ColorPage1({super.key});
  @override
  State<ColorPage1> createState() => _ColorPage1State();
}
class _ColorPage1State extends State<ColorPage1> {
  @override
  Widget build(BuildContext context){ 
    return Scaffold(
      body: BlocBuilder<ColorCubit,ColorState>(builder:(context, state) {
     bool onchoose=false;
      if (state is ChangeColor) {
        onchoose= state.change!;
       return InkWell(
          onTap:() {
            BlocProvider.of<ColorCubit>(context).isOpenFun();
          },child: Container(width: 100,height: 100,color: onchoose==false?Colors.red:Colors.yellow,),
        );
      }  return InkWell(
          onTap:() {
            BlocProvider.of<ColorCubit>(context).isOpenFun();
          },child: Container(width: 100,height: 100,color: onchoose==false?Colors.red:Colors.yellow,),
        );
      },),
    );
  }
}