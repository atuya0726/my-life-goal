import 'package:flutter/material.dart';
import '../../models/task.dart';
import '../../utils/design_tokens.dart';

/// 期間フィルターウィジェット
class PeriodFilterWidget extends StatelessWidget {
  const PeriodFilterWidget({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  final TaskPeriod selectedPeriod;
  final Function(TaskPeriod) onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceMd),
      child: Row(
        children: TaskPeriod.values.map((period) {
          final isSelected = period == selectedPeriod;
          return Padding(
            padding: const EdgeInsets.only(right: DesignTokens.spaceSm),
            child: FilterChip(
              label: Text(period.label),
              selected: isSelected,
              onSelected: (_) => onPeriodChanged(period),
              backgroundColor: DesignTokens.backgroundSecondary,
              selectedColor: DesignTokens.centerBackground,
              labelStyle: TextStyle(
                color: isSelected
                    ? DesignTokens.centerText
                    : DesignTokens.foregroundSecondary,
                fontWeight: isSelected
                    ? DesignTokens.fontWeightSemibold
                    : DesignTokens.fontWeightRegular,
                fontSize: DesignTokens.fontSizeBody,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spaceSm + DesignTokens.spaceXs,
                vertical: DesignTokens.spaceSm,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                side: BorderSide(
                  color: isSelected
                      ? DesignTokens.centerBorder
                      : DesignTokens.borderLight,
                  width: isSelected
                      ? DesignTokens.borderWidthMedium
                      : DesignTokens.borderWidthThin,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

