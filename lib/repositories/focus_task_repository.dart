import '../models/focus_task.dart';

/// フォーカスタスクリポジトリ
abstract class FocusTaskRepository {
  Future<FocusTaskList> loadFocusTasks();
  Future<void> saveFocusTasks(FocusTaskList focusTasks);
}


