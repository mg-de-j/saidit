// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
  id: json['id'] as String,
  text: json['text'] as String,
  saidBy: json['saidBy'] as String,
  addedByUserId: json['addedByUserId'] as String,
  groupId: json['groupId'] as String,
  createdAt: const TimestampConverter().fromJson(
    json['createdAt'] as Timestamp,
  ),
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  likedBy:
      (json['likedBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  dislikedBy:
      (json['dislikedBy'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'saidBy': instance.saidBy,
  'addedByUserId': instance.addedByUserId,
  'groupId': instance.groupId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'likes': instance.likes,
  'likedBy': instance.likedBy,
  'dislikedBy': instance.dislikedBy,
};
