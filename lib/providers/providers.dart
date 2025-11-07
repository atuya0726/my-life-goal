import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/mandala_chart_repository.dart';
import '../repositories/mandala_chart_repository_impl.dart';
import '../repositories/task_repository.dart';
import '../repositories/task_repository_impl.dart';
import '../repositories/focus_task_repository.dart';
import '../repositories/focus_task_repository_impl.dart';
import '../view_models/mandala_chart/mandala_chart_notifier.dart';
import '../view_models/mandala_chart/mandala_chart_state.dart';
import '../view_models/task/task_notifier.dart';
import '../view_models/task/task_state.dart';
import '../view_models/focus_task/focus_task_notifier.dart';
import '../view_models/focus_task/focus_task_state.dart';

/// マンダラチャートRepository Provider
final mandalaChartRepositoryProvider = Provider<MandalaChartRepository>((ref) {
  return MandalaChartRepositoryImpl();
});

/// マンダラチャートのStateNotifierProvider
final mandalaChartProvider =
    StateNotifierProvider<MandalaChartNotifier, MandalaChartState>((ref) {
  final repository = ref.watch(mandalaChartRepositoryProvider);
  return MandalaChartNotifier(repository);
});

/// タスクRepository Provider
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl();
});

/// タスクのStateNotifierProvider
final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});

/// フォーカスタスクRepository Provider
final focusTaskRepositoryProvider = Provider<FocusTaskRepository>((ref) {
  return FocusTaskRepositoryImpl();
});

/// フォーカスタスクのStateNotifierProvider
final focusTaskProvider =
    StateNotifierProvider<FocusTaskNotifier, FocusTaskState>((ref) {
  final repository = ref.watch(focusTaskRepositoryProvider);
  final taskRepository = ref.watch(taskRepositoryProvider);
  return FocusTaskNotifier(repository, taskRepository);
});

