// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mandala_chart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MandalaChartState {
  MandalaChart get chart => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of MandalaChartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MandalaChartStateCopyWith<MandalaChartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MandalaChartStateCopyWith<$Res> {
  factory $MandalaChartStateCopyWith(
    MandalaChartState value,
    $Res Function(MandalaChartState) then,
  ) = _$MandalaChartStateCopyWithImpl<$Res, MandalaChartState>;
  @useResult
  $Res call({
    MandalaChart chart,
    bool isLoading,
    bool isSaving,
    String? errorMessage,
  });

  $MandalaChartCopyWith<$Res> get chart;
}

/// @nodoc
class _$MandalaChartStateCopyWithImpl<$Res, $Val extends MandalaChartState>
    implements $MandalaChartStateCopyWith<$Res> {
  _$MandalaChartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MandalaChartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chart = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            chart: null == chart
                ? _value.chart
                : chart // ignore: cast_nullable_to_non_nullable
                      as MandalaChart,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of MandalaChartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MandalaChartCopyWith<$Res> get chart {
    return $MandalaChartCopyWith<$Res>(_value.chart, (value) {
      return _then(_value.copyWith(chart: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MandalaChartStateImplCopyWith<$Res>
    implements $MandalaChartStateCopyWith<$Res> {
  factory _$$MandalaChartStateImplCopyWith(
    _$MandalaChartStateImpl value,
    $Res Function(_$MandalaChartStateImpl) then,
  ) = __$$MandalaChartStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    MandalaChart chart,
    bool isLoading,
    bool isSaving,
    String? errorMessage,
  });

  @override
  $MandalaChartCopyWith<$Res> get chart;
}

/// @nodoc
class __$$MandalaChartStateImplCopyWithImpl<$Res>
    extends _$MandalaChartStateCopyWithImpl<$Res, _$MandalaChartStateImpl>
    implements _$$MandalaChartStateImplCopyWith<$Res> {
  __$$MandalaChartStateImplCopyWithImpl(
    _$MandalaChartStateImpl _value,
    $Res Function(_$MandalaChartStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MandalaChartState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chart = null,
    Object? isLoading = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$MandalaChartStateImpl(
        chart: null == chart
            ? _value.chart
            : chart // ignore: cast_nullable_to_non_nullable
                  as MandalaChart,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
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

class _$MandalaChartStateImpl implements _MandalaChartState {
  const _$MandalaChartStateImpl({
    required this.chart,
    this.isLoading = false,
    this.isSaving = false,
    this.errorMessage,
  });

  @override
  final MandalaChart chart;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'MandalaChartState(chart: $chart, isLoading: $isLoading, isSaving: $isSaving, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MandalaChartStateImpl &&
            (identical(other.chart, chart) || other.chart == chart) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, chart, isLoading, isSaving, errorMessage);

  /// Create a copy of MandalaChartState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MandalaChartStateImplCopyWith<_$MandalaChartStateImpl> get copyWith =>
      __$$MandalaChartStateImplCopyWithImpl<_$MandalaChartStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MandalaChartState implements MandalaChartState {
  const factory _MandalaChartState({
    required final MandalaChart chart,
    final bool isLoading,
    final bool isSaving,
    final String? errorMessage,
  }) = _$MandalaChartStateImpl;

  @override
  MandalaChart get chart;
  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  String? get errorMessage;

  /// Create a copy of MandalaChartState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MandalaChartStateImplCopyWith<_$MandalaChartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
