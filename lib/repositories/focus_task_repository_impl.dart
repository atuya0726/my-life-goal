import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/focus_task.dart';
import 'focus_task_repository.dart';

/// フォーカスタスクリポジトリ実装
class FocusTaskRepositoryImpl implements FocusTaskRepository {
  static const _key = 'focus_tasks';

  @override
  Future<FocusTaskList> loadFocusTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) {
      return FocusTaskList.empty();
    }
    
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      
      // 古いデータ構造（taskIds）をチェック
      if (json.containsKey('taskIds') && !json.containsKey('dailyTaskIds')) {
        // 古いデータ構造を検出 - クリアして新しい構造で開始
        await prefs.remove(_key);
        return FocusTaskList.empty();
      }
      
      return FocusTaskList.fromJson(json);
    } catch (e) {
      // パースエラーの場合は古いデータをクリアして新しく開始
      await prefs.remove(_key);
      return FocusTaskList.empty();
    }
  }

  @override
  Future<void> saveFocusTasks(FocusTaskList focusTasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(focusTasks.toJson());
    await prefs.setString(_key, jsonString);
  }
}

