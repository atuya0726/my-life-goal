import 'package:flutter/material.dart';
import '../../models/goal.dart';
import '../../models/mandala_chart.dart';
import '../../utils/design_tokens.dart';
import 'mandala_cell_widget.dart';

/// マンダラチャート全体表示（中心3×3のみ）
class MandalaOverviewWidget extends StatelessWidget {
  const MandalaOverviewWidget({
    super.key,
    required this.chart,
    required this.onCenterTap,
    required this.onMiddleGoalTap,
    this.onMiddleGoalLongPress,
  });

  final MandalaChart chart;
  final VoidCallback onCenterTap;
  final Function(int middlePosition, String title) onMiddleGoalTap;
  final Function(int middlePosition)? onMiddleGoalLongPress;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: DesignTokens.screenMaxWidth,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: DesignTokens.gridGap,
            mainAxisSpacing: DesignTokens.gridGap,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return _buildCell(index);
          },
        ),
      ),
    );
  }

  Widget _buildCell(int index) {
    final row = index ~/ 3;
    final col = index % 3;

    // 中心セル（大目標）
    if (row == 1 && col == 1) {
      return MandalaCellWidget(
        title: chart.centerGoal,
        type: GoalType.center,
        onTap: onCenterTap,
      );
    }

    // 中目標の位置を計算（0-7）
    final middlePosition = _getMiddlePosition(row, col);
    final middleGoal = chart.middleGoals.firstWhere(
      (g) => g.position == middlePosition,
    );

    // 大目標が空の場合は中目標を無効化
    final isEnabled = chart.centerGoal.isNotEmpty;
    
    // 中目標の固有色を取得
    final middleGoalColor = DesignTokens.middleGoalColors[middlePosition % DesignTokens.middleGoalColors.length];

    return MandalaCellWidget(
      title: middleGoal.title,
      type: GoalType.middle,
      status: middleGoal.status,
      isEnabled: isEnabled,
      color: middleGoalColor,
      onTap: () => onMiddleGoalTap(middlePosition, middleGoal.title),
      onLongPress: onMiddleGoalLongPress != null 
          ? () => onMiddleGoalLongPress!(middlePosition)
          : null,
    );
  }

  /// 中目標の位置を取得（0-7）
  /// 左上から時計回りに 0:左上, 1:上, 2:右上, 3:右, 4:右下, 5:下, 6:左下, 7:左
  int _getMiddlePosition(int row, int col) {
    if (row == 0 && col == 0) return 0; // 左上
    if (row == 0 && col == 1) return 1; // 上
    if (row == 0 && col == 2) return 2; // 右上
    if (row == 1 && col == 2) return 3; // 右
    if (row == 2 && col == 2) return 4; // 右下
    if (row == 2 && col == 1) return 5; // 下
    if (row == 2 && col == 0) return 6; // 左下
    if (row == 1 && col == 0) return 7; // 左
    return 0;
  }
}
