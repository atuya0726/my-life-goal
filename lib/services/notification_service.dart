import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';

/// 通知サービス
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // 通知ID
  static const int morningNotificationId = 1;
  static const int eveningNotificationId = 2;

  // SharedPreferencesキー
  static const String _morningTimeKey = 'morning_notification_time';
  static const String _eveningTimeKey = 'evening_notification_time';
  static const String _morningEnabledKey = 'morning_notification_enabled';
  static const String _eveningEnabledKey = 'evening_notification_enabled';

  /// 初期化
  Future<void> initialize() async {
    // タイムゾーンデータを初期化
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));

    // Android設定
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS設定
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // 権限をリクエスト
    await _requestPermissions();
  }

  /// 権限をリクエスト
  Future<void> _requestPermissions() async {
    final androidImpl =
        _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.requestNotificationsPermission();

    final iosImpl = _notifications.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await iosImpl?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// 通知タップ時の処理
  void _onNotificationTapped(NotificationResponse response) {
    // 通知タップ時の処理（必要に応じて実装）
  }

  /// 朝の通知をスケジュール
  Future<void> scheduleMorningNotification({
    required int hour,
    required int minute,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_morningTimeKey, hour * 60 + minute);
    await prefs.setBool(_morningEnabledKey, true);

    await _scheduleNotification(
      id: morningNotificationId,
      title: '今日のタスクを設定しましょう',
      body: 'フォーカスタスクで今日やることを決めましょう！',
      hour: hour,
      minute: minute,
    );
  }

  /// 夜の通知をスケジュール
  Future<void> scheduleEveningNotification({
    required int hour,
    required int minute,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_eveningTimeKey, hour * 60 + minute);
    await prefs.setBool(_eveningEnabledKey, true);

    await _scheduleNotification(
      id: eveningNotificationId,
      title: 'タスクを完了しましょう',
      body: '今日達成したタスクを完了にしましょう！',
      hour: hour,
      minute: minute,
    );
  }

  /// 通知をスケジュール
  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // 今日の時刻が過ぎていたら明日にスケジュール
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_notification',
          '毎日の通知',
          channelDescription: '朝と夜の定期通知',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// 通知をキャンセル
  Future<void> cancelMorningNotification() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_morningEnabledKey, false);
    await _notifications.cancel(morningNotificationId);
  }

  Future<void> cancelEveningNotification() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_eveningEnabledKey, false);
    await _notifications.cancel(eveningNotificationId);
  }

  /// 保存された設定を読み込んで通知を再スケジュール
  Future<void> rescheduleNotifications() async {
    final prefs = await SharedPreferences.getInstance();

    // 朝の通知
    final morningEnabled = prefs.getBool(_morningEnabledKey) ?? true;
    final morningMinutes = prefs.getInt(_morningTimeKey) ?? (7 * 60); // デフォルト7:00
    if (morningEnabled) {
      await scheduleMorningNotification(
        hour: morningMinutes ~/ 60,
        minute: morningMinutes % 60,
      );
    }

    // 夜の通知
    final eveningEnabled = prefs.getBool(_eveningEnabledKey) ?? true;
    final eveningMinutes = prefs.getInt(_eveningTimeKey) ?? (22 * 60); // デフォルト22:00
    if (eveningEnabled) {
      await scheduleEveningNotification(
        hour: eveningMinutes ~/ 60,
        minute: eveningMinutes % 60,
      );
    }
  }

  /// 朝の通知設定を取得
  Future<Map<String, dynamic>> getMorningSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_morningEnabledKey) ?? true;
    final minutes = prefs.getInt(_morningTimeKey) ?? (7 * 60);
    return {
      'enabled': enabled,
      'hour': minutes ~/ 60,
      'minute': minutes % 60,
    };
  }

  /// 夜の通知設定を取得
  Future<Map<String, dynamic>> getEveningSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_eveningEnabledKey) ?? true;
    final minutes = prefs.getInt(_eveningTimeKey) ?? (22 * 60);
    return {
      'enabled': enabled,
      'hour': minutes ~/ 60,
      'minute': minutes % 60,
    };
  }
}

