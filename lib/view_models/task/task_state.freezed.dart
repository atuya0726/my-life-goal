// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TaskState {
  List<Task> get allTasks => throw _privateConstructorUsedError;
  List<Task> get filteredTasks => throw _privateConstructorUsedError;
  String? get selectedSmallGoalId =>
      throw _privateConstructorUsedError; // 選択中の小目標ID
  TaskPeriod get selectedPeriod => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskStateCopyWith<TaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskStateCopyWith<$Res> {
  factory $TaskStateCopyWith(TaskState value, $Res Function(TaskState) then) =
      _$TaskStateCopyWithImpl<$Res, TaskState>;
  @useResult
  $Res call({
    List<Task> allTasks,
    List<Task> filteredTasks,
    String? selectedSmallGoalId,
    TaskPeriod selectedPeriod,
    bool isLoading,
    String? errorMessage,
  });
}

/// @nodoc
class _$TaskStateCopyWithImpl<$Res, $Val extends TaskState>
    implements $TaskStateCopyWith<$Res> {
  _$TaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allTasks = null,
    Object? filteredTasks = null,
    Object? selectedSmallGoalId = freezed,
    Object? selectedPeriod = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            allTasks: null == allTasks
                ? _value.allTasks
                : allTasks // ignore: cast_nullable_to_non_nullable
                      as List<Task>,
            filteredTasks: null == filteredTasks
                ? _value.filteredTasks
                : filteredTasks // ignore: cast_nullable_to_non_nullable
                      as List<Task>,
            selectedSmallGoalId: freezed == selectedSmallGoalId
                ? _value.selectedSmallGoalId
                : selectedSmallGoalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedPeriod: null == selectedPeriod
                ? _value.selectedPeriod
                : selectedPeriod // ignore: cast_nullable_to_non_nullable
                      as TaskPeriod,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskStateImplCopyWith<$Res>
    implements $TaskStateCopyWith<$Res> {
  factory _$$TaskStateImplCopyWith(
    _$TaskStateImpl value,
    $Res Function(_$TaskStateImpl) then,
  ) = __$$TaskStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Task> allTasks,
    List<Task> filteredTasks,
    String? selectedSmallGoalId,
    TaskPeriod selectedPeriod,
    bool isLoading,
    String? errorMessage,
  });
}

/// @nodoc
class __$$TaskStateImplCopyWithImpl<$Res>
    extends _$TaskStateCopyWithImpl<$Res, _$TaskStateImpl>
    implements _$$TaskStateImplCopyWith<$Res> {
  __$$TaskStateImplCopyWithImpl(
    _$TaskStateImpl _value,
    $Res Function(_$TaskStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allTasks = null,
    Object? filteredTasks = null,
    Object? selectedSmallGoalId = freezed,
    Object? selectedPeriod = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$TaskStateImpl(
        allTasks: null == allTasks
            ? _value._allTasks
            : allTasks // ignore: cast_nullable_to_non_nullable
                  as List<Task>,
        filteredTasks: null == filteredTasks
            ? _value._filteredTasks
            : filteredTasks // ignore: cast_nullable_to_non_nullable
                  as List<Task>,
        selectedSmallGoalId: freezed == selectedSmallGoalId
            ? _value.selectedSmallGoalId
            : selectedSmallGoalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedPeriod: null == selectedPeriod
            ? _value.selectedPeriod
            : selectedPeriod // ignore: cast_nullable_to_non_nullable
                  as TaskPeriod,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TaskStateImpl implements _TaskState {
  const _$TaskStateImpl({
    final List<Task> allTasks = const [],
    final List<Task> filteredTasks = const [],
    this.selectedSmallGoalId,
    this.selectedPeriod = TaskPeriod.daily,
    this.isLoading = false,
    this.errorMessage,
  }) : _allTasks = allTasks,
       _filteredTasks = filteredTasks;

  final List<Task> _allTasks;
  @override
  @JsonKey()
  List<Task> get allTasks {
    if (_allTasks is EqualUnmodifiableListView) return _allTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allTasks);
  }

  final List<Task> _filteredTasks;
  @override
  @JsonKey()
  List<Task> get filteredTasks {
    if (_filteredTasks is EqualUnmodifiableListView) return _filteredTasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredTasks);
  }

  @override
  final String? selectedSmallGoalId;
  // 選択中の小目標ID
  @override
  @JsonKey()
  final TaskPeriod selectedPeriod;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'TaskState(allTasks: $allTasks, filteredTasks: $filteredTasks, selectedSmallGoalId: $selectedSmallGoalId, selectedPeriod: $selectedPeriod, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskStateImpl &&
            const DeepCollectionEquality().equals(other._allTasks, _allTasks) &&
            const DeepCollectionEquality().equals(
              other._filteredTasks,
              _filteredTasks,
            ) &&
            (identical(other.selectedSmallGoalId, selectedSmallGoalId) ||
                other.selectedSmallGoalId == selectedSmallGoalId) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_allTasks),
    const DeepCollectionEquality().hash(_filteredTasks),
    selectedSmallGoalId,
    selectedPeriod,
    isLoading,
    errorMessage,
  );

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskStateImplCopyWith<_$TaskStateImpl> get copyWith =>
      __$$TaskStateImplCopyWithImpl<_$TaskStateImpl>(this, _$identity);
}

abstract class _TaskState implements TaskState {
  const factory _TaskState({
    final List<Task> allTasks,
    final List<Task> filteredTasks,
    final String? selectedSmallGoalId,
    final TaskPeriod selectedPeriod,
    final bool isLoading,
    final String? errorMessage,
  }) = _$TaskStateImpl;

  @override
  List<Task> get allTasks;
  @override
  List<Task> get filteredTasks;
  @override
  String? get selectedSmallGoalId; // 選択中の小目標ID
  @override
  TaskPeriod get selectedPeriod;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of TaskState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskStateImplCopyWith<_$TaskStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
