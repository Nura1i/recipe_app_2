import 'package:flutter/cupertino.dart';

abstract class SearchState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchInit extends SearchState {}

class searched extends SearchState {
  final user;
  searched(this.user);
}

class scrolled extends SearchState {
  ScrollController controller;
  scrolled(this.controller);
}

class topContainer extends SearchState {
  final top;
  topContainer(this.top);
}

class closeContainer extends SearchState {
  final closeCon;
  closeContainer(this.closeCon);
}

class getRecipeData extends SearchState {
  final data;
  getRecipeData(this.data);
}

class onRecipeSearched extends SearchState {
  final result;
  onRecipeSearched(this.result);
}
