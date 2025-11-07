import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../utils/design_tokens.dart';
import '../widgets/mandala_overview_widget.dart';
import '../widgets/mandala_detail_widget.dart';

/// 表示モード
enum DisplayMode {
  overview, // 全体表示（中心3×3）
  detail, // 詳細表示（選択された中目標の3×3）
}

/// マンダラチャートのメイン画面
class MandalaChartScreen extends ConsumerStatefulWidget {
  const MandalaChartScreen({super.key});

  @override
  ConsumerState<MandalaChartScreen> createState() =>
      _MandalaChartScreenState();
}

class _MandalaChartScreenState extends ConsumerState<MandalaChartScreen> {
  DisplayMode _displayMode = DisplayMode.overview;
  int? _selectedMiddlePosition;

  @override
  void initState() {
    super.initState();
    // 画面表示時にデータを読み込む
    Future.microtask(() {
      ref.read(mandalaChartProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mandalaChartProvider);

    return state.isLoading
        ? const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        : Column(
            children: [
              // 詳細表示の時は戻るボタンを表示
              if (_displayMode == DisplayMode.detail)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spaceXs,
                    vertical: DesignTokens.spaceXs,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _goBackToOverview,
                        tooltip: '全体表示に戻る',
                      ),
                      const Text(
                        '小目標を入力',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeBodyLarge,
                          fontWeight: DesignTokens.fontWeightSemibold,
                        ),
                      ),
                    ],
                  ),
                ),
              // エラーメッセージ
              if (state.errorMessage != null) _buildErrorBanner(state),
              // マンダラチャート表示
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(DesignTokens.spaceMd),
                    child: AnimatedSwitcher(
                      duration: DesignTokens.durationNormal,
                      child: _displayMode == DisplayMode.overview
                          ? _buildOverviewMode(state)
                          : _buildDetailMode(state),
                    ),
                  ),
                ),
              ),
            ],
          );
  }


  /// エラーバナーを構築
  Widget _buildErrorBanner(state) {
    return Container(
      color: DesignTokens.errorLight,
      padding: const EdgeInsets.all(DesignTokens.spaceSm + DesignTokens.spaceXs),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: DesignTokens.errorPrimary,
            size: 20,
          ),
          const SizedBox(width: DesignTokens.spaceSm),
          Expanded(
            child: Text(
              state.errorMessage!,
              style: const TextStyle(
                color: DesignTokens.errorPrimary,
                fontSize: DesignTokens.fontSizeBodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }


  /// 全体表示モード
  Widget _buildOverviewMode(state) {
    return Column(
      key: const ValueKey('overview'),
      children: [
        MandalaOverviewWidget(
          chart: state.chart,
          onCenterTap: _onCenterTap,
          onMiddleGoalTap: _onMiddleGoalTap,
          onMiddleGoalLongPress: _onMiddleGoalLongPress,
        ),
      ],
    );
  }

  /// 詳細表示モード
  Widget _buildDetailMode(state) {
    if (_selectedMiddlePosition == null) {
      return const Center(
        key: ValueKey('error'),
        child: Text('エラー：中目標が選択されていません'),
      );
    }

    return MandalaDetailWidget(
      key: ValueKey('detail_$_selectedMiddlePosition'),
      chart: state.chart,
      middlePosition: _selectedMiddlePosition!,
      onSmallGoalTap: _onSmallGoalTap,
    );
  }

  /// 全体表示に戻る
  void _goBackToOverview() {
    setState(() {
      _displayMode = DisplayMode.overview;
      _selectedMiddlePosition = null;
    });
  }

  /// 大目標（中心）タップ時の処理
  void _onCenterTap() {
    final currentValue = ref.read(mandalaChartProvider).chart.centerGoal;
    _showEditDialog(
      context,
      '大目標',
      '人生の目標',
      currentValue,
      (newValue) {
        ref.read(mandalaChartProvider.notifier).updateCenterGoal(newValue);
      },
    );
  }

  /// 中目標タップ時の処理（詳細表示へ遷移 or 編集）
  void _onMiddleGoalTap(int middlePosition, String title) {
    final chart = ref.read(mandalaChartProvider).chart;
    
    // 大目標が空の場合は入力不可
    if (chart.centerGoal.isEmpty) {
      _showValidationMessage('まず大目標を入力してください');
      return;
    }
    
    // 中目標が空の場合：編集ダイアログを開く（タップで入力できるように）
    if (title.isEmpty) {
      _onMiddleGoalLongPress(middlePosition);
      return;
    }
    
    // 中目標が入力済みの場合：詳細表示へ遷移
    setState(() {
      _displayMode = DisplayMode.detail;
      _selectedMiddlePosition = middlePosition;
    });
  }

  /// 中目標長押し時の処理（編集ダイアログ）
  void _onMiddleGoalLongPress(int middlePosition) {
    final chart = ref.read(mandalaChartProvider).chart;
    
    // 大目標が空の場合は編集不可
    if (chart.centerGoal.isEmpty) {
      _showValidationMessage('まず大目標を入力してください');
      return;
    }
    
    final middleGoal = chart.middleGoals.firstWhere(
      (g) => g.position == middlePosition,
    );
    
    _showEditDialog(
      context,
      '中目標',
      '大目標を叶えるために必要な目標',
      middleGoal.title,
      (newValue) {
        ref
            .read(mandalaChartProvider.notifier)
            .updateMiddleGoal(middlePosition, newValue);
      },
    );
  }

  /// 小目標タップ時の処理
  void _onSmallGoalTap(int smallPosition) {
    if (_selectedMiddlePosition == null) return;

    final chart = ref.read(mandalaChartProvider).chart;
    final middleGoal = chart.middleGoals.firstWhere(
      (g) => g.position == _selectedMiddlePosition!,
    );
    
    // 中目標が空の場合は編集不可（通常はここには来ないはず）
    if (middleGoal.title.isEmpty) {
      _showValidationMessage('まず中目標を入力してください');
      return;
    }
    
    final smallGoal = middleGoal.smallGoals.firstWhere(
      (g) => g.position == smallPosition,
    );

    // 小目標が空でも入力済みでも、タップで編集ダイアログを開く
    _showEditDialog(
      context,
      '小目標',
      '中目標を達成するのに必要な目標',
      smallGoal.title,
      (newValue) {
        ref.read(mandalaChartProvider.notifier).updateSmallGoal(
              _selectedMiddlePosition!,
              smallPosition,
              newValue,
            );
      },
    );
  }

  /// 編集ダイアログを表示
  Future<void> _showEditDialog(
    BuildContext context,
    String title,
    String description,
    String initialValue,
    Function(String) onSave,
  ) async {
    final controller = TextEditingController(text: initialValue);

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: DesignTokens.fontSizeH4,
                  fontWeight: DesignTokens.fontWeightSemibold,
                ),
              ),
              const SizedBox(width: DesignTokens.spaceXs),
              GestureDetector(
                onTapDown: (details) {
                  _showTooltipMenu(dialogContext, details.globalPosition, description);
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: DesignTokens.foregroundSecondary,
                  ),
                ),
              ),
            ],
          ),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '目標を入力してください',
            ),
            maxLines: 3,
            autofocus: true,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeBody,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('キャンセル'),
            ),
            if (initialValue.isNotEmpty)
              TextButton(
                onPressed: () {
                  onSave('');
                  Navigator.of(dialogContext).pop();
                },
                child: const Text(
                  'クリア',
                  style: TextStyle(color: DesignTokens.errorPrimary),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }

  /// ツールチップメニューを表示
  Future<void> _showTooltipMenu(
    BuildContext context,
    Offset position,
    String description,
  ) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem<void>(
          enabled: false,
          padding: const EdgeInsets.symmetric(
            horizontal: DesignTokens.spaceSm + DesignTokens.spaceXs,
            vertical: DesignTokens.spaceSm,
          ),
          height: 0,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: DesignTokens.fontSizeBodySmall,
                color: DesignTokens.foregroundPrimary,
                height: DesignTokens.lineHeightNormal,
              ),
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
      ),
    );
  }


  /// バリデーションメッセージを表示
  void _showValidationMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: DesignTokens.backgroundSecondary,
              size: 20,
            ),
            const SizedBox(width: DesignTokens.spaceSm),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: DesignTokens.fontSizeBody,
                  color: DesignTokens.backgroundSecondary,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: DesignTokens.foregroundPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
