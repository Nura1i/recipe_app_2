// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

card _$cardFromJson(Map<String, dynamic> json) {
  return _card.fromJson(json);
}

/// @nodoc
mixin _$card {
  int? get id => throw _privateConstructorUsedError;
  String? get header => throw _privateConstructorUsedError;
  String? get about => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $cardCopyWith<card> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $cardCopyWith<$Res> {
  factory $cardCopyWith(card value, $Res Function(card) then) =
      _$cardCopyWithImpl<$Res, card>;
  @useResult
  $Res call({int? id, String? header, String? about, String? photo});
}

/// @nodoc
class _$cardCopyWithImpl<$Res, $Val extends card>
    implements $cardCopyWith<$Res> {
  _$cardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? header = freezed,
    Object? about = freezed,
    Object? photo = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      header: freezed == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as String?,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_cardCopyWith<$Res> implements $cardCopyWith<$Res> {
  factory _$$_cardCopyWith(_$_card value, $Res Function(_$_card) then) =
      __$$_cardCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? header, String? about, String? photo});
}

/// @nodoc
class __$$_cardCopyWithImpl<$Res> extends _$cardCopyWithImpl<$Res, _$_card>
    implements _$$_cardCopyWith<$Res> {
  __$$_cardCopyWithImpl(_$_card _value, $Res Function(_$_card) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? header = freezed,
    Object? about = freezed,
    Object? photo = freezed,
  }) {
    return _then(_$_card(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      header: freezed == header
          ? _value.header
          : header // ignore: cast_nullable_to_non_nullable
              as String?,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      photo: freezed == photo
          ? _value.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_card implements _card {
  const _$_card({this.id, this.header, this.about, this.photo});

  factory _$_card.fromJson(Map<String, dynamic> json) => _$$_cardFromJson(json);

  @override
  final int? id;
  @override
  final String? header;
  @override
  final String? about;
  @override
  final String? photo;

  @override
  String toString() {
    return 'card(id: $id, header: $header, about: $about, photo: $photo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_card &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.header, header) || other.header == header) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, header, about, photo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_cardCopyWith<_$_card> get copyWith =>
      __$$_cardCopyWithImpl<_$_card>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_cardToJson(
      this,
    );
  }
}

abstract class _card implements card {
  const factory _card(
      {final int? id,
      final String? header,
      final String? about,
      final String? photo}) = _$_card;

  factory _card.fromJson(Map<String, dynamic> json) = _$_card.fromJson;

  @override
  int? get id;
  @override
  String? get header;
  @override
  String? get about;
  @override
  String? get photo;
  @override
  @JsonKey(ignore: true)
  _$$_cardCopyWith<_$_card> get copyWith => throw _privateConstructorUsedError;
}
