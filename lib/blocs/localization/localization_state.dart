import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocaleState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitLanguage  extends LocaleState{

}
class ChooseLanguage extends LocaleState{
   Locale?  locale;
  ChooseLanguage({this.locale});
}

