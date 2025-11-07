import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/task.dart';

part 'task_state.freezed.dart';

/// タスク画面の状態
@freezed
class TaskState with _$TaskState {
  const factory TaskState({
    @Default([]) List<Task> allTasks,
    @Default([]) List<Task> filteredTasks,
    String? selectedSmallGoalId, // 選択中の小目標ID
    @Default(TaskPeriod.daily) TaskPeriod selectedPeriod,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _TaskState;

  /// 初期状態
  factory TaskState.initial() => const TaskState();
}

