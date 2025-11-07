import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

/// タスクの期間タイプ
enum TaskPeriod {
  daily,   // 1日
  weekly,  // 1週間
  monthly, // 1月
  yearly,  // 1年
}

/// タスクのステータス
enum TaskStatus {
  notStarted,  // 未着手
  inProgress,  // 進行中
  completed,   // 完了
}

/// タスクモデル
@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String title,
    @Default('') String description,
    required String smallGoalId, // 関連する小目標のID
    required TaskPeriod period,
    required TaskStatus status,
    DateTime? dueDate, // 期限（オプション）
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// 新規タスクを作成
  factory Task.create({
    required String title,
    required String smallGoalId,
    required TaskPeriod period,
    String? description,
    DateTime? dueDate,
  }) {
    final now = DateTime.now();
    return Task(
      id: '${now.millisecondsSinceEpoch}_task',
      title: title,
      description: description ?? '',
      smallGoalId: smallGoalId,
      period: period,
      status: TaskStatus.notStarted,
      dueDate: dueDate,
      createdAt: now,
      updatedAt: now,
    );
  }
}

/// タスクの期間に関するヘルパー拡張
extension TaskPeriodExtension on TaskPeriod {
  /// 表示用のラベルを取得
  String get label {
    switch (this) {
      case TaskPeriod.daily:
        return '1日';
      case TaskPeriod.weekly:
        return '1週間';
      case TaskPeriod.monthly:
        return '1月';
      case TaskPeriod.yearly:
        return '1年';
    }
  }

  /// アイコン用の名前を取得
  String get icon {
    switch (this) {
      case TaskPeriod.daily:
        return 'today';
      case TaskPeriod.weekly:
        return 'view_week';
      case TaskPeriod.monthly:
        return 'calendar_month';
      case TaskPeriod.yearly:
        return 'calendar_today';
    }
  }
}

/// タスクステータスのヘルパー拡張
extension TaskStatusExtension on TaskStatus {
  /// 表示用のラベルを取得
  String get label {
    switch (this) {
      case TaskStatus.notStarted:
        return '未着手';
      case TaskStatus.inProgress:
        return '進行中';
      case TaskStatus.completed:
        return '完了';
    }
  }
}

