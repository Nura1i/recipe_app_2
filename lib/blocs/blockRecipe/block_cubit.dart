import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/blockRecipe/block_state.dart';
import 'package:recipe_app/repositories/services/fire_service.dart';

class blockCubit extends Cubit<blockState> {
  blockCubit() : super(blockInit());

  blockRecipeFromRules(numBlocRule) {
    emit(blockRecipe(numBlocRule));
  }

  blockRecipeFromId(recipeData, rule) async {
    await FireDatabaseService.blockRecipes(recipeData: recipeData, rule: rule);
    log('sent block id');
  }
}
