// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SmallGoal _$SmallGoalFromJson(Map<String, dynamic> json) {
  return _SmallGoal.fromJson(json);
}

/// @nodoc
mixin _$SmallGoal {
  String get id => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError; // 0-7: ブロック内での位置
  String get title => throw _privateConstructorUsedError;
  GoalStatus get status => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;

  /// Serializes this SmallGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmallGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmallGoalCopyWith<SmallGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmallGoalCopyWith<$Res> {
  factory $SmallGoalCopyWith(SmallGoal value, $Res Function(SmallGoal) then) =
      _$SmallGoalCopyWithImpl<$Res, SmallGoal>;
  @useResult
  $Res call({
    String id,
    int position,
    String title,
    GoalStatus status,
    String memo,
  });
}

/// @nodoc
class _$SmallGoalCopyWithImpl<$Res, $Val extends SmallGoal>
    implements $SmallGoalCopyWith<$Res> {
  _$SmallGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmallGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? title = null,
    Object? status = null,
    Object? memo = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GoalStatus,
            memo: null == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmallGoalImplCopyWith<$Res>
    implements $SmallGoalCopyWith<$Res> {
  factory _$$SmallGoalImplCopyWith(
    _$SmallGoalImpl value,
    $Res Function(_$SmallGoalImpl) then,
  ) = __$$SmallGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int position,
    String title,
    GoalStatus status,
    String memo,
  });
}

