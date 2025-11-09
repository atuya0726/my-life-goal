import 'package:freezed_annotation/freezed_annotation.dart';
import 'goal.dart';

part 'mandala_chart.freezed.dart';
part 'mandala_chart.g.dart';

/// マンダラチャート全体のデータモデル
@freezed
class MandalaChart with _$MandalaChart {
  const MandalaChart._(); // カスタムメソッドを使うために必要
  
  const factory MandalaChart({
    required String id,
    required String centerGoal, // 大目標（中心の中心）
    @Default([]) List<MiddleGoal> middleGoals, // 8つの中目標
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _MandalaChart;

  factory MandalaChart.fromJson(Map<String, dynamic> json) =>
      _$MandalaChartFromJson(json);

  /// 空のマンダラチャートを作成
  factory MandalaChart.empty() {
    final now = DateTime.now();
    return MandalaChart(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      centerGoal: '',
      middleGoals: List.generate(
        8,
        (index) => MiddleGoal(
          id: '${now.millisecondsSinceEpoch}_middle_$index',
          position: index,
          title: '',
          smallGoals: List.generate(
            8,
            (smallIndex) => SmallGoal(
              id: '${now.millisecondsSinceEpoch}_middle_${index}_small_$smallIndex',
              position: smallIndex,
              title: '',
            ),
          ),
        ),
      ),
      createdAt: now,
      updatedAt: now,
    );
  }

  /// 入力済みセルの数を取得
  int get filledCellCount {
    int count = 0;
    if (centerGoal.isNotEmpty) count++;
    
    for (final middle in middleGoals) {
      if (middle.title.isNotEmpty) count++;
      for (final small in middle.smallGoals) {
        if (small.title.isNotEmpty) count++;
      }
    }
    
    return count;
  }

  /// 全セル数（81マス）
  int get totalCellCount => 81;

  /// 入力率を取得（0.0-1.0）
  double get completionRate => filledCellCount / totalCellCount;

  /// 大目標を更新
  MandalaChart updateCenterGoal(String newGoal) {
    return copyWith(
      centerGoal: newGoal,
      updatedAt: DateTime.now(),
    );
  }

  /// 中目標を更新
  MandalaChart updateMiddleGoal(int position, String newTitle) {
    final updatedMiddleGoals = List<MiddleGoal>.from(middleGoals);
    final index = updatedMiddleGoals.indexWhere((g) => g.position == position);
    
    if (index != -1) {
      // 空文字が設定された場合は詰める
      if (newTitle.isEmpty) {
        updatedMiddleGoals[index] = updatedMiddleGoals[index].copyWith(
          title: newTitle,
        );
        _compactMiddleGoals(updatedMiddleGoals);
      } else {
        updatedMiddleGoals[index] = updatedMiddleGoals[index].copyWith(
          title: newTitle,
        );
      }
    }
    
    return copyWith(
      middleGoals: updatedMiddleGoals,
      updatedAt: DateTime.now(),
    );
  }

  /// 次の空いている中目標のpositionを取得
  int? getNextEmptyMiddlePosition() {
    for (int i = 0; i < middleGoals.length; i++) {
      final goal = middleGoals.firstWhere((g) => g.position == i);
      if (goal.title.isEmpty) {
        return i;
      }
    }
    return null; // 全て埋まっている
  }

  /// 次の空いている中目標に入力
  MandalaChart addMiddleGoal(String newTitle) {
    if (newTitle.isEmpty) return this;
    
    final nextPosition = getNextEmptyMiddlePosition();
    if (nextPosition == null) return this; // 全て埋まっている場合は何もしない
    
    return updateMiddleGoal(nextPosition, newTitle);
  }

  /// 小目標を更新
  MandalaChart updateSmallGoal(
    int middlePosition,
    int smallPosition,
    String newTitle,
  ) {
    final updatedMiddleGoals = List<MiddleGoal>.from(middleGoals);
    final middleIndex = updatedMiddleGoals.indexWhere(
      (g) => g.position == middlePosition,
    );
    
    if (middleIndex != -1) {
      final middle = updatedMiddleGoals[middleIndex];
      final updatedSmallGoals = List<SmallGoal>.from(middle.smallGoals);
      final smallIndex = updatedSmallGoals.indexWhere(
        (g) => g.position == smallPosition,
      );
      
      if (smallIndex != -1) {
        // 空文字が設定された場合は詰める
        if (newTitle.isEmpty) {
          updatedSmallGoals[smallIndex] = updatedSmallGoals[smallIndex].copyWith(
            title: newTitle,
          );
          _compactSmallGoals(updatedSmallGoals);
        } else {
          updatedSmallGoals[smallIndex] = updatedSmallGoals[smallIndex].copyWith(
            title: newTitle,
          );
        }
      }
      
      updatedMiddleGoals[middleIndex] = middle.copyWith(
        smallGoals: updatedSmallGoals,
      );
    }
    
    return copyWith(
      middleGoals: updatedMiddleGoals,
      updatedAt: DateTime.now(),
    );
  }

  /// 次の空いている小目標のpositionを取得
  int? getNextEmptySmallPosition(int middlePosition) {
    final middleIndex = middleGoals.indexWhere((g) => g.position == middlePosition);
    if (middleIndex == -1) return null;
    
    final middle = middleGoals[middleIndex];
    for (int i = 0; i < middle.smallGoals.length; i++) {
      final goal = middle.smallGoals.firstWhere((g) => g.position == i);
      if (goal.title.isEmpty) {
        return i;
      }
    }
    return null; // 全て埋まっている
  }

  /// 次の空いている小目標に入力
  MandalaChart addSmallGoal(int middlePosition, String newTitle) {
    if (newTitle.isEmpty) return this;
    
    final nextPosition = getNextEmptySmallPosition(middlePosition);
    if (nextPosition == null) return this; // 全て埋まっている場合は何もしない
    
    return updateSmallGoal(middlePosition, nextPosition, newTitle);
  }

  /// 中目標を詰める（空の目標を後ろに移動）
  void _compactMiddleGoals(List<MiddleGoal> goals) {
    // タイトルが入力されている目標のみを抽出
    final filledGoals = goals.where((g) => g.title.isNotEmpty).toList();
    // 空の目標を抽出
    final emptyGoals = goals.where((g) => g.title.isEmpty).toList();
    
    // positionを再割り当て（0から順番に）
    for (int i = 0; i < filledGoals.length; i++) {
      goals[i] = filledGoals[i].copyWith(position: i);
    }
    
    // 空の目標を後ろに配置
    for (int i = 0; i < emptyGoals.length; i++) {
      goals[filledGoals.length + i] = emptyGoals[i].copyWith(
        position: filledGoals.length + i,
      );
    }
  }

  /// 小目標を詰める（空の目標を後ろに移動）
  void _compactSmallGoals(List<SmallGoal> goals) {
    // タイトルが入力されている目標のみを抽出
    final filledGoals = goals.where((g) => g.title.isNotEmpty).toList();
    // 空の目標を抽出
    final emptyGoals = goals.where((g) => g.title.isEmpty).toList();
    
    // positionを再割り当て（0から順番に）
    for (int i = 0; i < filledGoals.length; i++) {
      goals[i] = filledGoals[i].copyWith(position: i);
    }
    
    // 空の目標を後ろに配置
    for (int i = 0; i < emptyGoals.length; i++) {
      goals[filledGoals.length + i] = emptyGoals[i].copyWith(
        position: filledGoals.length + i,
      );
    }
  }

  /// 小目標をIDで削除（空文字に設定して詰める）
  MandalaChart removeSmallGoalById(String smallGoalId) {
    final updatedMiddleGoals = List<MiddleGoal>.from(middleGoals);
    
    // すべての中目標から該当する小目標を探す
    for (int i = 0; i < updatedMiddleGoals.length; i++) {
      final middle = updatedMiddleGoals[i];
      final smallIndex = middle.smallGoals.indexWhere((g) => g.id == smallGoalId);
      
      if (smallIndex != -1) {
        // 小目標を空文字に設定
        final updatedSmallGoals = List<SmallGoal>.from(middle.smallGoals);
        updatedSmallGoals[smallIndex] = updatedSmallGoals[smallIndex].copyWith(
          title: '',
        );
        _compactSmallGoals(updatedSmallGoals);
        
        updatedMiddleGoals[i] = middle.copyWith(
          smallGoals: updatedSmallGoals,
        );
        break; // 見つかったので終了
      }
    }
    
    return copyWith(
      middleGoals: updatedMiddleGoals,
      updatedAt: DateTime.now(),
    );
  }
}
