// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_userModel _$$_userModelFromJson(Map<String, dynamic> json) => _$_userModel(
      id: json['id'] as String?,
      bio: json['bio'] as String?,
      avatarImage: json['avatarImage'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      totalLikes: json['totalLikes'] as int?,
      publishedDate: json['publishedDate'] == null
          ? null
          : DateTime.parse(json['publishedDate'] as String),
      text: json['text'] as String?,
      username: json['username'] as String?,
      saved: json['saved'] as List<dynamic>?,
      amountLikes: json['amountLikes'] as List<dynamic>?,
      recepts: json['recepts'] as List<dynamic>?,
      likedRecipes: (json['likedRecipes'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_userModelToJson(_$_userModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'avatarImage': instance.avatarImage,
      'password': instance.password,
      'email': instance.email,
      'totalLikes': instance.totalLikes,
      'publishedDate': instance.publishedDate?.toIso8601String(),
      'text': instance.text,
      'username': instance.username,
      'saved': instance.saved,
      'amountLikes': instance.amountLikes,
      'recepts': instance.recepts,
      'likedRecipes': instance.likedRecipes,
    };