/// @nodoc
class __$$SmallGoalImplCopyWithImpl<$Res>
    extends _$SmallGoalCopyWithImpl<$Res, _$SmallGoalImpl>
    implements _$$SmallGoalImplCopyWith<$Res> {
  __$$SmallGoalImplCopyWithImpl(
    _$SmallGoalImpl _value,
    $Res Function(_$SmallGoalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmallGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? title = null,
    Object? status = null,
    Object? memo = null,
  }) {
    return _then(
      _$SmallGoalImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GoalStatus,
        memo: null == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmallGoalImpl implements _SmallGoal {
  const _$SmallGoalImpl({
    required this.id,
    required this.position,
    required this.title,
    this.status = GoalStatus.notStarted,
    this.memo = '',
  });

  factory _$SmallGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmallGoalImplFromJson(json);

  @override
  final String id;
  @override
  final int position;
  // 0-7: ブロック内での位置
  @override
  final String title;
  @override
  @JsonKey()
  final GoalStatus status;
  @override
  @JsonKey()
  final String memo;

  @override
  String toString() {
    return 'SmallGoal(id: $id, position: $position, title: $title, status: $status, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmallGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, position, title, status, memo);

  /// Create a copy of SmallGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmallGoalImplCopyWith<_$SmallGoalImpl> get copyWith =>
      __$$SmallGoalImplCopyWithImpl<_$SmallGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmallGoalImplToJson(this);
  }
}

abstract class _SmallGoal implements SmallGoal {
  const factory _SmallGoal({
    required final String id,
    required final int position,
    required final String title,
    final GoalStatus status,
    final String memo,
  }) = _$SmallGoalImpl;

  factory _SmallGoal.fromJson(Map<String, dynamic> json) =
      _$SmallGoalImpl.fromJson;

  @override
  String get id;
  @override
  int get position; // 0-7: ブロック内での位置
  @override
  String get title;
  @override
  GoalStatus get status;
  @override
  String get memo;

  /// Create a copy of SmallGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmallGoalImplCopyWith<_$SmallGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MiddleGoal _$MiddleGoalFromJson(Map<String, dynamic> json) {
  return _MiddleGoal.fromJson(json);
}

/// @nodoc
mixin _$MiddleGoal {
  String get id => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError; // 0-7: 中心の周囲8方向の位置
  String get title => throw _privateConstructorUsedError;
  List<SmallGoal> get smallGoals => throw _privateConstructorUsedError;
  GoalStatus get status => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;

  /// Serializes this MiddleGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MiddleGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MiddleGoalCopyWith<MiddleGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MiddleGoalCopyWith<$Res> {
  factory $MiddleGoalCopyWith(
    MiddleGoal value,
    $Res Function(MiddleGoal) then,
  ) = _$MiddleGoalCopyWithImpl<$Res, MiddleGoal>;
  @useResult
  $Res call({
    String id,
    int position,
    String title,
    List<SmallGoal> smallGoals,
    GoalStatus status,
    String memo,
  });
}

/// @nodoc
class _$MiddleGoalCopyWithImpl<$Res, $Val extends MiddleGoal>
    implements $MiddleGoalCopyWith<$Res> {
  _$MiddleGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MiddleGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? title = null,
    Object? smallGoals = null,
    Object? status = null,
    Object? memo = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            smallGoals: null == smallGoals
                ? _value.smallGoals
                : smallGoals // ignore: cast_nullable_to_non_nullable
                      as List<SmallGoal>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GoalStatus,
            memo: null == memo
                ? _value.memo
                : memo // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MiddleGoalImplCopyWith<$Res>
    implements $MiddleGoalCopyWith<$Res> {
  factory _$$MiddleGoalImplCopyWith(
    _$MiddleGoalImpl value,
    $Res Function(_$MiddleGoalImpl) then,
  ) = __$$MiddleGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int position,
    String title,
    List<SmallGoal> smallGoals,
    GoalStatus status,
    String memo,
  });
}

/// @nodoc
class __$$MiddleGoalImplCopyWithImpl<$Res>
    extends _$MiddleGoalCopyWithImpl<$Res, _$MiddleGoalImpl>
    implements _$$MiddleGoalImplCopyWith<$Res> {
  __$$MiddleGoalImplCopyWithImpl(
    _$MiddleGoalImpl _value,
    $Res Function(_$MiddleGoalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MiddleGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? position = null,
    Object? title = null,
    Object? smallGoals = null,
    Object? status = null,
    Object? memo = null,
  }) {
    return _then(
      _$MiddleGoalImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        smallGoals: null == smallGoals
            ? _value._smallGoals
            : smallGoals // ignore: cast_nullable_to_non_nullable
                  as List<SmallGoal>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GoalStatus,
        memo: null == memo
            ? _value.memo
            : memo // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MiddleGoalImpl implements _MiddleGoal {
  const _$MiddleGoalImpl({
    required this.id,
    required this.position,
    required this.title,
    final List<SmallGoal> smallGoals = const [],
    this.status = GoalStatus.notStarted,
    this.memo = '',
  }) : _smallGoals = smallGoals;

  factory _$MiddleGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$MiddleGoalImplFromJson(json);

  @override
  final String id;
  @override
  final int position;
  // 0-7: 中心の周囲8方向の位置
  @override
  final String title;
  final List<SmallGoal> _smallGoals;
  @override
  @JsonKey()
  List<SmallGoal> get smallGoals {
    if (_smallGoals is EqualUnmodifiableListView) return _smallGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_smallGoals);
  }

  @override
  @JsonKey()
  final GoalStatus status;
  @override
  @JsonKey()
  final String memo;

  @override
  String toString() {
    return 'MiddleGoal(id: $id, position: $position, title: $title, smallGoals: $smallGoals, status: $status, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MiddleGoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(
              other._smallGoals,
              _smallGoals,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    position,
    title,
    const DeepCollectionEquality().hash(_smallGoals),
    status,
    memo,
  );

  /// Create a copy of MiddleGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MiddleGoalImplCopyWith<_$MiddleGoalImpl> get copyWith =>
      __$$MiddleGoalImplCopyWithImpl<_$MiddleGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MiddleGoalImplToJson(this);
  }
}

abstract class _MiddleGoal implements MiddleGoal {
  const factory _MiddleGoal({
    required final String id,
    required final int position,
    required final String title,
    final List<SmallGoal> smallGoals,
    final GoalStatus status,
    final String memo,
  }) = _$MiddleGoalImpl;

  factory _MiddleGoal.fromJson(Map<String, dynamic> json) =
      _$MiddleGoalImpl.fromJson;

  @override
  String get id;
  @override
  int get position; // 0-7: 中心の周囲8方向の位置
  @override
  String get title;
  @override
  List<SmallGoal> get smallGoals;
  @override
  GoalStatus get status;
  @override
  String get memo;

  /// Create a copy of MiddleGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MiddleGoalImplCopyWith<_$MiddleGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
