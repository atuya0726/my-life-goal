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
      updatedMiddleGoals[index] = updatedMiddleGoals[index].copyWith(
        title: newTitle,
      );
    }
    
    return copyWith(
      middleGoals: updatedMiddleGoals,
      updatedAt: DateTime.now(),
    );
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
        updatedSmallGoals[smallIndex] = updatedSmallGoals[smallIndex].copyWith(
          title: newTitle,
        );
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
}
