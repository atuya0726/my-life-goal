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
    // マンダラチャートから小目標リストを作成
    final smallGoals = <SmallGoal>[];
    for (final middleGoal in chartState.chart.middleGoals) {
      if (middleGoal.title.isNotEmpty) {
        for (final smallGoal in middleGoal.smallGoals) {
          if (smallGoal.title.isNotEmpty) {
            smallGoals.add(smallGoal);
          }
        }
      }
    }

    if (smallGoals.isEmpty) {
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
            items: smallGoals.map((smallGoal) {
              return DropdownMenuItem<String>(
                value: smallGoal.id,
                child: Text(
                  smallGoal.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (value) {
              ref.read(taskProvider.notifier).selectSmallGoal(value);
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPeriodSection('1日', TaskPeriod.daily, dailyTasks),
          const SizedBox(height: DesignTokens.spaceLg),
          _buildPeriodSection('1週間', TaskPeriod.weekly, weeklyTasks),
          const SizedBox(height: DesignTokens.spaceLg),
          _buildPeriodSection('1月', TaskPeriod.monthly, monthlyTasks),
          const SizedBox(height: DesignTokens.spaceLg),
          _buildPeriodSection('1年', TaskPeriod.yearly, yearlyTasks),
        ],
      ),
    );
  }

  Widget _buildPeriodSection(String label, TaskPeriod period, List<Task> tasks) {
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
            // タスク数
            if (tasks.isNotEmpty)
              Text(
                '${tasks.length}',
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
        // タスクリスト
        ...tasks.map((task) => Padding(
              padding: const EdgeInsets.only(bottom: DesignTokens.spaceSm),
              child: TaskCardWidget(
                task: task,
                onTap: () => _showEditTaskDialog(context, task),
                onStatusChanged: (status) {
                  ref.read(taskProvider.notifier).updateTaskStatus(task.id, status);
                },
                onLongPress: () => _showTaskOptionsDialog(context, task),
              ),
            )),
      ],
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context, TaskPeriod period) async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'タスク名',
                  hintText: 'タスクを入力してください',
                ),
                autofocus: true,
              ),
              const SizedBox(height: DesignTokens.spaceMd),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: '説明（オプション）',
                  hintText: 'タスクの詳細を入力してください',
                ),
                maxLines: 3,
              ),
            ],
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
                  description: descriptionController.text.trim(),
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
    TaskStatus selectedStatus = task.status;

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'タスクを編集',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeH4,
                  fontWeight: DesignTokens.fontWeightSemibold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'タスク名',
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spaceMd),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: '説明',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: DesignTokens.spaceMd),
                    const Text(
                      'ステータス',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBody,
                        fontWeight: DesignTokens.fontWeightSemibold,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spaceXs),
                    SegmentedButton<TaskStatus>(
                      segments: const [
                        ButtonSegment(
                          value: TaskStatus.notStarted,
                          label: Text('未着手', style: TextStyle(fontSize: DesignTokens.fontSizeBodySmall)),
                        ),
                        ButtonSegment(
                          value: TaskStatus.inProgress,
                          label: Text('進行中', style: TextStyle(fontSize: DesignTokens.fontSizeBodySmall)),
                        ),
                        ButtonSegment(
                          value: TaskStatus.completed,
                          label: Text('完了', style: TextStyle(fontSize: DesignTokens.fontSizeBodySmall)),
                        ),
                      ],
                      selected: {selectedStatus},
                      onSelectionChanged: (Set<TaskStatus> selection) {
                        setState(() {
                          selectedStatus = selection.first;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('キャンセル'),
                ),
                TextButton(
                  onPressed: () {
                    _showDeleteTaskDialog(context, task);
                    Navigator.of(dialogContext).pop();
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
                      status: selectedStatus,
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

