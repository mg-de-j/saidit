import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../groups/domain/group_model.dart'; // Voor TimestampConverter

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
class Quote with _$Quote {
  const Quote._();

  const factory Quote({
    required String id,
    required String text,
    required String saidBy, // Naam van wie het zei
    required String addedByUserId, // Wie heeft het gepost
    required String groupId,
    @TimestampConverter() required DateTime createdAt,
    @Default(0) int likes,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  @override
  // TODO: implement addedByUserId
  String get addedByUserId => throw UnimplementedError();

  @override
  // TODO: implement createdAt
  DateTime get createdAt => throw UnimplementedError();

  @override
  // TODO: implement groupId
  String get groupId => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement likes
  int get likes => throw UnimplementedError();

  @override
  // TODO: implement saidBy
  String get saidBy => throw UnimplementedError();

  @override
  // TODO: implement text
  String get text => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
