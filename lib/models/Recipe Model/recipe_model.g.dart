// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_recipeModel _$$_recipeModelFromJson(Map<String, dynamic> json) =>
    _$_recipeModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      head: json['head'] as String?,
      photo: json['photo'] as String?,
      serves: json['serves'] as int?,
      totalLikes: json['totalLikes'] as int?,
      cookTime: json['cookTime'] as String?,
      text: json['text'] as String?,
      totalLike: json['totalLike'] as int?,
      items: json['items'] as List<dynamic>?,
    );

Map<String, dynamic> _$$_recipeModelToJson(_$_recipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'head': instance.head,
      'photo': instance.photo,
      'serves': instance.serves,
      'totalLikes': instance.totalLikes,
      'cookTime': instance.cookTime,
      'text': instance.text,
      'totalLike': instance.totalLike,
      'items': instance.items,
    };
