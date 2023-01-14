import 'package:freezed_annotation/freezed_annotation.dart';
part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class recipeModel with _$recipeModel {
  const factory recipeModel({
    String? id,
    String? userId,
    String? head,
    String? photo,
    int? serves,
    int? totalLikes,
    String? cookTime,
    String? text,
    int? totalLike,
    List? items,
  }) = _recipeModel;

  factory recipeModel.fromJson(Map<String, dynamic> json) =>
      _$recipeModelFromJson(json);
}
