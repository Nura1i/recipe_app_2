import 'package:recipe_app/models/Api%20Miliy%20Taom%20Model/card_http.dart';

abstract class ListPostState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ListPostInit extends ListPostState {}

class ListPostLoading extends ListPostState {
  bool loading = true;
}

class ListPostLoaded extends ListPostState {
  final List<Post>? posts;
  final result;

  ListPostLoaded({this.posts, this.result});
}

class ListPostError extends ListPostState {
  final error;

  ListPostError({this.error});
}

class PostListRecipesState extends ListPostState {
  final lsRecipes;
  PostListRecipesState(List recipeOfList, {this.lsRecipes});
}

class TopUserData extends ListPostState {
  final data;
  TopUserData(this.data);
}
