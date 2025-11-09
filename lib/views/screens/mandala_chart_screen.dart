import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../utils/design_tokens.dart';
import '../widgets/mandala_overview_widget.dart';
import '../widgets/mandala_detail_widget.dart';
import '../widgets/mandala_full_overview_widget.dart';

/// 表示モード
enum DisplayMode {
  fullOverview, // 全体表示（27×27）
  overview, // 中心表示（中心3×3）
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
              // ヘッダー（戻るボタンと切り替えボタン）
              _buildHeader(),
              // エラーメッセージ
              if (state.errorMessage != null) _buildErrorBanner(state),
              // マンダラチャート表示
              Expanded(
                child: _displayMode == DisplayMode.fullOverview
                    ? Stack(
                        children: [
                          Center(
                            child: AnimatedSwitcher(
                              duration: DesignTokens.durationNormal,
                              child: _buildFullOverviewMode(state),
                            ),
                          ),
                          // ヒントメッセージ
                          Positioned(
                            bottom: DesignTokens.spaceMd,
                            left: DesignTokens.spaceMd,
                            right: DesignTokens.spaceMd,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: DesignTokens.spaceSm + DesignTokens.spaceXs,
                                vertical: DesignTokens.spaceSm,
                              ),
                              decoration: BoxDecoration(
                                color: DesignTokens.foregroundPrimary.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                                boxShadow: DesignTokens.shadowMd,
                              ),
                              child: const Text(
                                'ピンチで拡大・縮小 / ドラッグで移動 / タップで詳細表示',
                                style: TextStyle(
                                  fontSize: DesignTokens.fontSizeBodySmall,
                                  color: DesignTokens.backgroundSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
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


  /// ヘッダーを構築
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spaceXs,
        vertical: DesignTokens.spaceXs,
      ),
      child: Row(
        children: [
          // 戻るボタン
          if (_displayMode == DisplayMode.detail)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _goBackToOverview,
              tooltip: '全体表示に戻る',
            ),
          if (_displayMode == DisplayMode.fullOverview)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _displayMode = DisplayMode.overview;
                });
              },
              tooltip: '中心表示に戻る',
            ),
          // タイトル
          if (_displayMode == DisplayMode.detail)
            const Text(
              '小目標を入力',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBodyLarge,
                fontWeight: DesignTokens.fontWeightSemibold,
              ),
            ),
          const Spacer(),
          // JUST DO IT!
          if (_displayMode == DisplayMode.overview)
            Text(
              'JUST DO IT!',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBodySmall,
                fontWeight: DesignTokens.fontWeightBold,
                color: DesignTokens.foregroundSecondary.withOpacity(0.5),
                letterSpacing: 0.5,
              ),
            ),
          if (_displayMode == DisplayMode.overview)
            const SizedBox(width: DesignTokens.spaceSm),
          // 全体表示切り替えボタン
          if (_displayMode == DisplayMode.overview)
            IconButton(
              icon: const Icon(Icons.grid_view),
              onPressed: () {
                setState(() {
                  _displayMode = DisplayMode.fullOverview;
                });
              },
              tooltip: '全体表示（27×27）',
            ),
        ],
      ),
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


  /// 全体表示モード（27×27）
  Widget _buildFullOverviewMode(state) {
    return MandalaFullOverviewWidget(
      key: const ValueKey('fullOverview'),
      chart: state.chart,
      onBlockTap: _onBlockTap,
    );
  }

  /// 中心表示モード（3×3）
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

  /// 中心表示に戻る
  void _goBackToOverview() {
    setState(() {
      _displayMode = DisplayMode.overview;
      _selectedMiddlePosition = null;
    });
  }

  /// 27×27ビューのブロックタップ処理
  void _onBlockTap(int? middlePosition) {
    setState(() {
      if (middlePosition == null) {
        // 中心ブロック（大目標）をタップした場合は中心表示へ
        _displayMode = DisplayMode.overview;
      } else {
        // 中目標ブロックをタップした場合は詳細表示へ
        _displayMode = DisplayMode.detail;
        _selectedMiddlePosition = middlePosition;
      }
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
    
    // 中目標が空の場合：次の空いている位置に新規入力
    if (title.isEmpty) {
      _showAddMiddleGoalDialog();
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
    
    // 空のセルの場合は新規入力
    if (middleGoal.title.isEmpty) {
      _showAddMiddleGoalDialog();
      return;
    }
    
    // 既に入力されている場合は編集
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

    // 小目標が空の場合：次の空いている位置に新規入力
    if (smallGoal.title.isEmpty) {
      _showAddSmallGoalDialog();
      return;
    }

    // 小目標が入力済みの場合：そのセルを編集
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

  /// 中目標の新規入力ダイアログを表示
  Future<void> _showAddMiddleGoalDialog() async {
    final chart = ref.read(mandalaChartProvider).chart;
    final nextPosition = chart.getNextEmptyMiddlePosition();
    
    if (nextPosition == null) {
      _showValidationMessage('中目標は全て入力済みです');
      return;
    }

    final controller = TextEditingController();

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            '中目標',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
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
            ElevatedButton(
              onPressed: () {
                ref.read(mandalaChartProvider.notifier).addMiddleGoal(controller.text);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }

  /// 小目標の新規入力ダイアログを表示
  Future<void> _showAddSmallGoalDialog() async {
    if (_selectedMiddlePosition == null) return;

    final chart = ref.read(mandalaChartProvider).chart;
    final nextPosition = chart.getNextEmptySmallPosition(_selectedMiddlePosition!);
    
    if (nextPosition == null) {
      _showValidationMessage('小目標は全て入力済みです');
      return;
    }

    final controller = TextEditingController();

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            '小目標',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
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
            ElevatedButton(
              onPressed: () {
                ref.read(mandalaChartProvider.notifier).addSmallGoal(
                  _selectedMiddlePosition!,
                  controller.text,
                );
                Navigator.of(dialogContext).pop();
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }
}
