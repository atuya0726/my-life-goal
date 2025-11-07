# アーキテクチャ設計書

## 概要
本アプリケーションは、MVVMパターンとRiverpodを採用したFlutterアプリケーションです。

## アーキテクチャパターン

### MVVM (Model-View-ViewModel)

```
┌─────────────────────────────────────────────────────────┐
│                         View Layer                       │
│  (Widgets - UI表示のみ、ビジネスロジックを持たない)        │
│                                                          │
│  - MandalChartScreen                                    │
│  - TaskManagementScreen                                 │
│  - Widgets (再利用可能なUIコンポーネント)                 │
└─────────────────────────────────────────────────────────┘
                            ↓↑
┌─────────────────────────────────────────────────────────┐
│                     ViewModel Layer                      │
│    (StateNotifier/Provider - 状態管理とロジック)         │
│                                                          │
│  - MandalChartNotifier                                  │
│  - TaskNotifier                                         │
│  - 各種Provider                                          │
└─────────────────────────────────────────────────────────┘
                            ↓↑
┌─────────────────────────────────────────────────────────┐
│                      Model Layer                         │
│          (データ構造とドメインロジック)                    │
│                                                          │
│  - MandalChart                                          │
│  - Goal                                                 │
│  - Task                                                 │
└─────────────────────────────────────────────────────────┘
                            ↓↑
┌─────────────────────────────────────────────────────────┐
│                   Repository Layer                       │
│              (データの永続化と取得)                        │
│                                                          │
│  - MandalChartRepository                                │
│  - TaskRepository                                       │
└─────────────────────────────────────────────────────────┘
```

## レイヤー構成

### 1. View Layer (プレゼンテーション層)
**責務**: UIの表示とユーザーインタラクションの処理

- **役割**
  - Widgetの構築
  - ユーザー入力の受付
  - ViewModelの状態を監視して表示を更新
  - ビジネスロジックは一切持たない

- **実装方針**
  - StatelessWidget を基本とする
  - ConsumerWidget で Provider を watch
  - UI関連の計算のみ許可（色、サイズなど）

### 2. ViewModel Layer (ビジネスロジック層)
**責務**: 状態管理とビジネスロジック

- **役割**
  - アプリケーションの状態を保持
  - ユーザーアクションに対するビジネスロジックの実行
  - Repositoryを介したデータの取得・保存
  - Viewに通知する状態の更新

- **実装方針**
  - StateNotifier を使用（Riverpod）
  - 状態はイミュータブルに保つ
  - 非同期処理は AsyncValue で管理

### 3. Model Layer (ドメイン層)
**責務**: ビジネスデータの定義とドメインロジック

- **役割**
  - データ構造の定義
  - ドメイン固有のビジネスルール
  - データのバリデーション
  - JSON変換ロジック

- **実装方針**
  - Immutableなクラス（freezedパッケージ使用）
  - ドメイン知識をカプセル化
  - 他レイヤーに依存しない

### 4. Repository Layer (データアクセス層)
**責務**: データの永続化と取得

- **役割**
  - ローカルストレージへのアクセス
  - データのシリアライズ/デシリアライズ
  - データソースの抽象化

- **実装方針**
  - インターフェースと実装を分離
  - データソースの詳細を隠蔽
  - エラーハンドリング

## 状態管理: Riverpod

### 採用理由
1. **コンパイル時の型安全性**: 実行時エラーを防ぐ
2. **テスタビリティ**: DI（依存性注入）が容易
3. **スコープ管理**: Providerの自動破棄
4. **パフォーマンス**: 必要な部分のみ再描画
5. **モダンなAPI**: Providerより直感的

### Providerの種類と用途

```dart
// 1. StateNotifierProvider - 複雑な状態管理
final mandalaChartProvider = StateNotifierProvider<MandalChartNotifier, MandalChartState>((ref) {
  return MandalChartNotifier(ref.watch(mandalaChartRepositoryProvider));
});

// 2. Provider - 読み取り専用の値やインスタンス
final mandalaChartRepositoryProvider = Provider<MandalChartRepository>((ref) {
  return MandalChartRepositoryImpl();
});

// 3. FutureProvider - 非同期データの取得
final initialDataProvider = FutureProvider<MandalChart?>((ref) async {
  return await ref.watch(mandalaChartRepositoryProvider).load();
});

// 4. StreamProvider - リアルタイムデータ（必要に応じて）
```

### 状態の更新フロー

```
User Action (View)
    ↓
ViewModel Method Call
    ↓
Business Logic Execution
    ↓
Repository Call (if needed)
    ↓
State Update (StateNotifier.state = newState)
    ↓
View Rebuild (ConsumerWidget.watch)
```

## ディレクトリ構造

