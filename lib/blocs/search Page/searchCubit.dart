import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/search%20Page/searchState.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInit());

  userSearch(user) {
    emit(searched(user));
  }

  recipeSearch(reciep) {
    emit(onRecipeSearched(reciep));
  }

  scroll(ScrollController controller, topCont, closeTopContainer) {
    controller.addListener(() {
      double value = controller.offset / 119;

      topCont = value;
      closeTopContainer = controller.offset > 50;
      // emit(scrolled(controller));

      emit(topContainer(topCont));
      emit(closeContainer(closeTopContainer));
    });
  }

  var allRecipes;
  getData() async {
    var ref = FirebaseFirestore.instance.collection('Recipes');
    allRecipes = await ref.get();

    emit(getRecipeData(allRecipes));
  }
}
