// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mandala_chart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MandalaChart _$MandalaChartFromJson(Map<String, dynamic> json) {
  return _MandalaChart.fromJson(json);
}

/// @nodoc
mixin _$MandalaChart {
  String get id => throw _privateConstructorUsedError;
  String get centerGoal => throw _privateConstructorUsedError; // 大目標（中心の中心）
  List<MiddleGoal> get middleGoals =>
      throw _privateConstructorUsedError; // 8つの中目標
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MandalaChart to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MandalaChart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MandalaChartCopyWith<MandalaChart> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MandalaChartCopyWith<$Res> {
  factory $MandalaChartCopyWith(
    MandalaChart value,
    $Res Function(MandalaChart) then,
  ) = _$MandalaChartCopyWithImpl<$Res, MandalaChart>;
  @useResult
  $Res call({
    String id,
    String centerGoal,
    List<MiddleGoal> middleGoals,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$MandalaChartCopyWithImpl<$Res, $Val extends MandalaChart>
    implements $MandalaChartCopyWith<$Res> {
  _$MandalaChartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MandalaChart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? centerGoal = null,
    Object? middleGoals = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            centerGoal: null == centerGoal
                ? _value.centerGoal
                : centerGoal // ignore: cast_nullable_to_non_nullable
                      as String,
            middleGoals: null == middleGoals
                ? _value.middleGoals
                : middleGoals // ignore: cast_nullable_to_non_nullable
                      as List<MiddleGoal>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MandalaChartImplCopyWith<$Res>
    implements $MandalaChartCopyWith<$Res> {
  factory _$$MandalaChartImplCopyWith(
    _$MandalaChartImpl value,
    $Res Function(_$MandalaChartImpl) then,
  ) = __$$MandalaChartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String centerGoal,
    List<MiddleGoal> middleGoals,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$MandalaChartImplCopyWithImpl<$Res>
    extends _$MandalaChartCopyWithImpl<$Res, _$MandalaChartImpl>
    implements _$$MandalaChartImplCopyWith<$Res> {
  __$$MandalaChartImplCopyWithImpl(
    _$MandalaChartImpl _value,
    $Res Function(_$MandalaChartImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MandalaChart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? centerGoal = null,
    Object? middleGoals = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$MandalaChartImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        centerGoal: null == centerGoal
            ? _value.centerGoal
            : centerGoal // ignore: cast_nullable_to_non_nullable
                  as String,
        middleGoals: null == middleGoals
            ? _value._middleGoals
            : middleGoals // ignore: cast_nullable_to_non_nullable
                  as List<MiddleGoal>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MandalaChartImpl extends _MandalaChart {
  const _$MandalaChartImpl({
    required this.id,
    required this.centerGoal,
    final List<MiddleGoal> middleGoals = const [],
    required this.createdAt,
    required this.updatedAt,
  }) : _middleGoals = middleGoals,
       super._();

  factory _$MandalaChartImpl.fromJson(Map<String, dynamic> json) =>
      _$$MandalaChartImplFromJson(json);

  @override
  final String id;
  @override
  final String centerGoal;
  // 大目標（中心の中心）
  final List<MiddleGoal> _middleGoals;
  // 大目標（中心の中心）
  @override
  @JsonKey()
  List<MiddleGoal> get middleGoals {
    if (_middleGoals is EqualUnmodifiableListView) return _middleGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_middleGoals);
  }

  // 8つの中目標
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'MandalaChart(id: $id, centerGoal: $centerGoal, middleGoals: $middleGoals, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MandalaChartImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.centerGoal, centerGoal) ||
                other.centerGoal == centerGoal) &&
            const DeepCollectionEquality().equals(
              other._middleGoals,
              _middleGoals,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    centerGoal,
    const DeepCollectionEquality().hash(_middleGoals),
    createdAt,
    updatedAt,
  );

  /// Create a copy of MandalaChart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MandalaChartImplCopyWith<_$MandalaChartImpl> get copyWith =>
      __$$MandalaChartImplCopyWithImpl<_$MandalaChartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MandalaChartImplToJson(this);
  }
}

abstract class _MandalaChart extends MandalaChart {
  const factory _MandalaChart({
    required final String id,
    required final String centerGoal,
    final List<MiddleGoal> middleGoals,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$MandalaChartImpl;
  const _MandalaChart._() : super._();

  factory _MandalaChart.fromJson(Map<String, dynamic> json) =
      _$MandalaChartImpl.fromJson;

  @override
  String get id;
  @override
  String get centerGoal; // 大目標（中心の中心）
  @override
  List<MiddleGoal> get middleGoals; // 8つの中目標
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of MandalaChart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MandalaChartImplCopyWith<_$MandalaChartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
