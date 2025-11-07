import 'package:flutter/material.dart';
import '../../models/goal.dart';
import '../../models/mandala_chart.dart';
import '../../utils/design_tokens.dart';
import 'mandala_cell_widget.dart';

/// マンダラチャート詳細表示（選択された中目標の3×3）
class MandalaDetailWidget extends StatelessWidget {
  const MandalaDetailWidget({
    super.key,
    required this.chart,
    required this.middlePosition,
    required this.onSmallGoalTap,
  });

  final MandalaChart chart;
  final int middlePosition;
  final Function(int smallPosition) onSmallGoalTap;

  @override
  Widget build(BuildContext context) {
    final middleGoal = chart.middleGoals.firstWhere(
      (g) => g.position == middlePosition,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 選択中の中目標を表示
        Padding(
          padding: const EdgeInsets.all(DesignTokens.spaceMd),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(DesignTokens.spaceMd),
            decoration: BoxDecoration(
              color: DesignTokens.backgroundSecondary,
              border: Border.all(
                color: DesignTokens.borderLight,
                width: DesignTokens.borderWidthThin,
              ),
              borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: DesignTokens.backgroundPrimary,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: const Icon(
                    Icons.flag_outlined,
                    color: DesignTokens.foregroundPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: DesignTokens.spaceSm + DesignTokens.spaceXs),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '中目標',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeBodySmall,
                          fontWeight: DesignTokens.fontWeightRegular,
                          color: DesignTokens.foregroundSecondary,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spaceXs),
                      Text(
                        middleGoal.title,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSizeBodyLarge,
                          fontWeight: DesignTokens.fontWeightSemibold,
                          color: DesignTokens.foregroundPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: DesignTokens.spaceMd),
        
        // 小目標の3×3グリッド
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceMd),
          child: ConstrainedBox(
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
                  return _buildCell(index, middleGoal);
                },
              ),
            ),
          ),
        ),
        
        const SizedBox(height: DesignTokens.spaceMd),
      ],
    );
  }

  Widget _buildCell(int index, MiddleGoal middleGoal) {
    final row = index ~/ 3;
    final col = index % 3;

    // 中心セル（中目標の再表示、読み取り専用）
    if (row == 1 && col == 1) {
      return Container(
        decoration: BoxDecoration(
          color: DesignTokens.backgroundPrimary,
          border: Border.all(
            color: DesignTokens.borderMedium,
            width: DesignTokens.borderWidthMedium,
          ),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceSm),
            child: Text(
              middleGoal.title,
              style: const TextStyle(
                fontSize: DesignTokens.fontSizeBody,
                fontWeight: DesignTokens.fontWeightSemibold,
                color: DesignTokens.foregroundPrimary,
                height: DesignTokens.lineHeightTight,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
    }

    // 小目標の位置を計算（0-7）
    final smallPosition = _getSmallPosition(row, col);
    final smallGoal = middleGoal.smallGoals.firstWhere(
      (g) => g.position == smallPosition,
    );

    // 中目標が空の場合は小目標を無効化
    final isEnabled = middleGoal.title.isNotEmpty;

    return MandalaCellWidget(
      title: smallGoal.title,
      type: GoalType.small,
      status: smallGoal.status,
      isEnabled: isEnabled,
      onTap: () => onSmallGoalTap(smallPosition),
    );
  }

  /// 小目標の位置を取得（0-7）
  int _getSmallPosition(int row, int col) {
    if (row == 0 && col == 1) return 0; // 上
    if (row == 0 && col == 2) return 1; // 右上
    if (row == 1 && col == 2) return 2; // 右
    if (row == 2 && col == 2) return 3; // 右下
    if (row == 2 && col == 1) return 4; // 下
    if (row == 2 && col == 0) return 5; // 左下
    if (row == 1 && col == 0) return 6; // 左
    if (row == 0 && col == 0) return 7; // 左上
    return 0;
  }
}
