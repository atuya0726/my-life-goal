import '../models/mandala_chart.dart';

/// マンダラチャートのデータアクセス層インターフェース
abstract class MandalaChartRepository {
  /// マンダラチャートを保存
  Future<void> save(MandalaChart chart);

  /// マンダラチャートを読み込み
  Future<MandalaChart?> load();

  /// マンダラチャートを削除
  Future<void> delete();

  /// マンダラチャートが存在するか確認
  Future<bool> exists();
}



