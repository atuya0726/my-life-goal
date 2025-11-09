import 'package:flutter/material.dart';
import '../../utils/design_tokens.dart';
import 'mandala_chart_screen.dart';
import 'task_list_screen.dart';
import 'focus_task_screen.dart';
import 'notification_settings_screen.dart';

/// メイン画面（タブナビゲーション）
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    MandalaChartScreen(),
    TaskListScreen(),
    FocusTaskScreen(),
  ];

  static const List<String> _titles = [
    'マンダラチャート',
    'タスク一覧',
    'フォーカス',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          // 通知設定ボタン
          IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 20),
            tooltip: '通知設定',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsScreen(),
                ),
              );
            },
          ),
          // マンダラチャートのメニュー
          if (_selectedIndex == 0) ..._buildMandalaChartActions(),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_on),
            selectedIcon: Icon(Icons.grid_on),
            label: 'マンダラ',
          ),
          NavigationDestination(
            icon: Icon(Icons.checklist),
            selectedIcon: Icon(Icons.checklist),
            label: 'タスク一覧',
          ),
          NavigationDestination(
            icon: Icon(Icons.center_focus_strong),
            selectedIcon: Icon(Icons.center_focus_strong),
            label: 'フォーカス',
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMandalaChartActions() {
    return [
      PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 20),
        tooltip: 'メニュー',
        offset: const Offset(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        ),
        itemBuilder: (context) => [
          const PopupMenuItem<String>(
            value: 'reset',
            child: Row(
              children: [
                Icon(
                  Icons.refresh,
                  size: 18,
                  color: DesignTokens.errorPrimary,
                ),
                SizedBox(width: DesignTokens.spaceSm),
                Text(
                  'すべてリセット',
                  style: TextStyle(
                    color: DesignTokens.errorPrimary,
                    fontSize: DesignTokens.fontSizeBody,
                  ),
                ),
              ],
            ),
          ),
        ],
        onSelected: (value) {
          if (value == 'reset') {
            _showResetDialog();
          }
        },
      ),
    ];
  }

  Future<void> _showResetDialog() async {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'リセット確認',
            style: TextStyle(
              fontSize: DesignTokens.fontSizeH4,
              fontWeight: DesignTokens.fontWeightSemibold,
            ),
          ),
          content: const Text(
            'マンダラチャートのすべてのデータを削除してリセットしますか？\n\n※タスクは削除されません',
            style: TextStyle(
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
                // リセット処理はMandalaChartScreenで行われる
                Navigator.of(dialogContext).pop();
                // MandalaChartScreenのリセットを呼び出す必要がある
                // この実装は後で改善できる
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.errorPrimary,
                foregroundColor: DesignTokens.backgroundSecondary,
              ),
              child: const Text('リセット'),
            ),
          ],
        );
      },
    );
  }
}

