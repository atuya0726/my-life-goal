import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/focus_task.dart';
import '../../repositories/focus_task_repository.dart';
import 'focus_task_state.dart';

/// フォーカスタスクNotifier
class FocusTaskNotifier extends StateNotifier<FocusTaskState> {
  final FocusTaskRepository _repository;

  FocusTaskNotifier(
    this._repository,
  ) : super(const FocusTaskState()) {
    load();
  }

  /// フォーカスタスクを読み込む
  Future<void> load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final focusTasks = await _repository.loadFocusTasks();
      state = state.copyWith(focusTasks: focusTasks, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'フォーカスタスクの読み込みに失敗しました: $e',
        isLoading: false,
      );
    }
  }

  /// 指定された期間のタスクIDリストを取得
  List<String> _getTaskIdsByPeriod(FocusPeriod period) {
    final focusTasks = state.focusTasks;
    if (focusTasks == null) return [];
    
    switch (period) {
      case FocusPeriod.pending:
        return focusTasks.pendingTaskIds;
      case FocusPeriod.awareness:
        return focusTasks.awarenessTaskIds;
      case FocusPeriod.daily:
        return focusTasks.dailyTaskIds;
      case FocusPeriod.weekly:
        return focusTasks.weeklyTaskIds;
      case FocusPeriod.monthly:
        return focusTasks.monthlyTaskIds;
      case FocusPeriod.yearly:
        return focusTasks.yearlyTaskIds;
    }
  }

  /// タスクを指定期間に追加
  Future<void> addTask(String taskId, FocusPeriod period) async {
    try {
      final focusTasks = state.focusTasks ?? FocusTaskList.empty();
      
      // すべての期間から重複をチェック・削除
      final pendingIds = List<String>.from(focusTasks.pendingTaskIds)..remove(taskId);
      final dailyIds = List<String>.from(focusTasks.dailyTaskIds)..remove(taskId);
      final weeklyIds = List<String>.from(focusTasks.weeklyTaskIds)..remove(taskId);
      final monthlyIds = List<String>.from(focusTasks.monthlyTaskIds)..remove(taskId);
      final yearlyIds = List<String>.from(focusTasks.yearlyTaskIds)..remove(taskId);
      final awarenessIds = List<String>.from(focusTasks.awarenessTaskIds)..remove(taskId);
      
      // 指定期間に追加
      switch (period) {
        case FocusPeriod.pending:
          pendingIds.add(taskId);
          break;
        case FocusPeriod.awareness:
          awarenessIds.add(taskId);
          break;
        case FocusPeriod.daily:
          dailyIds.add(taskId);
          break;
        case FocusPeriod.weekly:
          weeklyIds.add(taskId);
          break;
        case FocusPeriod.monthly:
          monthlyIds.add(taskId);
          break;
        case FocusPeriod.yearly:
          yearlyIds.add(taskId);
          break;
      }
      
      final updatedFocusTasks = FocusTaskList(
        pendingTaskIds: pendingIds,
        dailyTaskIds: dailyIds,
        weeklyTaskIds: weeklyIds,
        monthlyTaskIds: monthlyIds,
        yearlyTaskIds: yearlyIds,
        awarenessTaskIds: awarenessIds,
        updatedAt: DateTime.now(),
      );
      await _repository.saveFocusTasks(updatedFocusTasks);
      state = state.copyWith(focusTasks: updatedFocusTasks);
    } catch (e) {
      state = state.copyWith(errorMessage: 'タスクの追加に失敗しました: $e');
    }
  }

  /// タスクを削除（すべての期間から）
  Future<void> removeTask(String taskId) async {
    try {
      final focusTasks = state.focusTasks;
      if (focusTasks == null) return;
      
      // 元の期間の記録も削除
      final originalPeriods = Map<String, String>.from(focusTasks.pendingOriginalPeriods);
      originalPeriods.remove(taskId);
      
      final updatedFocusTasks = FocusTaskList(
        pendingTaskIds: List<String>.from(focusTasks.pendingTaskIds)..remove(taskId),
        dailyTaskIds: List<String>.from(focusTasks.dailyTaskIds)..remove(taskId),
        weeklyTaskIds: List<String>.from(focusTasks.weeklyTaskIds)..remove(taskId),
        monthlyTaskIds: List<String>.from(focusTasks.monthlyTaskIds)..remove(taskId),
        yearlyTaskIds: List<String>.from(focusTasks.yearlyTaskIds)..remove(taskId),
        awarenessTaskIds: List<String>.from(focusTasks.awarenessTaskIds)..remove(taskId),
        pendingOriginalPeriods: originalPeriods,
        updatedAt: DateTime.now(),
      );
      await _repository.saveFocusTasks(updatedFocusTasks);
      state = state.copyWith(focusTasks: updatedFocusTasks);
    } catch (e) {
      state = state.copyWith(errorMessage: 'タスクの削除に失敗しました: $e');
    }
  }


  /// タスクを保留に移動
  Future<void> moveTaskToPending(String taskId, FocusPeriod fromPeriod) async {
    try {
      final focusTasks = state.focusTasks;
      if (focusTasks == null) return;
      
      // 保留から保留への移動は不可
      if (fromPeriod == FocusPeriod.pending) return;
      
      // 元の期間から削除
      final fromIds = List<String>.from(_getTaskIdsByPeriod(fromPeriod))..remove(taskId);
      // 保留に追加
      final pendingIds = List<String>.from(focusTasks.pendingTaskIds);
      if (!pendingIds.contains(taskId)) {
        pendingIds.add(taskId);
      }
      
      // 元の期間を記録
      final originalPeriods = Map<String, String>.from(focusTasks.pendingOriginalPeriods);
      originalPeriods[taskId] = fromPeriod.name;
      
      var updatedFocusTasks = focusTasks.copyWith(
        pendingTaskIds: pendingIds,
        pendingOriginalPeriods: originalPeriods,
      );
      
      // fromPeriodを更新
      switch (fromPeriod) {
        case FocusPeriod.pending:
          break; // 既にチェック済み
        case FocusPeriod.awareness:
          updatedFocusTasks = updatedFocusTasks.copyWith(awarenessTaskIds: fromIds);
          break;
        case FocusPeriod.daily:
          updatedFocusTasks = updatedFocusTasks.copyWith(dailyTaskIds: fromIds);
          break;
        case FocusPeriod.weekly:
          updatedFocusTasks = updatedFocusTasks.copyWith(weeklyTaskIds: fromIds);
          break;
        case FocusPeriod.monthly:
          updatedFocusTasks = updatedFocusTasks.copyWith(monthlyTaskIds: fromIds);
          break;
        case FocusPeriod.yearly:
          updatedFocusTasks = updatedFocusTasks.copyWith(yearlyTaskIds: fromIds);
          break;
      }
      
      updatedFocusTasks = updatedFocusTasks.copyWith(updatedAt: DateTime.now());
      
      await _repository.saveFocusTasks(updatedFocusTasks);
      state = state.copyWith(focusTasks: updatedFocusTasks);
    } catch (e) {
      state = state.copyWith(errorMessage: '保留への移動に失敗しました: $e');
    }
  }

  /// タスクを保留から元の期間に戻す
  Future<void> moveTaskFromPending(String taskId) async {
    try {
      final focusTasks = state.focusTasks;
      if (focusTasks == null) return;
      
      // 元の期間を取得
      final originalPeriodName = focusTasks.pendingOriginalPeriods[taskId];
      if (originalPeriodName == null) {
        throw Exception('元の期間が記録されていません');
      }
      
      final originalPeriod = FocusPeriod.values.firstWhere(
        (p) => p.name == originalPeriodName,
        orElse: () => throw Exception('不正な期間名: $originalPeriodName'),
      );
      
      // 保留から削除
      final pendingIds = List<String>.from(focusTasks.pendingTaskIds)..remove(taskId);
      // 元の期間に追加
      final toIds = List<String>.from(_getTaskIdsByPeriod(originalPeriod));
      if (!toIds.contains(taskId)) {
        toIds.add(taskId);
      }
      
      // 元の期間の記録を削除
      final originalPeriods = Map<String, String>.from(focusTasks.pendingOriginalPeriods);
      originalPeriods.remove(taskId);
      
      var updatedFocusTasks = focusTasks.copyWith(
        pendingTaskIds: pendingIds,
        pendingOriginalPeriods: originalPeriods,
      );
      
      // 元の期間を更新
      switch (originalPeriod) {
        case FocusPeriod.pending:
          break; // ありえない
        case FocusPeriod.awareness:
          updatedFocusTasks = updatedFocusTasks.copyWith(awarenessTaskIds: toIds);
          break;
        case FocusPeriod.daily:
          updatedFocusTasks = updatedFocusTasks.copyWith(dailyTaskIds: toIds);
          break;
        case FocusPeriod.weekly:
          updatedFocusTasks = updatedFocusTasks.copyWith(weeklyTaskIds: toIds);
          break;
        case FocusPeriod.monthly:
          updatedFocusTasks = updatedFocusTasks.copyWith(monthlyTaskIds: toIds);
          break;
        case FocusPeriod.yearly:
          updatedFocusTasks = updatedFocusTasks.copyWith(yearlyTaskIds: toIds);
          break;
      }
      
      updatedFocusTasks = updatedFocusTasks.copyWith(updatedAt: DateTime.now());
      
      await _repository.saveFocusTasks(updatedFocusTasks);
      state = state.copyWith(focusTasks: updatedFocusTasks);
    } catch (e) {
      state = state.copyWith(errorMessage: '保留からの復帰に失敗しました: $e');
    }
  }
}

