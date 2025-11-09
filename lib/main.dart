import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils/design_tokens.dart';
import 'views/screens/main_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 通知サービスを初期化
  final notificationService = NotificationService();
  await notificationService.initialize();
  await notificationService.rescheduleNotifications();
  
  runApp(
    // Riverpodを使用するためProviderScopeでラップ
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Life Goal',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const MainScreen(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      
      // フォントファミリー（日本語対応）
      fontFamily: GoogleFonts.notoSansJp().fontFamily,
      
      // カラースキーム
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: DesignTokens.foregroundPrimary,
        onPrimary: DesignTokens.backgroundSecondary,
        secondary: DesignTokens.foregroundSecondary,
        onSecondary: DesignTokens.backgroundSecondary,
        error: DesignTokens.errorPrimary,
        onError: DesignTokens.backgroundSecondary,
        surface: DesignTokens.backgroundSecondary,
        onSurface: DesignTokens.foregroundPrimary,
      ),
      
      // スキャフォールド背景色
      scaffoldBackgroundColor: DesignTokens.backgroundPrimary,
      
      // AppBarテーマ
      appBarTheme: const AppBarTheme(
        backgroundColor: DesignTokens.backgroundSecondary,
        foregroundColor: DesignTokens.foregroundPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: DesignTokens.fontSizeH4,
          fontWeight: DesignTokens.fontWeightSemibold,
          color: DesignTokens.foregroundPrimary,
        ),
      ),
      
      // テキストテーマ
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: DesignTokens.fontSizeH1,
          fontWeight: DesignTokens.fontWeightBold,
          color: DesignTokens.foregroundPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: DesignTokens.fontSizeH2,
          fontWeight: DesignTokens.fontWeightSemibold,
          color: DesignTokens.foregroundPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: DesignTokens.fontSizeH3,
          fontWeight: DesignTokens.fontWeightSemibold,
          color: DesignTokens.foregroundPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: DesignTokens.fontSizeH4,
          fontWeight: DesignTokens.fontWeightSemibold,
          color: DesignTokens.foregroundPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: DesignTokens.fontSizeBodyLarge,
          fontWeight: DesignTokens.fontWeightRegular,
          color: DesignTokens.foregroundPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: DesignTokens.fontSizeBody,
          fontWeight: DesignTokens.fontWeightRegular,
          color: DesignTokens.foregroundPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: DesignTokens.fontSizeBodySmall,
          fontWeight: DesignTokens.fontWeightRegular,
          color: DesignTokens.foregroundSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: DesignTokens.fontSizeLabel,
          fontWeight: DesignTokens.fontWeightMedium,
          color: DesignTokens.foregroundPrimary,
        ),
      ),
      
      // カードテーマ
      cardTheme: CardThemeData(
        color: DesignTokens.backgroundSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
          side: const BorderSide(
            color: DesignTokens.borderLight,
            width: DesignTokens.borderWidthThin,
          ),
        ),
      ),
      
      // ボタンテーマ
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignTokens.foregroundPrimary,
          foregroundColor: DesignTokens.backgroundSecondary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spaceLg,
            vertical: DesignTokens.spaceSm + DesignTokens.spaceXs,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          textStyle: const TextStyle(
            fontSize: DesignTokens.fontSizeBody,
            fontWeight: DesignTokens.fontWeightSemibold,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: DesignTokens.foregroundSecondary,
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spaceMd,
            vertical: DesignTokens.spaceSm,
          ),
        ),
      ),
      
      // インプットデコレーションテーマ
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: DesignTokens.backgroundSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: const BorderSide(
            color: DesignTokens.borderMedium,
            width: DesignTokens.borderWidthThin,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: const BorderSide(
            color: DesignTokens.borderMedium,
            width: DesignTokens.borderWidthThin,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          borderSide: const BorderSide(
            color: DesignTokens.foregroundPrimary,
            width: DesignTokens.borderWidthMedium,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spaceSm + DesignTokens.spaceXs,
          vertical: DesignTokens.spaceSm + DesignTokens.spaceXs,
        ),
        hintStyle: const TextStyle(
          color: DesignTokens.foregroundTertiary,
        ),
      ),
      
      // ダイアログテーマ
      dialogTheme: DialogThemeData(
        backgroundColor: DesignTokens.backgroundSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusXl),
        ),
      ),
      
      // プログレスインジケーター
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: DesignTokens.foregroundPrimary,
        linearTrackColor: DesignTokens.borderLight,
      ),
    );
  }
}
