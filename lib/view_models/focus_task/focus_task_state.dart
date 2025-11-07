import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/focus_task.dart';

part 'focus_task_state.freezed.dart';

/// フォーカスタスク画面の状態
@freezed
class FocusTaskState with _$FocusTaskState {
  const factory FocusTaskState({
    @Default(true) bool isLoading,
    FocusTaskList? focusTasks,
    String? errorMessage,
  }) = _FocusTaskState;
}

