import 'package:flutter/material.dart';
import '../../models/goal.dart';
import '../../utils/design_tokens.dart';

/// マンダラチャートの各セルを表示するウィジェット
class MandalaCellWidget extends StatelessWidget {
  const MandalaCellWidget({
    super.key,
    required this.title,
    required this.type,
    required this.onTap,
    this.onLongPress,
    this.status = GoalStatus.notStarted,
    this.isEnabled = true,
    this.color,
  });

  final String title;
  final GoalType type;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final GoalStatus status;
  final bool isEnabled;
  final Color? color; // 中目標用の固有色

  @override
  Widget build(BuildContext context) {
    final isEmpty = title.isEmpty;

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      onLongPress: isEnabled ? onLongPress : null,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.4,
        child: Container(
          decoration: _getDecoration(isEmpty),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(_getPadding()),
              child: Text(
                isEmpty ? '+' : title,
                style: _getTextStyle(isEmpty),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// セルの装飾を取得
  BoxDecoration _getDecoration(bool isEmpty) {
    if (isEmpty) {
      // 未入力状態（点線でタップ可能であることを示す）
      return BoxDecoration(
        color: DesignTokens.emptyBackground,
        border: Border.all(
          color: DesignTokens.borderMedium,
          width: DesignTokens.borderWidthMedium,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
        borderRadius: BorderRadius.circular(_getBorderRadius()),
      );
    }

    // 入力済み状態
    switch (type) {
      case GoalType.center:
        return BoxDecoration(
          color: DesignTokens.centerBackground,
          border: Border.all(
            color: DesignTokens.centerBorder,
            width: DesignTokens.borderWidthThick,
          ),
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          boxShadow: DesignTokens.shadowMd,
        );
      case GoalType.middle:
        return BoxDecoration(
          color: DesignTokens.middleBackground,
          border: Border.all(
            color: color ?? DesignTokens.middleBorder,
            width: DesignTokens.borderWidthMedium,
          ),
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          boxShadow: DesignTokens.shadowSm,
        );
      case GoalType.small:
        return BoxDecoration(
          color: DesignTokens.smallBackground,
          border: Border.all(
            color: DesignTokens.smallBorder,
            width: DesignTokens.borderWidthThin,
          ),
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        );
    }
  }

  /// テキストスタイルを取得
  TextStyle _getTextStyle(bool isEmpty) {
    if (isEmpty) {
      return TextStyle(
        fontSize: _getEmptyIconSize(),
        fontWeight: DesignTokens.fontWeightBold,
        color: DesignTokens.borderDark,
      );
    }

    switch (type) {
      case GoalType.center:
        return const TextStyle(
          fontSize: DesignTokens.fontSizeBodyLarge,
          fontWeight: DesignTokens.fontWeightBold,
          color: DesignTokens.centerText,
          height: DesignTokens.lineHeightTight,
        );
      case GoalType.middle:
        return const TextStyle(
          fontSize: DesignTokens.fontSizeBody,
          fontWeight: DesignTokens.fontWeightSemibold,
          color: DesignTokens.middleText,
          height: DesignTokens.lineHeightTight,
        );
      case GoalType.small:
        return const TextStyle(
          fontSize: DesignTokens.fontSizeBodySmall,
          fontWeight: DesignTokens.fontWeightRegular,
          color: DesignTokens.smallText,
          height: DesignTokens.lineHeightTight,
        );
    }
  }

  /// パディングを取得
  double _getPadding() {
    switch (type) {
      case GoalType.center:
        return DesignTokens.spaceMd;
      case GoalType.middle:
        return DesignTokens.spaceSm + DesignTokens.spaceXs;
      case GoalType.small:
        return DesignTokens.spaceSm;
    }
  }

  /// ボーダー半径を取得
  double _getBorderRadius() {
    switch (type) {
      case GoalType.center:
        return DesignTokens.radiusLg;
      case GoalType.middle:
        return DesignTokens.radiusMd;
      case GoalType.small:
        return DesignTokens.radiusSm;
    }
  }

  /// 空のセルのアイコンサイズを取得
  double _getEmptyIconSize() {
    switch (type) {
      case GoalType.center:
        return DesignTokens.fontSizeH1;
      case GoalType.middle:
        return DesignTokens.fontSizeH2;
      case GoalType.small:
        return DesignTokens.fontSizeH3;
    }
  }
}
