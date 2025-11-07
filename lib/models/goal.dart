import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

/// 目標の種類
enum GoalType {
  center,  // 大目標（中心）
  middle,  // 中目標
  small,   // 小目標
}

/// 目標の状態
enum GoalStatus {
  notStarted,  // 未着手
  inProgress,  // 進行中
  completed,   // 完了
}

/// 小目標
@freezed
class SmallGoal with _$SmallGoal {
  const factory SmallGoal({
    required String id,
    required int position, // 0-7: ブロック内での位置
    required String title,
    @Default(GoalStatus.notStarted) GoalStatus status,
    @Default('') String memo,
  }) = _SmallGoal;

  factory SmallGoal.fromJson(Map<String, dynamic> json) =>
      _$SmallGoalFromJson(json);
}

/// 中目標（8つの小目標を持つ）
@freezed
class MiddleGoal with _$MiddleGoal {
  const factory MiddleGoal({
    required String id,
    required int position, // 0-7: 中心の周囲8方向の位置
    required String title,
    @Default([]) List<SmallGoal> smallGoals,
    @Default(GoalStatus.notStarted) GoalStatus status,
    @Default('') String memo,
  }) = _MiddleGoal;

  factory MiddleGoal.fromJson(Map<String, dynamic> json) =>
      _$MiddleGoalFromJson(json);
}


