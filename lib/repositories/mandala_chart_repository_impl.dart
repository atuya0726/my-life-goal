import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/mandala_chart.dart';
import 'mandala_chart_repository.dart';

/// SharedPreferencesを使用したマンダラチャートのRepository実装
class MandalaChartRepositoryImpl implements MandalaChartRepository {
  static const String _key = 'mandala_chart';

  @override
  Future<void> save(MandalaChart chart) async {
    final prefs = await SharedPreferences.getInstance();
    final json = chart.toJson();
    final jsonString = jsonEncode(json);
    await prefs.setString(_key, jsonString);
  }

  @override
  Future<MandalaChart?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    
    if (jsonString == null) {
      return null;
    }
    
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return MandalaChart.fromJson(json);
    } catch (e) {
      // JSONのパースに失敗した場合はnullを返す
      return null;
    }
  }

  @override
  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  @override
  Future<bool> exists() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_key);
  }
}


