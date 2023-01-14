import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/blocs/card%20block/list_post_state.dart';
import 'package:recipe_app/repositories/services/http_service.dart';

class ListPostCubit extends Cubit<ListPostState> {
  ListPostCubit() : super(ListPostInit());

  void apiPostList() async {
    emit(
      ListPostLoading(),
    );

    final response = await Network.GET(Network.API_LIST, Network.paramsEmpty());

    if (response != null) {
      emit(ListPostLoaded(posts: Network.parsePostList(response)));
    } else {
      emit(ListPostError(error: "Couldn't fetch posts"));
    }
  }

  // List recipeOfList = [];
  // PostListOfRecipes() async {
  //   dynamic resultant = await FireDatabaseService().getRecipes();

  //   if (resultant == null) {
  //     log('Not Posted');
  //   } else {
  //     log('Post active');
  //     recipeOfList.add(resultant);
  //     emit(PostListRecipesState(recipeOfList));
  //   }
  // }
}
