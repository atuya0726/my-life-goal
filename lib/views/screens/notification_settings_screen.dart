import 'package:flutter/material.dart';
import '../../services/notification_service.dart';
import '../../utils/design_tokens.dart';

/// 通知設定画面
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final _notificationService = NotificationService();

  bool _morningEnabled = true;
  TimeOfDay _morningTime = const TimeOfDay(hour: 7, minute: 0);

  bool _eveningEnabled = true;
  TimeOfDay _eveningTime = const TimeOfDay(hour: 22, minute: 0);

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final morning = await _notificationService.getMorningSettings();
    final evening = await _notificationService.getEveningSettings();

    setState(() {
      _morningEnabled = morning['enabled'];
      _morningTime = TimeOfDay(
        hour: morning['hour'],
        minute: morning['minute'],
      );
      _eveningEnabled = evening['enabled'];
      _eveningTime = TimeOfDay(
        hour: evening['hour'],
        minute: evening['minute'],
      );
      _isLoading = false;
    });
  }

  Future<void> _saveMorningSettings() async {
    if (_morningEnabled) {
      await _notificationService.scheduleMorningNotification(
        hour: _morningTime.hour,
        minute: _morningTime.minute,
      );
    } else {
      await _notificationService.cancelMorningNotification();
    }
  }

  Future<void> _saveEveningSettings() async {
    if (_eveningEnabled) {
      await _notificationService.scheduleEveningNotification(
        hour: _eveningTime.hour,
        minute: _eveningTime.minute,
      );
    } else {
      await _notificationService.cancelEveningNotification();
    }
  }

  Future<void> _selectMorningTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _morningTime,
    );

    if (selectedTime != null) {
      setState(() {
        _morningTime = selectedTime;
      });
      await _saveMorningSettings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('朝の通知時刻を設定しました')),
        );
      }
    }
  }

  Future<void> _selectEveningTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _eveningTime,
    );

    if (selectedTime != null) {
      setState(() {
        _eveningTime = selectedTime;
      });
      await _saveEveningSettings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('夜の通知時刻を設定しました')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('通知設定'),
        ),
        body: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知設定'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(DesignTokens.spaceMd),
        children: [
          // 朝の通知
          Card(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.wb_sunny, color: DesignTokens.warningPrimary),
                      const SizedBox(width: DesignTokens.spaceSm),
                      const Expanded(
                        child: Text(
                          '朝の通知',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeH4,
                            fontWeight: DesignTokens.fontWeightSemibold,
                          ),
                        ),
                      ),
                      Switch(
                        value: _morningEnabled,
                        onChanged: (value) async {
                          setState(() {
                            _morningEnabled = value;
                          });
                          await _saveMorningSettings();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                  const Text(
                    '「今日のタスクを設定してください」',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      color: DesignTokens.foregroundSecondary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  InkWell(
                    onTap: _morningEnabled ? _selectMorningTime : null,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    child: Container(
                      padding: const EdgeInsets.all(DesignTokens.spaceSm + DesignTokens.spaceXs),
                      decoration: BoxDecoration(
                        color: DesignTokens.backgroundPrimary,
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        border: Border.all(
                          color: DesignTokens.borderMedium,
                          width: DesignTokens.borderWidthThin,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, size: 20),
                          const SizedBox(width: DesignTokens.spaceSm),
                          Text(
                            _morningTime.format(context),
                            style: const TextStyle(
                              fontSize: DesignTokens.fontSizeBodyLarge,
                              fontWeight: DesignTokens.fontWeightMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: DesignTokens.spaceMd),

          // 夜の通知
          Card(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.nightlight, color: DesignTokens.infoPrimary),
                      const SizedBox(width: DesignTokens.spaceSm),
                      const Expanded(
                        child: Text(
                          '夜の通知',
                          style: TextStyle(
                            fontSize: DesignTokens.fontSizeH4,
                            fontWeight: DesignTokens.fontWeightSemibold,
                          ),
                        ),
                      ),
                      Switch(
                        value: _eveningEnabled,
                        onChanged: (value) async {
                          setState(() {
                            _eveningEnabled = value;
                          });
                          await _saveEveningSettings();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                  const Text(
                    '「達成したタスクを完了してください」',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBodySmall,
                      color: DesignTokens.foregroundSecondary,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  InkWell(
                    onTap: _eveningEnabled ? _selectEveningTime : null,
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                    child: Container(
                      padding: const EdgeInsets.all(DesignTokens.spaceSm + DesignTokens.spaceXs),
                      decoration: BoxDecoration(
                        color: DesignTokens.backgroundPrimary,
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        border: Border.all(
                          color: DesignTokens.borderMedium,
                          width: DesignTokens.borderWidthThin,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time, size: 20),
                          const SizedBox(width: DesignTokens.spaceSm),
                          Text(
                            _eveningTime.format(context),
                            style: const TextStyle(
                              fontSize: DesignTokens.fontSizeBodyLarge,
                              fontWeight: DesignTokens.fontWeightMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

