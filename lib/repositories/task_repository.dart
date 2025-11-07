import '../models/task.dart';

/// タスクリポジトリのインターフェース
abstract class TaskRepository {
  /// すべてのタスクを取得
  Future<List<Task>> getAllTasks();

  /// 指定した小目標に関連するタスクを取得
  Future<List<Task>> getTasksBySmallGoalId(String smallGoalId);

  /// 指定した期間のタスクを取得
  Future<List<Task>> getTasksByPeriod(TaskPeriod period);

  /// 指定した小目標と期間のタスクを取得
  Future<List<Task>> getTasksBySmallGoalIdAndPeriod(
    String smallGoalId,
    TaskPeriod period,
  );

  /// タスクを保存（新規作成または更新）
  Future<void> saveTask(Task task);

  /// タスクを削除
  Future<void> deleteTask(String taskId);

  /// すべてのタスクを削除
  Future<void> deleteAllTasks();
}

