// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Quote {

 String get id; String get text; String get saidBy; String get addedByUserId; String get groupId;@TimestampConverter() DateTime get createdAt; int get likes; List<String> get likedBy; List<String> get dislikedBy;
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteCopyWith<Quote> get copyWith => _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quote&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.saidBy, saidBy) || other.saidBy == saidBy)&&(identical(other.addedByUserId, addedByUserId) || other.addedByUserId == addedByUserId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likes, likes) || other.likes == likes)&&const DeepCollectionEquality().equals(other.likedBy, likedBy)&&const DeepCollectionEquality().equals(other.dislikedBy, dislikedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,saidBy,addedByUserId,groupId,createdAt,likes,const DeepCollectionEquality().hash(likedBy),const DeepCollectionEquality().hash(dislikedBy));

@override
String toString() {
  return 'Quote(id: $id, text: $text, saidBy: $saidBy, addedByUserId: $addedByUserId, groupId: $groupId, createdAt: $createdAt, likes: $likes, likedBy: $likedBy, dislikedBy: $dislikedBy)';
}


}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res>  {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) = _$QuoteCopyWithImpl;
@useResult
$Res call({
 String id, String text, String saidBy, String addedByUserId, String groupId,@TimestampConverter() DateTime createdAt, int likes, List<String> likedBy, List<String> dislikedBy
});




}
/// @nodoc
class _$QuoteCopyWithImpl<$Res>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? saidBy = null,Object? addedByUserId = null,Object? groupId = null,Object? createdAt = null,Object? likes = null,Object? likedBy = null,Object? dislikedBy = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,saidBy: null == saidBy ? _self.saidBy : saidBy // ignore: cast_nullable_to_non_nullable
as String,addedByUserId: null == addedByUserId ? _self.addedByUserId : addedByUserId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,likedBy: null == likedBy ? _self.likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,dislikedBy: null == dislikedBy ? _self.dislikedBy : dislikedBy // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Quote].
extension QuotePatterns on Quote {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quote value)  $default,){
final _that = this;
switch (_that) {
case _Quote():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quote value)?  $default,){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  String saidBy,  String addedByUserId,  String groupId, @TimestampConverter()  DateTime createdAt,  int likes,  List<String> likedBy,  List<String> dislikedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.id,_that.text,_that.saidBy,_that.addedByUserId,_that.groupId,_that.createdAt,_that.likes,_that.likedBy,_that.dislikedBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  String saidBy,  String addedByUserId,  String groupId, @TimestampConverter()  DateTime createdAt,  int likes,  List<String> likedBy,  List<String> dislikedBy)  $default,) {final _that = this;
switch (_that) {
case _Quote():
return $default(_that.id,_that.text,_that.saidBy,_that.addedByUserId,_that.groupId,_that.createdAt,_that.likes,_that.likedBy,_that.dislikedBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  String saidBy,  String addedByUserId,  String groupId, @TimestampConverter()  DateTime createdAt,  int likes,  List<String> likedBy,  List<String> dislikedBy)?  $default,) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.id,_that.text,_that.saidBy,_that.addedByUserId,_that.groupId,_that.createdAt,_that.likes,_that.likedBy,_that.dislikedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quote extends Quote {
  const _Quote({required this.id, required this.text, required this.saidBy, required this.addedByUserId, required this.groupId, @TimestampConverter() required this.createdAt, this.likes = 0, final  List<String> likedBy = const [], final  List<String> dislikedBy = const []}): _likedBy = likedBy,_dislikedBy = dislikedBy,super._();
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

@override final  String id;
@override final  String text;
@override final  String saidBy;
@override final  String addedByUserId;
@override final  String groupId;
@override@TimestampConverter() final  DateTime createdAt;
@override@JsonKey() final  int likes;
 final  List<String> _likedBy;
@override@JsonKey() List<String> get likedBy {
  if (_likedBy is EqualUnmodifiableListView) return _likedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likedBy);
}

 final  List<String> _dislikedBy;
@override@JsonKey() List<String> get dislikedBy {
  if (_dislikedBy is EqualUnmodifiableListView) return _dislikedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dislikedBy);
}


/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteCopyWith<_Quote> get copyWith => __$QuoteCopyWithImpl<_Quote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quote&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.saidBy, saidBy) || other.saidBy == saidBy)&&(identical(other.addedByUserId, addedByUserId) || other.addedByUserId == addedByUserId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likes, likes) || other.likes == likes)&&const DeepCollectionEquality().equals(other._likedBy, _likedBy)&&const DeepCollectionEquality().equals(other._dislikedBy, _dislikedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,saidBy,addedByUserId,groupId,createdAt,likes,const DeepCollectionEquality().hash(_likedBy),const DeepCollectionEquality().hash(_dislikedBy));

@override
String toString() {
  return 'Quote(id: $id, text: $text, saidBy: $saidBy, addedByUserId: $addedByUserId, groupId: $groupId, createdAt: $createdAt, likes: $likes, likedBy: $likedBy, dislikedBy: $dislikedBy)';
}


}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) = __$QuoteCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, String saidBy, String addedByUserId, String groupId,@TimestampConverter() DateTime createdAt, int likes, List<String> likedBy, List<String> dislikedBy
});




}
/// @nodoc
class __$QuoteCopyWithImpl<$Res>
    implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? saidBy = null,Object? addedByUserId = null,Object? groupId = null,Object? createdAt = null,Object? likes = null,Object? likedBy = null,Object? dislikedBy = null,}) {
  return _then(_Quote(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,saidBy: null == saidBy ? _self.saidBy : saidBy // ignore: cast_nullable_to_non_nullable
as String,addedByUserId: null == addedByUserId ? _self.addedByUserId : addedByUserId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,likedBy: null == likedBy ? _self._likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,dislikedBy: null == dislikedBy ? _self._dislikedBy : dislikedBy // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
