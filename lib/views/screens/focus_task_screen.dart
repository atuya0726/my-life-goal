import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/task.dart';
import '../../models/focus_task.dart';
import '../../models/mandala_chart.dart';
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
  // 通常セクションの展開/折りたたみ状態
  final Map<FocusPeriod, bool> _periodExpanded = {
    FocusPeriod.awareness: true,
    FocusPeriod.daily: true,
    FocusPeriod.weekly: false,   // 週はデフォルトで閉じる
    FocusPeriod.monthly: false,  // 月はデフォルトで閉じる
    FocusPeriod.yearly: false,   // 年はデフォルトで閉じる
  };

  // 保留セクションの展開/折りたたみ状態
  final Map<TaskPeriod, bool> _pendingExpanded = {
    TaskPeriod.awareness: true,
    TaskPeriod.daily: true,
    TaskPeriod.weekly: false,    // 週はデフォルトで閉じる
    TaskPeriod.monthly: false,   // 月はデフォルトで閉じる
    TaskPeriod.yearly: false,    // 年はデフォルトで閉じる
  };

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
    final mandalaChartState = ref.watch(mandalaChartProvider);

    if (focusTaskState.isLoading || taskState.isLoading || mandalaChartState.isLoading) {
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
        ...focusTasks.awarenessTaskIds,
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
    final awarenessTasks = focusTasks?.awarenessTaskIds
            .map((id) => taskMap[id])
            .where((t) => t != null)
            .cast<Task>()
            .toList() ??
        [];

    final totalTasks = pendingTasks.length +
        dailyTasks.length +
        weeklyTasks.length +
        monthlyTasks.length +
        yearlyTasks.length +
        awarenessTasks.length;

    return Scaffold(
      body: Column(
        children: [
          // JUST DO IT!
          Padding(
            padding: const EdgeInsets.only(
              top: DesignTokens.spaceSm,
              right: DesignTokens.spaceMd,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'JUST DO IT!',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBodySmall,
                  fontWeight: DesignTokens.fontWeightBold,
                  color: DesignTokens.foregroundSecondary.withOpacity(0.5),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          
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
                          '意識',
                          FocusPeriod.awareness,
                          awarenessTasks,
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
                        const SizedBox(height: DesignTokens.spaceLg),
                        _buildPendingSection(
                          pendingTasks,
                          mandalaChartState.chart,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
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

  // 期間の範囲を取得
  String _getPeriodRange(FocusPeriod period) {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy/M/d');
    
    switch (period) {
      case FocusPeriod.yearly:
        final yearStart = DateTime(now.year, 1, 1);
        final yearEnd = DateTime(now.year, 12, 31);
        return '${dateFormat.format(yearStart)}〜${dateFormat.format(yearEnd)}';
      
      case FocusPeriod.monthly:
        final monthStart = DateTime(now.year, now.month, 1);
        final monthEnd = DateTime(now.year, now.month + 1, 0);
        return '${dateFormat.format(monthStart)}〜${dateFormat.format(monthEnd)}';
      
      case FocusPeriod.weekly:
        final weekday = now.weekday;
        final weekStart = now.subtract(Duration(days: weekday - 1)); // 月曜日
        final weekEnd = weekStart.add(const Duration(days: 6)); // 日曜日
        return '${dateFormat.format(weekStart)}〜${dateFormat.format(weekEnd)}';
      
      case FocusPeriod.daily:
        return dateFormat.format(now);
      
      case FocusPeriod.pending:
      case FocusPeriod.awareness:
        return '';
    }
  }

  Widget _buildPeriodSection(
    String label,
    FocusPeriod period,
    List<Task> tasks,
  ) {
    final periodRange = _getPeriodRange(period);
    final isExpanded = _periodExpanded[period] ?? false;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // トグル可能なセクションヘッダー
        InkWell(
          onTap: () {
            setState(() {
              _periodExpanded[period] = !isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DesignTokens.spaceXs,
              horizontal: DesignTokens.spaceXs,
            ),
            child: Row(
              children: [
                Icon(
                  isExpanded ? Icons.expand_more : Icons.chevron_right,
                  size: 20,
                  color: DesignTokens.foregroundSecondary,
                ),
                const SizedBox(width: DesignTokens.spaceXs),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spaceXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: DesignTokens.foregroundSecondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                    ),
                    child: Text(
                      '${tasks.length}',
                      style: const TextStyle(
                        fontSize: DesignTokens.fontSizeBodySmall,
                        fontWeight: DesignTokens.fontWeightMedium,
                        color: DesignTokens.foregroundSecondary,
                      ),
                    ),
                  ),
                if (periodRange.isNotEmpty) ...[
                  const SizedBox(width: DesignTokens.spaceXs),
                  Text(
                    '($periodRange)',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      color: DesignTokens.foregroundSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        
        // タスクリスト（展開時のみ表示）
        if (isExpanded) ...[
          const SizedBox(height: DesignTokens.spaceXs),
          if (tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.only(
                left: DesignTokens.spaceMd,
                top: DesignTokens.spaceXs,
                bottom: DesignTokens.spaceXs,
              ),
              child: Text(
                'タスクなし',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBodySmall,
                  color: DesignTokens.foregroundSecondary.withValues(alpha: 0.4),
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(left: DesignTokens.spaceMd),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final smallGoalInfo = _getSmallGoalInfo(task);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: DesignTokens.spaceSm),
                    child: _buildDismissibleTaskCard(task, period, smallGoalInfo),
                  );
                },
              ),
            ),
        ],
      ],
    );
  }


  Widget _buildPendingSection(List<Task> pendingTasks, MandalaChart mandalaChart) {
    if (pendingTasks.isEmpty) {
      return const SizedBox.shrink();
    }

    // タスクを期間別にグループ化
    final Map<TaskPeriod, List<Task>> tasksByPeriod = {
      TaskPeriod.awareness: [],
      TaskPeriod.daily: [],
      TaskPeriod.weekly: [],
      TaskPeriod.monthly: [],
      TaskPeriod.yearly: [],
    };
    
    for (final task in pendingTasks) {
      tasksByPeriod[task.period]?.add(task);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ヘッダー
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(DesignTokens.spaceXs),
                  decoration: BoxDecoration(
                    color: DesignTokens.foregroundSecondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                  ),
                  child: const Icon(
                    Icons.inbox,
                    size: 20,
                    color: DesignTokens.foregroundSecondary,
                  ),
                ),
                const SizedBox(width: DesignTokens.spaceSm),
                const Text(
                  '保留',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeH3,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: DesignTokens.foregroundPrimary,
                  ),
                ),
                const SizedBox(width: DesignTokens.spaceXs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spaceXs + 2,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: DesignTokens.foregroundSecondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                  ),
                  child: Text(
                    '${pendingTasks.length}',
                    style: const TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      fontWeight: DesignTokens.fontWeightSemibold,
                      color: DesignTokens.foregroundSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: DesignTokens.spaceMd),
        
        // 期間別のタスクリスト
        _buildPendingPeriodSection('意識', TaskPeriod.awareness, tasksByPeriod[TaskPeriod.awareness]!, mandalaChart),
        _buildPendingPeriodSection('今日', TaskPeriod.daily, tasksByPeriod[TaskPeriod.daily]!, mandalaChart),
        _buildPendingPeriodSection('今週', TaskPeriod.weekly, tasksByPeriod[TaskPeriod.weekly]!, mandalaChart),
        _buildPendingPeriodSection('今月', TaskPeriod.monthly, tasksByPeriod[TaskPeriod.monthly]!, mandalaChart),
        _buildPendingPeriodSection('今年', TaskPeriod.yearly, tasksByPeriod[TaskPeriod.yearly]!, mandalaChart),
      ],
    );
  }

  // TaskPeriodから期間範囲を取得
  String _getTaskPeriodRange(TaskPeriod period) {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy/M/d');
    
    switch (period) {
      case TaskPeriod.yearly:
        final yearStart = DateTime(now.year, 1, 1);
        final yearEnd = DateTime(now.year, 12, 31);
        return '${dateFormat.format(yearStart)}〜${dateFormat.format(yearEnd)}';
      
      case TaskPeriod.monthly:
        final monthStart = DateTime(now.year, now.month, 1);
        final monthEnd = DateTime(now.year, now.month + 1, 0);
        return '${dateFormat.format(monthStart)}〜${dateFormat.format(monthEnd)}';
      
      case TaskPeriod.weekly:
        final weekday = now.weekday;
        final weekStart = now.subtract(Duration(days: weekday - 1)); // 月曜日
        final weekEnd = weekStart.add(const Duration(days: 6)); // 日曜日
        return '${dateFormat.format(weekStart)}〜${dateFormat.format(weekEnd)}';
      
      case TaskPeriod.daily:
        return dateFormat.format(now);
      
      case TaskPeriod.awareness:
        return '';
    }
  }

  Widget _buildPendingPeriodSection(
    String label,
    TaskPeriod period,
    List<Task> tasks,
    MandalaChart mandalaChart,
  ) {
    if (tasks.isEmpty) {
      return const SizedBox.shrink();
    }

    final isExpanded = _pendingExpanded[period] ?? false;
    final periodRange = _getTaskPeriodRange(period);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // トグル可能なヘッダー
        InkWell(
          onTap: () {
            setState(() {
              _pendingExpanded[period] = !isExpanded;
            });
          },
          borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DesignTokens.spaceXs,
              horizontal: DesignTokens.spaceXs,
            ),
            child: Row(
              children: [
                Icon(
                  isExpanded ? Icons.expand_more : Icons.chevron_right,
                  size: 20,
                  color: DesignTokens.foregroundSecondary,
                ),
                const SizedBox(width: DesignTokens.spaceXs),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBody,
                    fontWeight: DesignTokens.fontWeightSemibold,
                    color: DesignTokens.foregroundPrimary,
                  ),
                ),
                const SizedBox(width: DesignTokens.spaceXs),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spaceXs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: DesignTokens.foregroundSecondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                  ),
                  child: Text(
                    '${tasks.length}',
                    style: const TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      fontWeight: DesignTokens.fontWeightMedium,
                      color: DesignTokens.foregroundSecondary,
                    ),
                  ),
                ),
                if (periodRange.isNotEmpty) ...[
                  const SizedBox(width: DesignTokens.spaceXs),
                  Text(
                    '($periodRange)',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      color: DesignTokens.foregroundSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        
        // タスクリスト（展開時のみ表示）
        if (isExpanded) ...[
          const SizedBox(height: DesignTokens.spaceXs),
          Padding(
            padding: const EdgeInsets.only(left: DesignTokens.spaceMd),
            child: Column(
              children: tasks.map((task) {
                final smallGoalInfo = _getSmallGoalInfo(task);
                return Padding(
                  padding: const EdgeInsets.only(bottom: DesignTokens.spaceSm),
                  child: _buildDismissibleTaskCard(task, FocusPeriod.pending, smallGoalInfo),
                );
              }).toList(),
            ),
          ),
        ],
        
        const SizedBox(height: DesignTokens.spaceSm),
      ],
    );
  }

  // タスクの小目標情報を取得
  Map<String, dynamic> _getSmallGoalInfo(Task task) {
    final mandalaChartState = ref.read(mandalaChartProvider);
    final mandalaChart = mandalaChartState.chart;
    
    String? smallGoalTitle;
    Color? middleGoalColor;
    
    for (final middleGoal in mandalaChart.middleGoals) {
      for (final smallGoal in middleGoal.smallGoals) {
        if (smallGoal.id == task.smallGoalId) {
          smallGoalTitle = smallGoal.title;
          middleGoalColor = DesignTokens.middleGoalColors[middleGoal.position % DesignTokens.middleGoalColors.length];
          break;
        }
      }
      if (smallGoalTitle != null) break;
    }
    
    return {
      'smallGoalTitle': smallGoalTitle,
      'middleGoalColor': middleGoalColor,
    };
  }

  /// スワイプ可能なタスクカードを構築
  Widget _buildDismissibleTaskCard(
    Task task,
    FocusPeriod period,
    Map<String, dynamic> smallGoalInfo,
  ) {
    return Dismissible(
      key: Key('task_${task.id}_${period.name}'),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: DesignTokens.spaceMd),
        decoration: BoxDecoration(
          color: DesignTokens.successPrimary,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 28),
            SizedBox(width: DesignTokens.spaceXs),
            Text(
              '完了',
              style: TextStyle(
                color: Colors.white,
                fontSize: DesignTokens.fontSizeBody,
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: DesignTokens.spaceMd),
        decoration: BoxDecoration(
          color: DesignTokens.errorPrimary,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '削除',
              style: TextStyle(
                color: Colors.white,
                fontSize: DesignTokens.fontSizeBody,
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            SizedBox(width: DesignTokens.spaceXs),
            Icon(Icons.delete, color: Colors.white, size: 28),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // 右スワイプ: 完了
          return true;
        } else if (direction == DismissDirection.endToStart) {
          // 左スワイプ: 削除確認
          return await _showDeleteConfirmDialog(context, task);
        }
        return false;
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // 右スワイプ: 完了処理
          await _handleTaskCompletion(task, period);
        } else if (direction == DismissDirection.endToStart) {
          // 左スワイプ: 削除処理
          await _handleTaskDeletion(task);
        }
      },
      child: TaskCardWidget(
        task: task,
        onTap: () {},
        onStatusChanged: (status) {
          ref.read(taskProvider.notifier).updateTaskStatus(task.id, status);
        },
        onLongPress: () => _showRemoveTaskDialog(context, task),
        actionButton: _buildPeriodActionButton(task, period),
        smallGoalTitle: smallGoalInfo['smallGoalTitle'],
        middleGoalColor: smallGoalInfo['middleGoalColor'],
      ),
    );
  }

  /// タスク完了処理
  Future<void> _handleTaskCompletion(Task task, FocusPeriod originalPeriod) async {
    // 完了前の状態を保存
    final previousStatus = task.status;
    
    // タスクを完了状態に更新
    await ref.read(taskProvider.notifier).updateTaskStatus(
      task.id,
      TaskStatus.completed,
    );
    
    // フォーカスタスクから削除
    await ref.read(focusTaskProvider.notifier).removeTask(task.id);
    
    // 1日タスクの場合は複製して保留に追加
    Task? duplicatedTask;
    if (originalPeriod == FocusPeriod.daily) {
      final now = DateTime.now();
      duplicatedTask = task.copyWith(
        id: '${now.millisecondsSinceEpoch}_task',
        status: TaskStatus.notStarted,
        createdAt: now,
        updatedAt: now,
      );
      await ref.read(taskProvider.notifier).addTask(duplicatedTask);
    }
    
    // アンドゥ可能なスナックバー表示
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: DesignTokens.spaceSm),
              Expanded(
                child: Text(
                  originalPeriod == FocusPeriod.daily
                      ? '「${task.title}」を完了しました\n（保留に複製されました）'
                      : '「${task.title}」を完了しました',
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBody,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: DesignTokens.successPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: '元に戻す',
            textColor: Colors.white,
            onPressed: () async {
              // タスクの状態を元に戻す
              await ref.read(taskProvider.notifier).updateTaskStatus(
                task.id,
                previousStatus,
              );
              // フォーカスタスクに再追加（元の期間に）
              await ref.read(focusTaskProvider.notifier).addTask(
                task.id,
                originalPeriod,
              );
              // 1日タスクの複製を削除
              if (duplicatedTask != null) {
                await ref.read(taskProvider.notifier).deleteTask(duplicatedTask.id);
              }
            },
          ),
        ),
      );
    }
  }

  /// タスク削除処理
  Future<void> _handleTaskDeletion(Task task) async {
    // タスク自体を削除（フォーカスからも削除される）
    await ref.read(taskProvider.notifier).deleteTask(task.id);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.delete,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: DesignTokens.spaceSm),
              Expanded(
                child: Text(
                  '「${task.title}」を削除しました',
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBody,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: DesignTokens.errorPrimary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// 削除確認ダイアログ
  Future<bool> _showDeleteConfirmDialog(BuildContext context, Task task) async {
    return await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'タスクを削除',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: Text(
            '「${task.title}」を削除しますか？\n（タスク自体も削除されます）',
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeBody,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.errorPrimary,
                foregroundColor: DesignTokens.backgroundSecondary,
              ),
              child: const Text('削除'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  Widget _buildPeriodActionButton(Task task, FocusPeriod period) {
    if (period == FocusPeriod.pending) {
      // 保留からタスクの期間に自動振り分け
      return IconButton(
        icon: const Icon(Icons.arrow_forward, size: 20),
        tooltip: 'タスク期間に振り分ける',
        color: DesignTokens.infoPrimary,
        onPressed: () {
          // タスクの期間に基づいてFocusPeriodを決定
          FocusPeriod targetPeriod;
          switch (task.period) {
            case TaskPeriod.daily:
              targetPeriod = FocusPeriod.daily;
              break;
            case TaskPeriod.weekly:
              targetPeriod = FocusPeriod.weekly;
              break;
            case TaskPeriod.monthly:
              targetPeriod = FocusPeriod.monthly;
              break;
            case TaskPeriod.yearly:
              targetPeriod = FocusPeriod.yearly;
              break;
            case TaskPeriod.awareness:
              targetPeriod = FocusPeriod.awareness;
              break;
          }
          
          // 振り分け実行
          ref.read(focusTaskProvider.notifier).addTask(task.id, targetPeriod);
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
            'タスクを削除',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: Text(
            '「${task.title}」を削除しますか？\n（タスク自体も削除されます）',
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
              onPressed: () async {
                // タスク自体を削除（フォーカスからも削除される）
                await ref.read(taskProvider.notifier).deleteTask(task.id);
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop();
                }
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
}
