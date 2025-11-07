// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FocusTaskList _$FocusTaskListFromJson(Map<String, dynamic> json) {
  return _FocusTaskList.fromJson(json);
}

/// @nodoc
mixin _$FocusTaskList {
  List<String> get pendingTaskIds =>
      throw _privateConstructorUsedError; // 保留のタスクID
  List<String> get dailyTaskIds =>
      throw _privateConstructorUsedError; // 今日のタスクID
  List<String> get weeklyTaskIds =>
      throw _privateConstructorUsedError; // 今週のタスクID
  List<String> get monthlyTaskIds =>
      throw _privateConstructorUsedError; // 今月のタスクID
  List<String> get yearlyTaskIds =>
      throw _privateConstructorUsedError; // 今年のタスクID
  Map<String, String> get pendingOriginalPeriods =>
      throw _privateConstructorUsedError; // 保留タスクの元の期間（taskId -> period名）
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this FocusTaskList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FocusTaskList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FocusTaskListCopyWith<FocusTaskList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FocusTaskListCopyWith<$Res> {
  factory $FocusTaskListCopyWith(
    FocusTaskList value,
    $Res Function(FocusTaskList) then,
  ) = _$FocusTaskListCopyWithImpl<$Res, FocusTaskList>;
  @useResult
  $Res call({
    List<String> pendingTaskIds,
    List<String> dailyTaskIds,
    List<String> weeklyTaskIds,
    List<String> monthlyTaskIds,
    List<String> yearlyTaskIds,
    Map<String, String> pendingOriginalPeriods,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$FocusTaskListCopyWithImpl<$Res, $Val extends FocusTaskList>
    implements $FocusTaskListCopyWith<$Res> {
  _$FocusTaskListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FocusTaskList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pendingTaskIds = null,
    Object? dailyTaskIds = null,
    Object? weeklyTaskIds = null,
    Object? monthlyTaskIds = null,
    Object? yearlyTaskIds = null,
    Object? pendingOriginalPeriods = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            pendingTaskIds: null == pendingTaskIds
                ? _value.pendingTaskIds
                : pendingTaskIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            dailyTaskIds: null == dailyTaskIds
                ? _value.dailyTaskIds
                : dailyTaskIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            weeklyTaskIds: null == weeklyTaskIds
                ? _value.weeklyTaskIds
                : weeklyTaskIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            monthlyTaskIds: null == monthlyTaskIds
                ? _value.monthlyTaskIds
                : monthlyTaskIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            yearlyTaskIds: null == yearlyTaskIds
                ? _value.yearlyTaskIds
                : yearlyTaskIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            pendingOriginalPeriods: null == pendingOriginalPeriods
                ? _value.pendingOriginalPeriods
                : pendingOriginalPeriods // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
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
abstract class _$$FocusTaskListImplCopyWith<$Res>
    implements $FocusTaskListCopyWith<$Res> {
  factory _$$FocusTaskListImplCopyWith(
    _$FocusTaskListImpl value,
    $Res Function(_$FocusTaskListImpl) then,
  ) = __$$FocusTaskListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<String> pendingTaskIds,
    List<String> dailyTaskIds,
    List<String> weeklyTaskIds,
    List<String> monthlyTaskIds,
    List<String> yearlyTaskIds,
    Map<String, String> pendingOriginalPeriods,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$FocusTaskListImplCopyWithImpl<$Res>
    extends _$FocusTaskListCopyWithImpl<$Res, _$FocusTaskListImpl>
    implements _$$FocusTaskListImplCopyWith<$Res> {
  __$$FocusTaskListImplCopyWithImpl(
    _$FocusTaskListImpl _value,
    $Res Function(_$FocusTaskListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FocusTaskList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pendingTaskIds = null,
    Object? dailyTaskIds = null,
    Object? weeklyTaskIds = null,
    Object? monthlyTaskIds = null,
    Object? yearlyTaskIds = null,
    Object? pendingOriginalPeriods = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$FocusTaskListImpl(
        pendingTaskIds: null == pendingTaskIds
            ? _value._pendingTaskIds
            : pendingTaskIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        dailyTaskIds: null == dailyTaskIds
            ? _value._dailyTaskIds
            : dailyTaskIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        weeklyTaskIds: null == weeklyTaskIds
            ? _value._weeklyTaskIds
            : weeklyTaskIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        monthlyTaskIds: null == monthlyTaskIds
            ? _value._monthlyTaskIds
            : monthlyTaskIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        yearlyTaskIds: null == yearlyTaskIds
            ? _value._yearlyTaskIds
            : yearlyTaskIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        pendingOriginalPeriods: null == pendingOriginalPeriods
            ? _value._pendingOriginalPeriods
            : pendingOriginalPeriods // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
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
class _$FocusTaskListImpl implements _FocusTaskList {
  const _$FocusTaskListImpl({
    final List<String> pendingTaskIds = const [],
    final List<String> dailyTaskIds = const [],
    final List<String> weeklyTaskIds = const [],
    final List<String> monthlyTaskIds = const [],
    final List<String> yearlyTaskIds = const [],
    final Map<String, String> pendingOriginalPeriods = const {},
    required this.updatedAt,
  }) : _pendingTaskIds = pendingTaskIds,
       _dailyTaskIds = dailyTaskIds,
       _weeklyTaskIds = weeklyTaskIds,
       _monthlyTaskIds = monthlyTaskIds,
       _yearlyTaskIds = yearlyTaskIds,
       _pendingOriginalPeriods = pendingOriginalPeriods;

  factory _$FocusTaskListImpl.fromJson(Map<String, dynamic> json) =>
      _$$FocusTaskListImplFromJson(json);

  final List<String> _pendingTaskIds;
  @override
  @JsonKey()
  List<String> get pendingTaskIds {
    if (_pendingTaskIds is EqualUnmodifiableListView) return _pendingTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingTaskIds);
  }

  // 保留のタスクID
  final List<String> _dailyTaskIds;
  // 保留のタスクID
  @override
  @JsonKey()
  List<String> get dailyTaskIds {
    if (_dailyTaskIds is EqualUnmodifiableListView) return _dailyTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyTaskIds);
  }

  // 今日のタスクID
  final List<String> _weeklyTaskIds;
  // 今日のタスクID
  @override
  @JsonKey()
  List<String> get weeklyTaskIds {
    if (_weeklyTaskIds is EqualUnmodifiableListView) return _weeklyTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weeklyTaskIds);
  }

  // 今週のタスクID
  final List<String> _monthlyTaskIds;
  // 今週のタスクID
  @override
  @JsonKey()
  List<String> get monthlyTaskIds {
    if (_monthlyTaskIds is EqualUnmodifiableListView) return _monthlyTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyTaskIds);
  }

  // 今月のタスクID
  final List<String> _yearlyTaskIds;
  // 今月のタスクID
  @override
  @JsonKey()
  List<String> get yearlyTaskIds {
    if (_yearlyTaskIds is EqualUnmodifiableListView) return _yearlyTaskIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_yearlyTaskIds);
  }

  // 今年のタスクID
  final Map<String, String> _pendingOriginalPeriods;
  // 今年のタスクID
  @override
  @JsonKey()
  Map<String, String> get pendingOriginalPeriods {
    if (_pendingOriginalPeriods is EqualUnmodifiableMapView)
      return _pendingOriginalPeriods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pendingOriginalPeriods);
  }

  // 保留タスクの元の期間（taskId -> period名）
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'FocusTaskList(pendingTaskIds: $pendingTaskIds, dailyTaskIds: $dailyTaskIds, weeklyTaskIds: $weeklyTaskIds, monthlyTaskIds: $monthlyTaskIds, yearlyTaskIds: $yearlyTaskIds, pendingOriginalPeriods: $pendingOriginalPeriods, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FocusTaskListImpl &&
            const DeepCollectionEquality().equals(
              other._pendingTaskIds,
              _pendingTaskIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._dailyTaskIds,
              _dailyTaskIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._weeklyTaskIds,
              _weeklyTaskIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._monthlyTaskIds,
              _monthlyTaskIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._yearlyTaskIds,
              _yearlyTaskIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._pendingOriginalPeriods,
              _pendingOriginalPeriods,
            ) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_pendingTaskIds),
    const DeepCollectionEquality().hash(_dailyTaskIds),
    const DeepCollectionEquality().hash(_weeklyTaskIds),
    const DeepCollectionEquality().hash(_monthlyTaskIds),
    const DeepCollectionEquality().hash(_yearlyTaskIds),
    const DeepCollectionEquality().hash(_pendingOriginalPeriods),
    updatedAt,
  );

  /// Create a copy of FocusTaskList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FocusTaskListImplCopyWith<_$FocusTaskListImpl> get copyWith =>
      __$$FocusTaskListImplCopyWithImpl<_$FocusTaskListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FocusTaskListImplToJson(this);
  }
}

abstract class _FocusTaskList implements FocusTaskList {
  const factory _FocusTaskList({
    final List<String> pendingTaskIds,
    final List<String> dailyTaskIds,
    final List<String> weeklyTaskIds,
    final List<String> monthlyTaskIds,
    final List<String> yearlyTaskIds,
    final Map<String, String> pendingOriginalPeriods,
    required final DateTime updatedAt,
  }) = _$FocusTaskListImpl;

  factory _FocusTaskList.fromJson(Map<String, dynamic> json) =
      _$FocusTaskListImpl.fromJson;

  @override
  List<String> get pendingTaskIds; // 保留のタスクID
  @override
  List<String> get dailyTaskIds; // 今日のタスクID
  @override
  List<String> get weeklyTaskIds; // 今週のタスクID
  @override
  List<String> get monthlyTaskIds; // 今月のタスクID
  @override
  List<String> get yearlyTaskIds; // 今年のタスクID
  @override
  Map<String, String> get pendingOriginalPeriods; // 保留タスクの元の期間（taskId -> period名）
  @override
  DateTime get updatedAt;

  /// Create a copy of FocusTaskList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FocusTaskListImplCopyWith<_$FocusTaskListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
