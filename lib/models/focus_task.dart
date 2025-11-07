import 'package:freezed_annotation/freezed_annotation.dart';

part 'focus_task.freezed.dart';
part 'focus_task.g.dart';

/// フォーカスタスクの期間
enum FocusPeriod {
  pending, // 保留
  daily,   // 今日
  weekly,  // 今週
  monthly, // 今月
  yearly,  // 今年
}

/// フォーカスタスク（期間別に整理されたタスクのリスト）
@freezed
class FocusTaskList with _$FocusTaskList {
  const factory FocusTaskList({
    @Default([]) List<String> pendingTaskIds, // 保留のタスクID
    @Default([]) List<String> dailyTaskIds,   // 今日のタスクID
    @Default([]) List<String> weeklyTaskIds,  // 今週のタスクID
    @Default([]) List<String> monthlyTaskIds, // 今月のタスクID
    @Default([]) List<String> yearlyTaskIds,  // 今年のタスクID
    @Default({}) Map<String, String> pendingOriginalPeriods, // 保留タスクの元の期間（taskId -> period名）
    required DateTime updatedAt,
  }) = _FocusTaskList;

  factory FocusTaskList.fromJson(Map<String, dynamic> json) =>
      _$FocusTaskListFromJson(json);

  /// 空のフォーカスタスクリスト
  factory FocusTaskList.empty() {
    return FocusTaskList(
      updatedAt: DateTime.now(),
    );
  }
}

