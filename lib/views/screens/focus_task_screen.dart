import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import '../../models/focus_task.dart';
import '../../providers/providers.dart';
import '../../utils/design_tokens.dart';
import '../widgets/task_card_widget.dart';

/// フォーカスタスク画面
class FocusTaskScreen extends ConsumerStatefulWidget {
  const FocusTaskScreen({super.key});

  @override
  ConsumerState<FocusTaskScreen> createState() => _FocusTaskScreenState();
}

class _FocusTaskScreenState extends ConsumerState<FocusTaskScreen> {
  @override
  void initState() {
    super.initState();
    // 画面表示時にデータを読み込む
    Future.microtask(() {
      ref.read(focusTaskProvider.notifier).load();
      ref.read(taskProvider.notifier).load();
      ref.read(mandalaChartProvider.notifier).load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final focusTaskState = ref.watch(focusTaskProvider);
    final taskState = ref.watch(taskProvider);

    if (focusTaskState.isLoading || taskState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    // すべての期間のタスクIDを統合して、実際のTaskオブジェクトのマップを作成
    final focusTasks = focusTaskState.focusTasks;
    final allFocusTaskIds = <String>{
      if (focusTasks != null) ...[
        ...focusTasks.pendingTaskIds,
        ...focusTasks.dailyTaskIds,
        ...focusTasks.weeklyTaskIds,
        ...focusTasks.monthlyTaskIds,
        ...focusTasks.yearlyTaskIds,
      ]
    };

    final taskMap = <String, Task>{};
    for (final taskId in allFocusTaskIds) {
      try {
        final task = taskState.allTasks.firstWhere((t) => t.id == taskId);
        taskMap[taskId] = task;
      } catch (e) {
        // タスクが見つからない場合はスキップ
      }
    }

    // 期間別のタスクリストを作成
    final pendingTasks = focusTasks?.pendingTaskIds
            .map((id) => taskMap[id])
            .where((t) => t != null)
            .cast<Task>()
            .toList() ??
        [];
    final dailyTasks = focusTasks?.dailyTaskIds
            .map((id) => taskMap[id])
            .where((t) => t != null)
            .cast<Task>()
            .toList() ??
        [];
    final weeklyTasks = focusTasks?.weeklyTaskIds
            .map((id) => taskMap[id])
            .where((t) => t != null)
            .cast<Task>()
            .toList() ??
        [];
    final monthlyTasks = focusTasks?.monthlyTaskIds
            .map((id) => taskMap[id])
            .where((t) => t != null)
            .cast<Task>()
            .toList() ??
        [];
    final yearlyTasks = focusTasks?.yearlyTaskIds
            .map((id) => taskMap[id])
            .where((t) => t != null)
            .cast<Task>()
            .toList() ??
        [];

    final totalTasks = pendingTasks.length +
        dailyTasks.length +
        weeklyTasks.length +
        monthlyTasks.length +
        yearlyTasks.length;

    return Scaffold(
      body: Column(
        children: [
          // エラーメッセージ
          if (focusTaskState.errorMessage != null)
            _buildErrorBanner(focusTaskState.errorMessage!),

          // フォーカスタスクリスト
          Expanded(
            child: totalTasks == 0
                ? _buildEmptyState()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(DesignTokens.spaceMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPeriodSection(
                          '保留',
                          FocusPeriod.pending,
                          pendingTasks,
                        ),
                        const SizedBox(height: DesignTokens.spaceLg),
                        _buildPeriodSection(
                          '今日',
                          FocusPeriod.daily,
                          dailyTasks,
                        ),
                        const SizedBox(height: DesignTokens.spaceLg),
                        _buildPeriodSection(
                          '今週',
                          FocusPeriod.weekly,
                          weeklyTasks,
                        ),
                        const SizedBox(height: DesignTokens.spaceLg),
                        _buildPeriodSection(
                          '今月',
                          FocusPeriod.monthly,
                          monthlyTasks,
                        ),
                        const SizedBox(height: DesignTokens.spaceLg),
                        _buildPeriodSection(
                          '今年',
                          FocusPeriod.yearly,
                          yearlyTasks,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showSmallGoalSelectionDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('小目標から追加'),
        backgroundColor: DesignTokens.infoPrimary,
        foregroundColor: DesignTokens.backgroundSecondary,
      ),
    );
  }

  Widget _buildErrorBanner(String errorMessage) {
    return Container(
      color: DesignTokens.errorLight,
      padding:
          const EdgeInsets.all(DesignTokens.spaceSm + DesignTokens.spaceXs),
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
              errorMessage,
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.center_focus_strong,
              size: 64,
              color: DesignTokens.foregroundSecondary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: DesignTokens.spaceMd),
            Text(
              'フォーカスタスクがありません',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBody,
                color: DesignTokens.foregroundSecondary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXs),
            Text(
              'タスク一覧から追加してください',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBodySmall,
                color: DesignTokens.foregroundSecondary.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSection(
    String label,
    FocusPeriod period,
    List<Task> tasks,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // セクションヘッダー
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: DesignTokens.fontSizeBody,
                fontWeight: DesignTokens.fontWeightSemibold,
                color: DesignTokens.foregroundPrimary,
              ),
            ),
            const SizedBox(width: DesignTokens.spaceXs),
            if (tasks.isNotEmpty)
              Text(
                '${tasks.length}',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBodySmall,
                  color: DesignTokens.foregroundSecondary.withValues(alpha: 0.6),
                ),
              ),
          ],
        ),
        const SizedBox(height: DesignTokens.spaceSm),
        // タスクリスト
        if (tasks.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: DesignTokens.spaceXs),
            child: Text(
              'タスクなし',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBodySmall,
                color: DesignTokens.foregroundSecondary.withValues(alpha: 0.4),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Padding(
                padding:
                    const EdgeInsets.only(bottom: DesignTokens.spaceSm),
                child: TaskCardWidget(
                  task: task,
                  onTap: () {}, // タップ無効化
                  onStatusChanged: (status) {
                    ref
                        .read(taskProvider.notifier)
                        .updateTaskStatus(task.id, status);
                  },
                  onLongPress: () =>
                      _showRemoveTaskDialog(context, task),
                  actionButton: _buildPeriodActionButton(task, period),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _buildPeriodActionButton(Task task, FocusPeriod period) {
    if (period == FocusPeriod.pending) {
      // 保留から元の期間に戻すボタン
      return IconButton(
        icon: const Icon(Icons.restore, size: 20),
        tooltip: '元の期間に戻す',
        color: DesignTokens.infoPrimary,
        onPressed: () {
          ref.read(focusTaskProvider.notifier).moveTaskFromPending(task.id);
        },
      );
    } else {
      // 保留に移動ボタン
      return IconButton(
        icon: const Icon(Icons.pause_circle_outline, size: 20),
        tooltip: '保留に移動',
        color: DesignTokens.foregroundSecondary,
        onPressed: () {
          ref.read(focusTaskProvider.notifier).moveTaskToPending(task.id, period);
        },
      );
    }
  }

  Future<void> _showRemoveTaskDialog(BuildContext context, Task task) async {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'フォーカスから削除',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: Text(
            '「${task.title}」をフォーカスから削除しますか？\n（タスク自体は削除されません）',
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
                ref.read(focusTaskProvider.notifier).removeTask(task.id);
                Navigator.of(dialogContext).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.errorPrimary,
                foregroundColor: DesignTokens.backgroundSecondary,
              ),
              child: const Text('削除'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSmallGoalSelectionDialog(BuildContext context) async {
    final mandalaChartState = ref.read(mandalaChartProvider);
    final mandalaChart = mandalaChartState.chart;

    // 全ての小目標を収集（タイトルが空でないもの）
    final smallGoals = <Map<String, String>>[];
    for (final middleGoal in mandalaChart.middleGoals) {
      if (middleGoal.title.isEmpty) continue;
      for (final smallGoal in middleGoal.smallGoals) {
        if (smallGoal.title.isEmpty) continue;
        smallGoals.add({
          'id': smallGoal.id,
          'title': smallGoal.title,
          'middleGoalTitle': middleGoal.title,
        });
      }
    }

    if (smallGoals.isEmpty) {
      // 小目標が存在しない場合
      return showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text(
              '小目標がありません',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeH4,
                fontWeight: DesignTokens.fontWeightSemibold,
              ),
            ),
            content: const Text(
              '先にマンダラチャートで小目標を設定してください。',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBody,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('閉じる'),
              ),
            ],
          );
        },
      );
    }

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            '小目標を選択',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: smallGoals.length,
              itemBuilder: (context, index) {
                final smallGoal = smallGoals[index];
                return ListTile(
                  leading: Icon(
                    Icons.filter_none,
                    color: DesignTokens.infoPrimary,
                  ),
                  title: Text(
                    smallGoal['title']!,
                    style: const TextStyle(
                      fontSize: DesignTokens.fontSizeBody,
                      fontWeight: DesignTokens.fontWeightMedium,
                    ),
                  ),
                  subtitle: Text(
                    '中目標: ${smallGoal['middleGoalTitle']}',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      color: DesignTokens.foregroundSecondary
                          .withValues(alpha: 0.7),
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(dialogContext).pop();
                    
                    // タスクを追加
                    await ref
                        .read(focusTaskProvider.notifier)
                        .addTasksFromSmallGoal(smallGoal['id']!);
                    
                    // 完了メッセージを表示
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '「${smallGoal['title']}」の関連タスクを追加しました',
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: DesignTokens.successPrimary,
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('キャンセル'),
            ),
          ],
        );
      },
    );
  }
}
