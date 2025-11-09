import 'package:flutter/material.dart';
import '../../models/goal.dart';
import '../../models/mandala_chart.dart';
import '../../utils/design_tokens.dart';

/// マンダラチャート全体表示（27×27）
class MandalaFullOverviewWidget extends StatelessWidget {
  const MandalaFullOverviewWidget({
    super.key,
    required this.chart,
    required this.onBlockTap,
  });

  final MandalaChart chart;
  final Function(int? middlePosition) onBlockTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 利用可能なサイズを取得
        final availableSize = constraints.maxWidth < constraints.maxHeight 
            ? constraints.maxWidth 
            : constraints.maxHeight;
        
        // 27×27グリッドの実際のサイズ（大きめに設定）
        final gridSize = availableSize * 2.5; // 利用可能なサイズの2.5倍で表示
        
        return InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: 0.5,
          maxScale: 4.0,
          constrained: false,
          child: Container(
            width: gridSize,
            height: gridSize,
            decoration: BoxDecoration(
              border: Border.all(
                color: DesignTokens.foregroundSecondary.withOpacity(0.3),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              color: DesignTokens.backgroundPrimary,
            ),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 9,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: 81,
              itemBuilder: (context, index) {
                return _buildCell(index);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCell(int index) {
    final blockRow = index ~/ 9;
    final blockCol = index % 9;
    
    // 9×9グリッドの各セル内の位置
    final inBlockRow = blockRow % 3;
    final inBlockCol = blockCol % 3;
    
    // どの3×3ブロックに属するか（0-8）
    final blockIndex = (blockRow ~/ 3) * 3 + (blockCol ~/ 3);
    
    // 中心ブロック（大目標と中目標）
    if (blockIndex == 4) { // 中心の3×3ブロック
      return _buildCenterBlock(inBlockRow, inBlockCol);
    }
    
    // 周囲の8ブロック（中目標と小目標）
    final middlePosition = _getMiddlePositionFromBlock(blockIndex);
    return _buildMiddleBlock(middlePosition, inBlockRow, inBlockCol);
  }

  /// 中心ブロック（大目標と中目標）を構築
  Widget _buildCenterBlock(int row, int col) {
    // 中心セル（大目標）
    if (row == 1 && col == 1) {
      return GestureDetector(
        onTap: () => onBlockTap(null), // nullは全体表示（overview）を意味する
        child: _buildMiniCell(
          chart.centerGoal,
          GoalType.center,
          DesignTokens.centerBorder,
          isCenter: true,
        ),
      );
    }

    // 中目標の位置を計算
    final middlePosition = _getMiddlePosition(row, col);
    final middleGoal = chart.middleGoals.firstWhere(
      (g) => g.position == middlePosition,
    );
    
    final middleGoalColor = DesignTokens.middleGoalColors[
      middlePosition % DesignTokens.middleGoalColors.length
    ];

    return GestureDetector(
      onTap: () => onBlockTap(middlePosition),
      child: _buildMiniCell(
        middleGoal.title,
        GoalType.middle,
        middleGoalColor,
      ),
    );
  }

  /// 周囲のブロック（中目標と小目標）を構築
  Widget _buildMiddleBlock(int middlePosition, int row, int col) {
    final middleGoal = chart.middleGoals.firstWhere(
      (g) => g.position == middlePosition,
    );
    
    final middleGoalColor = DesignTokens.middleGoalColors[
      middlePosition % DesignTokens.middleGoalColors.length
    ];

    // 中心セル（中目標）
    if (row == 1 && col == 1) {
      return GestureDetector(
        onTap: () => onBlockTap(middlePosition),
        child: _buildMiniCell(
          middleGoal.title,
          GoalType.middle,
          middleGoalColor,
        ),
      );
    }

    // 小目標の位置を計算
    final smallPosition = _getMiddlePosition(row, col);
    final smallGoal = middleGoal.smallGoals.firstWhere(
      (g) => g.position == smallPosition,
    );

    return GestureDetector(
      onTap: () => onBlockTap(middlePosition),
      child: _buildMiniCell(
        smallGoal.title,
        GoalType.small,
        middleGoalColor.withOpacity(0.3),
      ),
    );
  }

  /// ミニセルを構築
  Widget _buildMiniCell(
    String title,
    GoalType type,
    Color borderColor, {
    bool isCenter = false,
  }) {
    final isEmpty = title.isEmpty;
    final backgroundColor = isEmpty 
        ? DesignTokens.emptyBackground
        : type == GoalType.center
            ? DesignTokens.centerBackground
            : type == GoalType.middle
                ? DesignTokens.middleBackground
                : DesignTokens.smallBackground;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: isEmpty 
              ? DesignTokens.emptyBorder.withOpacity(0.5)
              : borderColor,
          width: isCenter ? 2.5 : type == GoalType.middle ? 2.0 : 1.0,
        ),
        borderRadius: BorderRadius.circular(
          isCenter ? 4.0 : type == GoalType.middle ? 3.0 : 2.0,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(type == GoalType.center ? 4.0 : type == GoalType.middle ? 3.0 : 2.0),
          child: Text(
            isEmpty ? '' : title,
            style: TextStyle(
              fontSize: type == GoalType.center 
                  ? 14.0
                  : type == GoalType.middle 
                      ? 12.0 
                      : 10.0,
              fontWeight: type == GoalType.center
                  ? DesignTokens.fontWeightBold
                  : type == GoalType.middle
                      ? DesignTokens.fontWeightSemibold
                      : DesignTokens.fontWeightRegular,
              color: isEmpty
                  ? DesignTokens.emptyText
                  : type == GoalType.center
                      ? DesignTokens.centerText
                      : type == GoalType.middle
                          ? DesignTokens.middleText
                          : DesignTokens.smallText,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  /// ブロックインデックスから中目標の位置を取得
  /// blockIndex: 0-8 (中心は4)
  int _getMiddlePositionFromBlock(int blockIndex) {
    // 9×9グリッドの3×3ブロック配置
    // 0 1 2
    // 3 4 5
    // 6 7 8
    
    // マンダラチャートの位置マッピング
    // 左上から時計回りに 0:左上, 1:上, 2:右上, 3:右, 4:右下, 5:下, 6:左下, 7:左
    switch (blockIndex) {
      case 0: return 0; // 左上
      case 1: return 1; // 上
      case 2: return 2; // 右上
      case 5: return 3; // 右
      case 8: return 4; // 右下
      case 7: return 5; // 下
      case 6: return 6; // 左下
      case 3: return 7; // 左
      default: return 0;
    }
  }

  /// 中目標・小目標の位置を取得（0-7）
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

