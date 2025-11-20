import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import 'task_repository.dart';

/// タスクリポジトリの実装（SharedPreferences使用）
class TaskRepositoryImpl implements TaskRepository {
  static const String _tasksKey = 'tasks';

  @override
  Future<List<Task>> getAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_tasksKey);

    if (tasksJson == null || tasksJson.isEmpty) {
      return [];
    }

    final List<dynamic> tasksList = jsonDecode(tasksJson);
    return tasksList.map((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<List<Task>> getTasksBySmallGoalId(String smallGoalId) async {
    final allTasks = await getAllTasks();
    return allTasks.where((task) => task.smallGoalId == smallGoalId).toList();
  }

  @override
  Future<List<Task>> getTasksByPeriod(TaskPeriod period) async {
    final allTasks = await getAllTasks();
    return allTasks.where((task) => task.period == period).toList();
  }

  @override
  Future<List<Task>> getTasksBySmallGoalIdAndPeriod(
    String smallGoalId,
    TaskPeriod period,
  ) async {
    final allTasks = await getAllTasks();
    return allTasks
        .where((task) =>
            task.smallGoalId == smallGoalId && task.period == period)
        .toList();
  }

  @override
  Future<void> saveTask(Task task) async {
    final allTasks = await getAllTasks();

    // 既存のタスクを更新または新規追加
    final index = allTasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      allTasks[index] = task;
    } else {
      allTasks.add(task);
    }

    await _saveTasks(allTasks);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    final allTasks = await getAllTasks();
    allTasks.removeWhere((task) => task.id == taskId);
    await _saveTasks(allTasks);
  }

  @override
  Future<void> deleteAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tasksKey);
  }

  /// タスクリストを保存
  Future<void> _saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_tasksKey, tasksJson);
  }
}




