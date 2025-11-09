import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/task.dart';
import '../../models/goal.dart';
import '../../models/focus_task.dart';
import '../../providers/providers.dart';
import '../../utils/design_tokens.dart';
import '../widgets/task_card_widget.dart';

/// タスク一覧画面
class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  // 完了タスクの展開/折りたたみ状態
  final Map<TaskPeriod, bool> _completedExpanded = {
    TaskPeriod.awareness: false,
    TaskPeriod.daily: false,
    TaskPeriod.weekly: false,
    TaskPeriod.monthly: false,
    TaskPeriod.yearly: false,
  };

  @override
  void initState() {
    super.initState();
    // 画面表示時にデータを読み込む
    Future.microtask(() async {
      await ref.read(taskProvider.notifier).load();
      await ref.read(mandalaChartProvider.notifier).load();
      
      // 小目標が存在し、何も選択されていない場合は最初の小目標を自動選択
      final chartState = ref.read(mandalaChartProvider);
      final taskState = ref.read(taskProvider);
      
      if (taskState.selectedSmallGoalId == null) {
        // マンダラチャートから小目標リストを作成
        for (final middleGoal in chartState.chart.middleGoals) {
          if (middleGoal.title.isNotEmpty) {
            for (final smallGoal in middleGoal.smallGoals) {
              if (smallGoal.title.isNotEmpty) {
                // 最初の小目標を選択
                ref.read(taskProvider.notifier).selectSmallGoal(smallGoal.id);
                return;
              }
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskProvider);
    final chartState = ref.watch(mandalaChartProvider);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: DesignTokens.spaceMd),

          // 小目標選択
          _buildSmallGoalSelector(chartState, taskState),
          
          // JUST DO IT!
          Padding(
            padding: const EdgeInsets.only(
              top: DesignTokens.spaceXs,
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
          const SizedBox(height: DesignTokens.spaceMd),

          // エラーメッセージ
          if (taskState.errorMessage != null) _buildErrorBanner(taskState),

          // 全期間のタスクリスト
          Expanded(
            child: taskState.isLoading
                ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                : _buildAllPeriodsTaskList(taskState),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallGoalSelector(chartState, taskState) {
    // マンダラチャートから中目標と小目標の階層構造を作成
    final middleGoalsWithSmall = <MiddleGoal>[];
    for (final middleGoal in chartState.chart.middleGoals) {
      if (middleGoal.title.isNotEmpty) {
        final hasSmallGoals = middleGoal.smallGoals.any((SmallGoal sg) => sg.title.isNotEmpty);
        if (hasSmallGoals) {
          middleGoalsWithSmall.add(middleGoal);
        }
      }
    }

    if (middleGoalsWithSmall.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceMd),
        child: Container(
          padding: const EdgeInsets.all(DesignTokens.spaceMd),
          decoration: BoxDecoration(
            color: DesignTokens.emptyBackground,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(
              color: DesignTokens.emptyBorder,
              width: DesignTokens.borderWidthThin,
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.info_outline,
                color: DesignTokens.foregroundSecondary,
                size: 20,
              ),
              SizedBox(width: DesignTokens.spaceSm),
              Expanded(
                child: Text(
                  'まずマンダラチャートで小目標を設定してください',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBody,
                    color: DesignTokens.foregroundSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // 階層構造のドロップダウンアイテムを作成
    final List<DropdownMenuItem<String>> items = [];
    for (final middleGoal in middleGoalsWithSmall) {
      // 中目標の色を取得
      final middleGoalColor = DesignTokens.middleGoalColors[middleGoal.position % DesignTokens.middleGoalColors.length];
      
      // 中目標ヘッダー（選択不可）
      items.add(
        DropdownMenuItem<String>(
          value: null,
          enabled: false,
          child: Row(
            children: [
              // 色のインジケーター
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: middleGoalColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: DesignTokens.spaceXs),
              Expanded(
                child: Text(
                  middleGoal.title,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBody,
                    fontWeight: DesignTokens.fontWeightSemibold,
                    color: DesignTokens.foregroundSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
      
      // 小目標（インデント付き）
      for (final smallGoal in middleGoal.smallGoals) {
        if (smallGoal.title.isNotEmpty) {
          items.add(
            DropdownMenuItem<String>(
              value: smallGoal.id,
              child: Padding(
                padding: const EdgeInsets.only(left: DesignTokens.spaceMd + DesignTokens.spaceXs),
                child: Row(
                  children: [
                    // 小さな色のインジケーター
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: middleGoalColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spaceXs),
                    Expanded(
                      child: Text(
                        smallGoal.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DesignTokens.spaceSm + DesignTokens.spaceXs,
          vertical: DesignTokens.spaceXs,
        ),
        decoration: BoxDecoration(
          color: DesignTokens.backgroundSecondary,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(
            color: DesignTokens.borderLight,
            width: DesignTokens.borderWidthThin,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: taskState.selectedSmallGoalId,
            hint: const Text(
              '小目標を選択',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBody,
                color: DesignTokens.foregroundSecondary,
              ),
            ),
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeBody,
              color: DesignTokens.foregroundPrimary,
            ),
            dropdownColor: DesignTokens.backgroundSecondary,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            items: items,
            onChanged: (value) {
              if (value != null) {
                ref.read(taskProvider.notifier).selectSmallGoal(value);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorBanner(taskState) {
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
              taskState.errorMessage!,
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

  Widget _buildAllPeriodsTaskList(taskState) {
    if (taskState.selectedSmallGoalId == null) {
      return const SizedBox.shrink();
    }

    // 小目標に関連する全タスクを取得
    final allTasks = taskState.allTasks
        .where((task) => task.smallGoalId == taskState.selectedSmallGoalId)
        .toList();

    // 期間ごとにタスクを分類
    final dailyTasks = allTasks.where((t) => t.period == TaskPeriod.daily).toList();
    final weeklyTasks = allTasks.where((t) => t.period == TaskPeriod.weekly).toList();
    final monthlyTasks = allTasks.where((t) => t.period == TaskPeriod.monthly).toList();
    final yearlyTasks = allTasks.where((t) => t.period == TaskPeriod.yearly).toList();
    final awarenessTasks = allTasks.where((t) => t.period == TaskPeriod.awareness).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSection('日', TaskPeriod.daily, dailyTasks),
          const SizedBox(height: DesignTokens.spaceLg),
          _buildPeriodSection('週', TaskPeriod.weekly, weeklyTasks),
          const SizedBox(height: DesignTokens.spaceLg),
          _buildPeriodSection('月', TaskPeriod.monthly, monthlyTasks),
          const SizedBox(height: DesignTokens.spaceLg),
          _buildPeriodSection('年', TaskPeriod.yearly, yearlyTasks),
          const SizedBox(height: DesignTokens.spaceLg),
          _buildPeriodSection('意識', TaskPeriod.awareness, awarenessTasks),
        ],
      ),
    );
  }

  // タスクの小目標情報を取得
  Map<String, dynamic> _getSmallGoalInfo(Task task) {
    final chartState = ref.read(mandalaChartProvider);
    final mandalaChart = chartState.chart;
    
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

  Widget _buildPeriodSection(String label, TaskPeriod period, List<Task> tasks) {
    // 完了タスクと未完了タスクを分ける
    final activeTasks = tasks.where((t) => t.status != TaskStatus.completed).toList();
    final completedTasks = tasks.where((t) => t.status == TaskStatus.completed).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // セクションヘッダー
        Row(
          children: [
            // 期間ラベル
            Text(
              label,
              style: const TextStyle(
                fontSize: DesignTokens.fontSizeBody,
                fontWeight: DesignTokens.fontWeightSemibold,
                color: DesignTokens.foregroundPrimary,
              ),
            ),
            const SizedBox(width: DesignTokens.spaceXs),
            // 未完了タスク数
            if (activeTasks.isNotEmpty)
              Text(
                '${activeTasks.length}',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBodySmall,
                  color: DesignTokens.foregroundSecondary.withValues(alpha: 0.6),
                ),
              ),
            const Spacer(),
            // ＋ボタン
            IconButton(
              icon: const Icon(Icons.add, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => _showAddTaskDialog(context, period),
            ),
          ],
        ),
        const SizedBox(height: DesignTokens.spaceSm),
        // 未完了タスクリスト
        ...activeTasks.map((task) {
          final smallGoalInfo = _getSmallGoalInfo(task);
          return Padding(
            padding: const EdgeInsets.only(bottom: DesignTokens.spaceSm),
            child: TaskCardWidget(
              task: task,
              onTap: () => _showEditTaskDialog(context, task),
              onStatusChanged: (status) {
                ref.read(taskProvider.notifier).updateTaskStatus(task.id, status);
              },
              onLongPress: () => _showTaskOptionsDialog(context, task),
              smallGoalTitle: smallGoalInfo['smallGoalTitle'],
              middleGoalColor: smallGoalInfo['middleGoalColor'],
            ),
          );
        }),
        // 完了タスクセクション
        if (completedTasks.isNotEmpty) ...[
          const SizedBox(height: DesignTokens.spaceXs),
          InkWell(
            onTap: () {
              setState(() {
                _completedExpanded[period] = !(_completedExpanded[period] ?? false);
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
                    _completedExpanded[period] == true 
                        ? Icons.expand_more 
                        : Icons.chevron_right,
                    size: 20,
                    color: DesignTokens.foregroundSecondary.withOpacity(0.6),
                  ),
                  const SizedBox(width: DesignTokens.spaceXs),
                  Text(
                    '完了済み',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      color: DesignTokens.foregroundSecondary.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spaceXs),
                  Text(
                    '${completedTasks.length}',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      color: DesignTokens.foregroundSecondary.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 完了タスクリスト（展開時のみ表示）
          if (_completedExpanded[period] == true) ...[
            const SizedBox(height: DesignTokens.spaceXs),
            ...completedTasks.map((task) {
              final smallGoalInfo = _getSmallGoalInfo(task);
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: DesignTokens.spaceSm,
                  left: DesignTokens.spaceMd,
                ),
                child: Opacity(
                  opacity: 0.6,
                  child: TaskCardWidget(
                    task: task,
                    onTap: () => _showEditTaskDialog(context, task),
                    onStatusChanged: (status) {
                      ref.read(taskProvider.notifier).updateTaskStatus(task.id, status);
                    },
                    onLongPress: () => _showTaskOptionsDialog(context, task),
                    smallGoalTitle: smallGoalInfo['smallGoalTitle'],
                    middleGoalColor: smallGoalInfo['middleGoalColor'],
                  ),
                ),
              );
            }),
          ],
        ],
      ],
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context, TaskPeriod period) async {
    final titleController = TextEditingController();

    // 期間から期限を自動計算
    final now = DateTime.now();
    DateTime dueDate;
    String periodLabel;
    
    switch (period) {
      case TaskPeriod.daily:
        dueDate = now.add(const Duration(days: 1));
        periodLabel = '1日後';
        break;
      case TaskPeriod.weekly:
        dueDate = now.add(const Duration(days: 7));
        periodLabel = '1週間後';
        break;
      case TaskPeriod.monthly:
        dueDate = DateTime(now.year, now.month + 1, now.day);
        periodLabel = '1ヶ月後';
        break;
      case TaskPeriod.yearly:
        dueDate = DateTime(now.year + 1, now.month, now.day);
        periodLabel = '1年後';
        break;
      case TaskPeriod.awareness:
        dueDate = now; // 意識は期限なし
        periodLabel = '意識';
        break;
    }

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            '新しいタスク（$periodLabel）',
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'タスク名',
              hintText: 'タスクを入力してください',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) {
                  return;
                }
                final taskState = ref.read(taskProvider);
                
                final task = Task.create(
                  title: titleController.text.trim(),
                  smallGoalId: taskState.selectedSmallGoalId!,
                  period: period,
                  description: '',
                  dueDate: dueDate,
                );
                ref.read(taskProvider.notifier).addTask(task);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('追加'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTaskDialog(BuildContext context, Task task) async {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'タスクを編集',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'タスク名',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await _showDeleteTaskDialog(context, task);
              },
              child: const Text(
                '削除',
                style: TextStyle(color: DesignTokens.errorPrimary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) {
                  return;
                }
                final updatedTask = task.copyWith(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  updatedAt: DateTime.now(),
                );
                ref.read(taskProvider.notifier).updateTask(updatedTask);
                Navigator.of(dialogContext).pop();
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTaskOptionsDialog(BuildContext context, Task task) async {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            task.title,
            style: const TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DesignTokens.spaceMd,
                  vertical: DesignTokens.spaceXs,
                ),
                child: Text(
                  'フォーカスに追加',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBodySmall,
                    color: DesignTokens.foregroundSecondary,
                    fontWeight: DesignTokens.fontWeightSemibold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.lightbulb_outline),
                title: const Text('意識'),
                onTap: () {
                  ref.read(focusTaskProvider.notifier).addTask(task.id, FocusPeriod.awareness);
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('意識のフォーカスに追加しました'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.today),
                title: const Text('今日'),
                onTap: () {
                  ref.read(focusTaskProvider.notifier).addTask(task.id, FocusPeriod.daily);
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('今日のフォーカスに追加しました'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.view_week),
                title: const Text('今週'),
                onTap: () {
                  ref.read(focusTaskProvider.notifier).addTask(task.id, FocusPeriod.weekly);
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('今週のフォーカスに追加しました'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text('今月'),
                onTap: () {
                  ref.read(focusTaskProvider.notifier).addTask(task.id, FocusPeriod.monthly);
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('今月のフォーカスに追加しました'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('今年'),
                onTap: () {
                  ref.read(focusTaskProvider.notifier).addTask(task.id, FocusPeriod.yearly);
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('今年のフォーカスに追加しました'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: DesignTokens.errorPrimary),
                title: const Text('削除', style: TextStyle(color: DesignTokens.errorPrimary)),
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  _showDeleteTaskDialog(context, task);
                },
              ),
            ],
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

  Future<void> _showDeleteTaskDialog(BuildContext context, Task task) async {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            '削除確認',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: Text(
            '「${task.title}」を削除しますか？',
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
                ref.read(taskProvider.notifier).deleteTask(task.id);
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
}