```
lib/
├── main.dart                          # エントリーポイント
├── models/                            # Model Layer
│   ├── mandala_chart.dart            # マンダラチャートモデル
│   ├── mandala_chart.freezed.dart    # Generated
│   ├── mandala_chart.g.dart          # Generated
│   ├── goal.dart                     # 目標モデル（大/中/小目標）
│   ├── goal.freezed.dart             # Generated
│   ├── goal.g.dart                   # Generated
│   ├── task.dart                     # タスクモデル
│   ├── task.freezed.dart             # Generated
│   ├── task.g.dart                   # Generated
│   ├── focus_task.dart               # フォーカスタスクモデル
│   ├── focus_task.freezed.dart       # Generated
│   └── focus_task.g.dart             # Generated
├── view_models/                       # ViewModel Layer
│   ├── mandala_chart/
│   │   ├── mandala_chart_notifier.dart
│   │   ├── mandala_chart_state.dart
│   │   └── mandala_chart_state.freezed.dart  # Generated
│   ├── task/
│   │   ├── task_notifier.dart
│   │   ├── task_state.dart
│   │   └── task_state.freezed.dart   # Generated
│   └── focus_task/
│       ├── focus_task_notifier.dart
│       ├── focus_task_state.dart
│       └── focus_task_state.freezed.dart  # Generated
├── views/                             # View Layer
│   ├── screens/
│   │   ├── main_screen.dart          # 3タブナビゲーション
│   │   ├── mandala_chart_screen.dart # マンダラチャート画面
│   │   ├── task_list_screen.dart     # タスク一覧画面
│   │   └── focus_task_screen.dart    # フォーカスタスク画面
│   └── widgets/
│       ├── mandala_overview_widget.dart  # 全体3×3表示
│       ├── mandala_detail_widget.dart    # 詳細3×3表示
│       ├── mandala_cell_widget.dart      # セル
│       └── task_card_widget.dart         # タスクカード
├── repositories/                      # Repository Layer
│   ├── mandala_chart_repository.dart       # Interface
│   ├── mandala_chart_repository_impl.dart  # Implementation
│   ├── task_repository.dart                # Interface
│   ├── task_repository_impl.dart           # Implementation
│   ├── focus_task_repository.dart          # Interface
│   └── focus_task_repository_impl.dart     # Implementation
├── providers/                         # Riverpod Providers
│   └── providers.dart                # 全Providerの定義
└── utils/                            # ユーティリティ
    └── design_tokens.dart            # デザイントークン
```

## データフロー

### 読み込み時
```
View
  ↓ ref.watch(provider)
ViewModel (StateNotifier)
  ↓ Repository call
Repository
  ↓ Local Storage
Data Source (SharedPreferences/Hive)
```

### 書き込み時
```
View
  ↓ User Action
ViewModel (StateNotifier)
  ↓ Business Logic
  ↓ state = newState
  ↓ Repository.save()
Repository
  ↓ Serialize
Data Source (SharedPreferences/Hive)
```

## 設計原則

### DRY (Don't Repeat Yourself)
- 共通UIコンポーネントをwidgetsディレクトリで管理
- Repository パターンでデータアクセスロジックを一元化
- Extension で共通処理を拡張

### KISS (Keep It Simple, Stupid)
- 各クラスは単一の明確な目的を持つ
- 過度な抽象化を避ける
- 必要最小限の機能から実装

### YAGNI (You Aren't Gonna Need It)
- 将来必要になるかもしれない機能は実装しない
- 現在の要件に集中する
- リファクタリングで後から拡張

### SRP (Single Responsibility Principle)
- 各クラスは1つの責任のみを持つ
- Viewはレンダリングのみ
- ViewModelはビジネスロジックのみ
- Repositoryはデータアクセスのみ

## パッケージ構成

### 必須パッケージ
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # 状態管理
  flutter_riverpod: ^2.5.1
  
  # 不変オブジェクト
  freezed_annotation: ^2.4.1
  
  # JSON シリアライゼーション
  json_annotation: ^4.8.1
  
  # ローカルストレージ
  shared_preferences: ^2.2.2
  
  # 日付フォーマット
  intl: ^0.19.0
  
  # アイコン
  cupertino_icons: ^1.0.8
  
dev_dependencies:
  # コード生成
  build_runner: ^2.4.8
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  
  # Linter
  flutter_lints: ^5.0.0
```

## テスト戦略

### ユニットテスト
- Model: ビジネスロジックとバリデーション
- ViewModel: 状態遷移とビジネスロジック
- Repository: データ永続化ロジック

### ウィジェットテスト
- 各Widgetの表示確認
- ユーザーインタラクションのテスト

### 統合テスト
- 画面遷移のフロー
- エンドツーエンドのシナリオ

## まとめ

このアーキテクチャにより：
1. **保守性**: 各レイヤーが独立し、変更の影響範囲が限定的
2. **テスタビリティ**: DIによりモックを使ったテストが容易
3. **スケーラビリティ**: 機能追加時に既存コードへの影響が少ない
4. **可読性**: 責務が明確で、コードの意図が理解しやすい

