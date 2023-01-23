import 'package:adaptive_theme/adaptive_theme.dart';

abstract class ColorState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ColorInit extends ColorState {}

class ChangeColor extends ColorState {
  bool? change;
  ChangeColor({this.change});
}