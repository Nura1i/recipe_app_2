import 'package:equatable/equatable.dart';
import 'package:recipe_app/models/Card%20Model/card_http.dart';

abstract class ListPostState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ListPostInit extends ListPostState {}

class ListPostLoading extends ListPostState {}

class ListPostLoaded extends ListPostState {
  final List<Post>? posts;

  ListPostLoaded({
    this.posts,
  });
}

class ListPostError extends ListPostState {
  final error;

  ListPostError({this.error});
}
