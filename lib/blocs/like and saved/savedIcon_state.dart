import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/Api%20Miliy%20Taom%20Model/card_http.dart';

abstract class SavedState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SavedInit extends SavedState {}

class SavedSuccess extends SavedState {
  final success;
  SavedSuccess(this.success);
}
