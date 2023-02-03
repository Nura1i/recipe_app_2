import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class userModel with _$userModel {
  const factory userModel({
    String? id,
    String? bio,
    String? avatarImage,
    String? password,
    String? email,
    List? totalLikes,
    DateTime? publishedDate,
    String? text,
    String? username,
    List? saved,
    List? amountLikes,
    List? recepts,
    List<Map<String, dynamic>>? likedRecipes,
  }) = _userModel;

  factory userModel.fromJson(Map<String, dynamic> json) =>
      _$userModelFromJson(json);
}
