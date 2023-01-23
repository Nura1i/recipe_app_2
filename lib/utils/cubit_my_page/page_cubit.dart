import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/utils/cubit_my_page/cubit_state.dart';
class ColorCubit extends Cubit<ColorState> {
  ColorCubit(this.isopen) : super(ColorInit());
bool isopen=false;
void isOpenFun(){
     isopen=!isopen;
  emit(ChangeColor(change: isopen));
  
}
}