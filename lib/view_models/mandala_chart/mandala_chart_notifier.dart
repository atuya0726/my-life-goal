import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/mandala_chart_repository.dart';
import 'mandala_chart_state.dart';

/// マンダラチャートのビジネスロジック
class MandalaChartNotifier extends StateNotifier<MandalaChartState> {
  MandalaChartNotifier(this._repository) : super(MandalaChartState.initial());

  final MandalaChartRepository _repository;

  /// データを読み込む
  Future<void> load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final chart = await _repository.load();
      if (chart != null) {
        state = state.copyWith(
          chart: chart,
          isLoading: false,
        );
      } else {
        // データがない場合は空のチャートを使用
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'データの読み込みに失敗しました: $e',
      );
    }
  }

  /// データを保存する
  Future<void> save() async {
    state = state.copyWith(isSaving: true, errorMessage: null);

    try {
      await _repository.save(state.chart);
      state = state.copyWith(isSaving: false);
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'データの保存に失敗しました: $e',
      );
    }
  }

  /// 大目標を更新
  Future<void> updateCenterGoal(String newGoal) async {
    state = state.copyWith(
      chart: state.chart.updateCenterGoal(newGoal),
    );
    await save();
  }

  /// 中目標を更新
  Future<void> updateMiddleGoal(int position, String newTitle) async {
    state = state.copyWith(
      chart: state.chart.updateMiddleGoal(position, newTitle),
    );
    await save();
  }

  /// 小目標を更新
  Future<void> updateSmallGoal(
    int middlePosition,
    int smallPosition,
    String newTitle,
  ) async {
    state = state.copyWith(
      chart: state.chart.updateSmallGoal(
        middlePosition,
        smallPosition,
        newTitle,
      ),
    );
    await save();
  }

  /// チャートをリセット
  Future<void> reset() async {
    await _repository.delete();
    state = MandalaChartState.initial();
  }
}



