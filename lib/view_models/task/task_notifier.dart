import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import '../../models/focus_task.dart';
import '../../repositories/task_repository.dart';
import '../../providers/providers.dart';
import 'task_state.dart';

/// タスク画面のNotifier
class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier(this._repository, this._ref) : super(TaskState.initial());

  final TaskRepository _repository;
  final Ref _ref;

  /// タスクを読み込む
  Future<void> load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final tasks = await _repository.getAllTasks();
      state = state.copyWith(
        allTasks: tasks,
        isLoading: false,
      );
      _applyFilter();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'タスクの読み込みに失敗しました: $e',
      );
    }
  }

  /// 小目標を選択
  void selectSmallGoal(String? smallGoalId) {
    state = state.copyWith(selectedSmallGoalId: smallGoalId);
    _applyFilter();
  }

  /// 期間を選択
  void selectPeriod(TaskPeriod period) {
    state = state.copyWith(selectedPeriod: period);
    _applyFilter();
  }

  /// タスクを追加
  Future<void> addTask(Task task) async {
    try {
      await _repository.saveTask(task);
      
      // 自動的にフォーカスタスクの保留に追加
      final focusTaskNotifier = _ref.read(focusTaskProvider.notifier);
      await focusTaskNotifier.addTask(task.id, FocusPeriod.pending);
      
      await load(); // リロード
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'タスクの追加に失敗しました: $e',
      );
    }
  }

  /// タスクを更新
  Future<void> updateTask(Task task) async {
    try {
      await _repository.saveTask(task);
      await load(); // リロード
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'タスクの更新に失敗しました: $e',
      );
    }
  }

  /// タスクのステータスを変更
  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    final task = state.allTasks.firstWhere((t) => t.id == taskId);
    final updatedTask = task.copyWith(
      status: status,
      updatedAt: DateTime.now(),
    );
    await updateTask(updatedTask);
  }

  /// タスクを削除
  Future<void> deleteTask(String taskId) async {
    try {
      await _repository.deleteTask(taskId);
      
      // フォーカスタスクからも削除
      final focusTaskNotifier = _ref.read(focusTaskProvider.notifier);
      await focusTaskNotifier.removeTask(taskId);
      
      await load(); // リロード
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'タスクの削除に失敗しました: $e',
      );
    }
  }

  /// すべてのタスクを削除
  Future<void> deleteAllTasks() async {
    try {
      await _repository.deleteAllTasks();
      await load(); // リロード
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'タスクの削除に失敗しました: $e',
      );
    }
  }

  /// フィルターを適用
  void _applyFilter() {
    var filtered = state.allTasks;

    // 小目標でフィルター
    if (state.selectedSmallGoalId != null) {
      filtered = filtered
          .where((task) => task.smallGoalId == state.selectedSmallGoalId)
          .toList();
    }

    // 期間でフィルター
    filtered = filtered.where((task) => task.period == state.selectedPeriod).toList();

    state = state.copyWith(filteredTasks: filtered);
  }

  /// エラーメッセージをクリア
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

