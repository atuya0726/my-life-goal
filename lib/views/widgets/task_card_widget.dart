import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../utils/design_tokens.dart';

/// タスクカードウィジェット
class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required this.task,
    required this.onTap,
    required this.onStatusChanged,
    this.onLongPress,
    this.actionButton,
  });

  final Task task;
  final VoidCallback onTap;
  final Function(TaskStatus) onStatusChanged;
  final VoidCallback? onLongPress;
  final Widget? actionButton;

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        side: BorderSide(
          color: isCompleted
              ? DesignTokens.borderLight
              : DesignTokens.borderMedium,
          width: DesignTokens.borderWidthThin,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spaceSm + DesignTokens.spaceXs),
          child: Row(
            children: [
              // チェックボックス
              _buildCheckbox(isCompleted),
              const SizedBox(width: DesignTokens.spaceSm + DesignTokens.spaceXs),
              // タスク情報
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBody,
                        fontWeight: DesignTokens.fontWeightSemibold,
                        color: isCompleted
                            ? DesignTokens.foregroundSecondary
                            : DesignTokens.foregroundPrimary,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: DesignTokens.spaceXs),
                      Text(
                        task.description,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSizeBodySmall,
                          color: DesignTokens.foregroundSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              // アクションボタン
              if (actionButton != null) actionButton!,
              // ステータスインジケーター
              if (task.status == TaskStatus.inProgress)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spaceSm,
                    vertical: DesignTokens.spaceXs,
                  ),
                  decoration: BoxDecoration(
                    color: DesignTokens.middleBackground,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                  ),
                  child: const Text(
                    '進行中',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      color: DesignTokens.middleText,
                      fontWeight: DesignTokens.fontWeightSemibold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(bool isCompleted) {
    return GestureDetector(
      onTap: () {
        if (isCompleted) {
          onStatusChanged(TaskStatus.notStarted);
        } else {
          onStatusChanged(TaskStatus.completed);
        }
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isCompleted
                ? DesignTokens.centerBorder
                : DesignTokens.borderMedium,
            width: DesignTokens.borderWidthMedium,
          ),
          color: isCompleted
              ? DesignTokens.centerBackground
              : Colors.transparent,
        ),
        child: isCompleted
            ? const Icon(
                Icons.check,
                size: 16,
                color: DesignTokens.centerText,
              )
            : null,
      ),
    );
  }
}

