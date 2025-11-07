# My Life Goal

マンダラチャート式目標管理アプリ

## 概要

人生の大きな目標を達成可能な具体的アクションに分解し、日々の実践を通じて着実に前進するための目標管理ツール。

### 主な機能

- 📊 **マンダラチャート**: 9×9グリッドで目標を視覚化
- 📋 **タスク一覧**: 期間別（1日/1週間/1月/1年）のタスク管理
- 🎯 **フォーカスタスク**: スプリントプランニング形式で重要タスクを管理
  - 今日/今週/今月/今年の4つの期間に分けて計画
  - 各期間内で優先順位を調整
  - 期間間でタスクを移動可能
- 🔄 **階層的入力**: 大目標→中目標→小目標の段階的な目標設定
- 💾 **自動保存**: データの永続化（SharedPreferences）

## UI/UX の特徴

### ミニマル情報主義
必要最小限の情報とアイコンで直感的に理解できるUIを実現。

- シンプルな3タブ構成（マンダラ / タスク一覧 / フォーカス）
- ドラッグ&ドロップで優先順位と期間を調整
- チェックボックスで即座に完了マーク
- ジェスチャー操作（タップ・長押し）
- テキストとアイコンの最小限の使用
- スプリントプランニング的なタスク管理

## 技術スタック

- **Flutter**: 3.9.2+
- **Dart**: 3.9.2+
- **Riverpod**: 状態管理
- **Freezed**: 不変データクラス
- **SharedPreferences**: データ永続化

## アーキテクチャ

MVVM (Model-View-ViewModel) パターンを採用

```
View (Widget) ← ConsumerWidget
  ↓↑
ViewModel (StateNotifier) ← Riverpod
  ↓↑
Model (Freezed class)
  ↓↑
Repository (Interface + Implementation)
  ↓↑
Data Source (SharedPreferences)
```

## セットアップ

```bash
# 依存関係のインストール
flutter pub get

# コード生成
dart run build_runner build --delete-conflicting-outputs

# アプリの起動
flutter run
```

## ドキュメント

詳細なドキュメントは `docs/` ディレクトリを参照してください：

- [プロジェクト概要](docs/project_overview.md)
- [アーキテクチャ設計](docs/architecture.md)
- [デザインガイドライン](docs/design_guidelines.md)
- [UI/UXガイドライン](docs/ui_guidelines.md)

## 開発原則

- **DRY** (Don't Repeat Yourself)
- **KISS** (Keep It Simple, Stupid)
- **YAGNI** (You Aren't Gonna Need It)
- **SRP** (Single Responsibility Principle)

## ライセンス

Private project
