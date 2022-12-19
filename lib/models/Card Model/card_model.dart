import 'package:freezed_annotation/freezed_annotation.dart';
part 'card_model.freezed.dart';
part 'card_model.g.dart';

@freezed
class card with _$card {
  const factory card({int? id, String? header, String? about, String? photo}) =
      _card;

  factory card.fromJson(Map<String, dynamic> json) => _$cardFromJson(json);
}
