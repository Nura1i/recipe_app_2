import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class userModel with _$userModel {
  const factory userModel({
    String? id,
    String? userId,
    String? bio,
    String? avatarImage,
    String? password,
    String? email,
    int? totalLikes,
    DateTime? publishedDate,
    String? text,
    String? username,
    List<Map<String, dynamic>>? saved,
    List<Map<String, dynamic>>? amountLikes,
    List<Map<String, dynamic>>? recepts,
    List<Map<String, dynamic>>? likedRecipes,
  }) = _userModel;

  factory userModel.fromJson(Map<String, dynamic> json) =>
      _$userModelFromJson(json);
}
