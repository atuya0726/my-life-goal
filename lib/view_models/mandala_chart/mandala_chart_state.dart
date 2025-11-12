import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/mandala_chart.dart';

part 'mandala_chart_state.freezed.dart';

/// マンダラチャートの状態
@freezed
class MandalaChartState with _$MandalaChartState {
  const factory MandalaChartState({
    required MandalaChart chart,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? errorMessage,
  }) = _MandalaChartState;

  factory MandalaChartState.initial() => MandalaChartState(
        chart: MandalaChart.empty(),
      );
}




