// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_task_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FocusTaskState {
  bool get isLoading => throw _privateConstructorUsedError;
  FocusTaskList? get focusTasks => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of FocusTaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FocusTaskStateCopyWith<FocusTaskState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FocusTaskStateCopyWith<$Res> {
  factory $FocusTaskStateCopyWith(
    FocusTaskState value,
    $Res Function(FocusTaskState) then,
  ) = _$FocusTaskStateCopyWithImpl<$Res, FocusTaskState>;
  @useResult
  $Res call({bool isLoading, FocusTaskList? focusTasks, String? errorMessage});

  $FocusTaskListCopyWith<$Res>? get focusTasks;
}

/// @nodoc
class _$FocusTaskStateCopyWithImpl<$Res, $Val extends FocusTaskState>
    implements $FocusTaskStateCopyWith<$Res> {
  _$FocusTaskStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FocusTaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? focusTasks = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            focusTasks: freezed == focusTasks
                ? _value.focusTasks
                : focusTasks // ignore: cast_nullable_to_non_nullable
                      as FocusTaskList?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of FocusTaskState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FocusTaskListCopyWith<$Res>? get focusTasks {
    if (_value.focusTasks == null) {
      return null;
    }

    return $FocusTaskListCopyWith<$Res>(_value.focusTasks!, (value) {
      return _then(_value.copyWith(focusTasks: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FocusTaskStateImplCopyWith<$Res>
    implements $FocusTaskStateCopyWith<$Res> {
  factory _$$FocusTaskStateImplCopyWith(
    _$FocusTaskStateImpl value,
    $Res Function(_$FocusTaskStateImpl) then,
  ) = __$$FocusTaskStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, FocusTaskList? focusTasks, String? errorMessage});

  @override
  $FocusTaskListCopyWith<$Res>? get focusTasks;
}

/// @nodoc
class __$$FocusTaskStateImplCopyWithImpl<$Res>
    extends _$FocusTaskStateCopyWithImpl<$Res, _$FocusTaskStateImpl>
    implements _$$FocusTaskStateImplCopyWith<$Res> {
  __$$FocusTaskStateImplCopyWithImpl(
    _$FocusTaskStateImpl _value,
    $Res Function(_$FocusTaskStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FocusTaskState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? focusTasks = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$FocusTaskStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        focusTasks: freezed == focusTasks
            ? _value.focusTasks
            : focusTasks // ignore: cast_nullable_to_non_nullable
                  as FocusTaskList?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FocusTaskStateImpl implements _FocusTaskState {
  const _$FocusTaskStateImpl({
    this.isLoading = true,
    this.focusTasks,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final FocusTaskList? focusTasks;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'FocusTaskState(isLoading: $isLoading, focusTasks: $focusTasks, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FocusTaskStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.focusTasks, focusTasks) ||
                other.focusTasks == focusTasks) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, focusTasks, errorMessage);

  /// Create a copy of FocusTaskState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FocusTaskStateImplCopyWith<_$FocusTaskStateImpl> get copyWith =>
      __$$FocusTaskStateImplCopyWithImpl<_$FocusTaskStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FocusTaskState implements FocusTaskState {
  const factory _FocusTaskState({
    final bool isLoading,
    final FocusTaskList? focusTasks,
    final String? errorMessage,
  }) = _$FocusTaskStateImpl;

  @override
  bool get isLoading;
  @override
  FocusTaskList? get focusTasks;
  @override
  String? get errorMessage;

  /// Create a copy of FocusTaskState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FocusTaskStateImplCopyWith<_$FocusTaskStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
