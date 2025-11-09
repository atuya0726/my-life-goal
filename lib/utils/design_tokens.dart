import 'package:flutter/material.dart';

/// デザイントークン（色、スペーシング、タイポグラフィなど）
class DesignTokens {
  // ========== Colors ==========
  
  // 背景色
  static const backgroundPrimary = Color(0xFFFAFAFA);
  static const backgroundSecondary = Color(0xFFFFFFFF);
  static const backgroundElevated = Color(0xFFF5F5F5);
  
  // テキスト・前景色
  static const foregroundPrimary = Color(0xFF374151);
  static const foregroundSecondary = Color(0xFF6B7280);
  static const foregroundTertiary = Color(0xFF9CA3AF);
  static const foregroundDisabled = Color(0xFFD1D5DB);
  
  // ボーダー・区切り線
  static const borderLight = Color(0xFFE5E7EB);
  static const borderMedium = Color(0xFFD1D5DB);
  static const borderDark = Color(0xFF9CA3AF);
  
  // アクセント色
  static const successPrimary = Color(0xFF10B981);
  static const successLight = Color(0xFFD1FAE5);
  static const successDark = Color(0xFF059669);
  
  static const warningPrimary = Color(0xFFF59E0B);
  static const warningLight = Color(0xFFFEF3C7);
  
  static const errorPrimary = Color(0xFFEF4444);
  static const errorLight = Color(0xFFFEE2E2);
  
  static const infoPrimary = Color(0xFF374151);
  static const infoLight = Color(0xFFF3F4F6);
  
  // 目標階層別の色
  static const centerBackground = Color(0xFFFFFFFF);
  static const centerBorder = Color(0xFF374151);
  static const centerText = Color(0xFF374151);
  
  static const middleBackground = Color(0xFFFFFFFF);
  static const middleBorder = Color(0xFF6B7280);
  static const middleText = Color(0xFF374151);
  
  static const smallBackground = Color(0xFFFFFFFF);
  static const smallBorder = Color(0xFF9CA3AF);
  static const smallText = Color(0xFF374151);
  
  static const emptyBackground = Color(0xFFF9FAFB);
  static const emptyBorder = Color(0xFFE5E7EB);
  static const emptyText = Color(0xFF9CA3AF);
  
  // 中目標の固有色（position 0-7に対応）
  static const List<Color> middleGoalColors = [
    Color(0xFFEF4444), // 0: 左上 - 赤
    Color(0xFFF59E0B), // 1: 上 - オレンジ
    Color(0xFFFBBF24), // 2: 右上 - 黄色
    Color(0xFF10B981), // 3: 右 - 緑
    Color(0xFF3B82F6), // 4: 右下 - 青
    Color(0xFF8B5CF6), // 5: 下 - 紫
    Color(0xFFEC4899), // 6: 左下 - ピンク
    Color(0xFF6366F1), // 7: 左 - インディゴ
  ];
  
  // 中目標の固有色（薄い背景用）
  static const List<Color> middleGoalColorsLight = [
    Color(0xFFFEE2E2), // 0: 左上 - 薄い赤
    Color(0xFFFEF3C7), // 1: 上 - 薄いオレンジ
    Color(0xFFFEF3C7), // 2: 右上 - 薄い黄色
    Color(0xFFD1FAE5), // 3: 右 - 薄い緑
    Color(0xFFDBEAFE), // 4: 右下 - 薄い青
    Color(0xFFEDE9FE), // 5: 下 - 薄い紫
    Color(0xFFFCE7F3), // 6: 左下 - 薄いピンク
    Color(0xFFE0E7FF), // 7: 左 - 薄いインディゴ
  ];
  
  // ========== Spacing ==========
  
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double spaceXxl = 48.0;
  
  // ========== Typography ==========
  
  // フォントサイズ
  static const double fontSizeH1 = 28.0;
  static const double fontSizeH2 = 24.0;
  static const double fontSizeH3 = 20.0;
  static const double fontSizeH4 = 18.0;
  static const double fontSizeBodyLarge = 16.0;
  static const double fontSizeBody = 14.0;
  static const double fontSizeBodySmall = 12.0;
  static const double fontSizeCaption = 11.0;
  static const double fontSizeLabel = 13.0;
  
  // フォントウェイト
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemibold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  
  // 行間
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;
  
  // ========== Border Radius ==========
  
  static const double radiusSm = 4.0;
  static const double radiusMd = 6.0;
  static const double radiusLg = 8.0;
  static const double radiusXl = 12.0;
  
  // ========== Border Width ==========
  
  static const double borderWidthThin = 1.0;
  static const double borderWidthMedium = 2.0;
  static const double borderWidthThick = 3.0;
  
  // ========== Shadows ==========
  
  static const List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Color(0x0F000000), // rgba(0,0,0,0.06)
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x14000000), // rgba(0,0,0,0.08)
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> shadowLg = [
    BoxShadow(
      color: Color(0x1F000000), // rgba(0,0,0,0.12)
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
  
  static const List<BoxShadow> shadowFocus = [
    BoxShadow(
      color: Color(0x1A374151), // rgba(55,65,81,0.1)
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 3,
    ),
  ];
  
  // ========== Animation Duration ==========
  
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);
  
  // ========== Layout ==========
  
  static const double screenMaxWidth = 600.0;
  static const double screenPadding = 16.0;
  static const double appBarHeight = 56.0;
  
  static const double gridGap = 8.0;
  static const double gridPadding = 16.0;
  
  static const double touchTargetMinSize = 44.0;
  
  // ========== Helper Methods ==========
  
  /// テキストスタイルを取得
  static TextStyle textStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
  
  /// ボーダーを取得
  static Border border({
    required Color color,
    required double width,
  }) {
    return Border.all(
      color: color,
      width: width,
    );
  }
  
  /// 点線ボーダーを取得（実際は実線だが視覚的に点線風に）
  static BoxDecoration dashedBorder({
    required Color color,
    required double width,
    required double radius,
  }) {
    return BoxDecoration(
      border: Border.all(
        color: color,
        width: width,
      ),
      borderRadius: BorderRadius.circular(radius),
    );
  }
}


