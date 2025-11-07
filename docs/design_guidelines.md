# デザインガイドライン

## デザインコンセプト

**「シンプル、フォーカス、達成感」**

- **ミニマリズム**: 黒と白を基調としたモノクロデザイン
- **機能優先**: 装飾よりも可読性と使いやすさを重視
- **段階的な視覚化**: 目標の階層を色の濃淡で表現

---

## カラーパレット

### 基本色（モノクロ）

```yaml
# 背景色
background:
  primary: "#fafafa"      # メイン背景（明るいグレー）
  secondary: "#ffffff"    # カード背景（純白）
  elevated: "#f5f5f5"     # 浮いた要素（薄グレー）

# テキスト・前景色
foreground:
  primary: "#374151"      # メインテキスト（ダークグレー）
  secondary: "#6b7280"    # サブテキスト（ミディアムグレー）
  tertiary: "#9ca3af"     # 補助テキスト（ライトグレー）
  disabled: "#d1d5db"     # 無効状態（とても薄いグレー）

# ボーダー・区切り線
border:
  light: "#e5e7eb"        # 薄いボーダー
  medium: "#d1d5db"       # 標準ボーダー
  dark: "#9ca3af"         # 強調ボーダー
```

### アクセント色（最小限の使用）

```yaml
# 成功・進捗
success:
  primary: "#10b981"      # 緑（完了状態）
  light: "#d1fae5"        # 薄い緑（背景用）
  dark: "#059669"         # 濃い緑（ホバー）

# 警告・注意
warning:
  primary: "#f59e0b"      # オレンジ（警告）
  light: "#fef3c7"        # 薄いオレンジ（背景用）

# エラー・削除
error:
  primary: "#ef4444"      # 赤（エラー）
  light: "#fee2e2"        # 薄い赤（背景用）

# 情報・ニュートラル
info:
  primary: "#374151"      # ダークグレー（情報）
  light: "#f3f4f6"        # とても薄いグレー（背景用）
```

### 目標階層別の色使い

```yaml
# マンダラチャートの階層表現
goal_hierarchy:
  center:       # 大目標（最重要）
    background: "#ffffff"
    border: "#374151"
    text: "#374151"
    border_width: 3px
    
  middle:       # 中目標
    background: "#ffffff"
    border: "#6b7280"
    text: "#374151"
    border_width: 2px
    
  small:        # 小目標
    background: "#fafafa"
    border: "#d1d5db"
    text: "#6b7280"
    border_width: 1px
    
  empty:        # 未入力
    background: "#f9fafb"
    border: "#e5e7eb"
    text: "#9ca3af"
    border_style: dashed
```

---

## タイポグラフィ

### フォント

```yaml
font_family:
  primary: "system-ui, -apple-system, sans-serif"  # システムフォント
  monospace: "SF Mono, Monaco, Consolas, monospace"  # 数値表示用
```

### フォントサイズ

```yaml
font_size:
  # 見出し
  h1: 28px        # 画面タイトル
  h2: 24px        # セクションタイトル
  h3: 20px        # サブタイトル
  h4: 18px        # カード見出し
  
  # 本文
  body_large: 16px    # 重要なテキスト
  body: 14px          # 標準テキスト
  body_small: 12px    # 補助テキスト
  
  # その他
  caption: 11px       # キャプション
  label: 13px         # ラベル
```

### フォントウェイト

```yaml
font_weight:
  regular: 400      # 通常
  medium: 500       # 中間
  semibold: 600     # セミボールド
  bold: 700         # 太字
```

### 行間

```yaml
line_height:
  tight: 1.2        # タイトル用
  normal: 1.5       # 標準
  relaxed: 1.75     # 読みやすさ重視
```

---

## スペーシング

### 基本単位: 4px

```yaml
spacing:
  xs: 4px       # 0.5単位
  sm: 8px       # 1単位
  md: 16px      # 2単位
  lg: 24px      # 3単位
  xl: 32px      # 4単位
  xxl: 48px     # 6単位
```

### 用途別スペーシング

```yaml
padding:
  cell: 12px              # セル内の余白
  card: 16px              # カード内の余白
  section: 24px           # セクション間
  screen: 16px            # 画面端

margin:
  element: 8px            # 要素間（小）
  component: 16px         # コンポーネント間（中）
  section: 32px           # セクション間（大）

gap:
  grid: 8px               # グリッドの隙間
  list: 12px              # リスト項目間
```

---

## コンポーネント

### セル（MandalaCell）

#### 大目標セル
```yaml
center_cell:
  width: auto
  aspect_ratio: 1:1
  background: "#ffffff"
  border: 3px solid #374151
  border_radius: 8px
  padding: 16px
  shadow: "0 2px 8px rgba(0,0,0,0.08)"
  
  text:
    color: "#374151"
    size: 16px
    weight: 700
    align: center
    
  hover:
    border_color: "#1f2937"
    shadow: "0 4px 12px rgba(0,0,0,0.12)"
```

#### 中目標セル
```yaml
middle_cell:
  background: "#ffffff"
  border: 2px solid #6b7280
  border_radius: 6px
  padding: 12px
  shadow: "0 1px 4px rgba(0,0,0,0.06)"
  
  text:
    color: "#374151"
    size: 14px
    weight: 600
    
  filled:
    background: "#ffffff"
    border_color: "#374151"
    cursor: pointer
    
  empty:
    background: "#f9fafb"
    border_color: "#d1d5db"
    border_style: dashed
```

#### 小目標セル
```yaml
small_cell:
  background: "#fafafa"
  border: 1px solid #d1d5db
  border_radius: 4px
  padding: 8px
  
  text:
    color: "#6b7280"
    size: 12px
    weight: 400
    
  filled:
    background: "#ffffff"
    text_color: "#374151"
    
  hover:
    border_color: "#9ca3af"
```

### カード

```yaml
card:
  background: "#ffffff"
  border: 1px solid #e5e7eb
  border_radius: 8px
  padding: 16px
  shadow: "0 1px 3px rgba(0,0,0,0.06)"
  
  header:
    font_size: 18px
    font_weight: 600
    color: "#374151"
    margin_bottom: 12px
```

### ボタン

```yaml
button:
  primary:
    background: "#374151"
    color: "#ffffff"
    padding: 12px 24px
    border_radius: 6px
    font_weight: 600
    
    hover:
      background: "#1f2937"
      
  secondary:
    background: "transparent"
    color: "#374151"
    border: 1px solid #d1d5db
    
    hover:
      background: "#f9fafb"
      border_color: "#9ca3af"
      
  text:
    background: "transparent"
    color: "#6b7280"
    padding: 8px 16px
    
    hover:
      background: "#f3f4f6"
      color: "#374151"
```

### アイコンボタン

```yaml
icon_button:
  size: 40px
  color: "#6b7280"
  background: "transparent"
  border_radius: 8px
  
  hover:
    background: "#f3f4f6"
    color: "#374151"
```

### プログレスバー

```yaml
progress_bar:
  height: 4px
  background: "#e5e7eb"
  
  fill:
    background: "#374151"
    
  animated: true
  transition: 300ms ease
```

### ダイアログ

```yaml
dialog:
  background: "#ffffff"
  border_radius: 12px
  padding: 24px
  max_width: 400px
  shadow: "0 20px 25px -5px rgba(0,0,0,0.1), 0 10px 10px -5px rgba(0,0,0,0.04)"
  
  title:
    font_size: 20px
    font_weight: 600
    color: "#374151"
    margin_bottom: 16px
    
  content:
    color: "#6b7280"
    line_height: 1.5
```

### インプットフィールド

```yaml
input:
  background: "#ffffff"
  border: 1px solid #d1d5db
  border_radius: 6px
  padding: 10px 12px
  font_size: 14px
  color: "#374151"
  
  focus:
    border_color: "#374151"
    border_width: 2px
    outline: none
    
  placeholder:
    color: "#9ca3af"
```

---

## レイアウト

### グリッドシステム

```yaml
grid:
  columns: 3          # 3×3グリッド
  gap: 8px           # セル間の隙間
  padding: 16px      # グリッド周囲の余白
  
  responsive:
    mobile: 
      gap: 6px
      padding: 12px
    tablet:
      gap: 8px
      padding: 16px
```

### 画面レイアウト

```yaml
screen:
  max_width: 600px      # 最大幅（中央配置）
  padding: 16px         # 画面端の余白
  background: "#fafafa"
  
  app_bar:
    height: 56px
    background: "#ffffff"
    border_bottom: 1px solid #e5e7eb
    elevation: 0        # 影なし（フラットデザイン）
```

---

## アニメーション

### トランジション

```yaml
transition:
  fast: 150ms         # 即座の反応
  normal: 300ms       # 標準
  slow: 500ms         # ゆっくり
  
  easing:
    default: "ease"
    in: "ease-in"
    out: "ease-out"
    in_out: "ease-in-out"
```

### 使用箇所

```yaml
animations:
  hover:
    duration: 150ms
    property: [background, border-color, transform]
    
  page_transition:
    duration: 300ms
    type: fade
    
  dialog:
    duration: 200ms
    type: scale + fade
    
  progress_bar:
    duration: 300ms
    type: width
```

---

## アイコン

### スタイル
- **Material Icons** を使用
- モノトーン（塗りつぶし）スタイル
- サイズ: 20px, 24px, 28px

### 使用例

```yaml
icons:
  # ナビゲーション
  back: arrow_back
  close: close
  menu: menu
  
  # アクション
  add: add
  edit: edit
  delete: delete
  refresh: refresh
  
  # 状態
  check: check_circle
  warning: warning
  error: error
  info: info
  
  # 目標
  flag: flag
  star: star
  target: track_changes
```

---

## 状態表示

### 入力状態

```yaml
states:
  empty:              # 未入力
    background: "#f9fafb"
    border: dashed 1px #d1d5db
    text: "#9ca3af"
    icon: "+"
    
  filled:             # 入力済み
    background: "#ffffff"
    border: solid 2px #374151
    text: "#374151"
    
  focused:            # フォーカス中
    background: "#ffffff"
    border: solid 2px #1f2937
    shadow: "0 0 0 3px rgba(55,65,81,0.1)"
    
  disabled:           # 無効
    background: "#f3f4f6"
    text: "#d1d5db"
    cursor: not-allowed
```

### 進捗状態

```yaml
progress:
  not_started:        # 未着手
    indicator: circle outline
    color: "#d1d5db"
    
  in_progress:        # 進行中
    indicator: circle half
    color: "#6b7280"
    
  completed:          # 完了
    indicator: check_circle
    color: "#10b981"
```

---

## アクセシビリティ

### コントラスト比

```yaml
contrast_ratio:
  text_on_white: 
    primary: 8.6:1      # #374151 on #ffffff (AAA)
    secondary: 4.8:1    # #6b7280 on #ffffff (AA)
    
  text_on_light_gray:
    primary: 8.2:1      # #374151 on #fafafa (AAA)
```

### タッチターゲット

```yaml
touch_target:
  minimum: 44px × 44px    # iOS/Androidガイドライン準拠
  recommended: 48px × 48px
```

### フォーカス表示

```yaml
focus:
  outline: 2px solid #374151
  offset: 2px
  border_radius: 4px
```

---

## ダークモード（将来対応）

```yaml
dark_mode:
  background:
    primary: "#111827"
    secondary: "#1f2937"
    
  foreground:
    primary: "#f9fafb"
    secondary: "#d1d5db"
    
  border:
    light: "#374151"
    medium: "#4b5563"
```

---

## 実装時の注意点

### DO ✅
- 黒と白を基調とする
- 必要最小限のアクセント色のみ使用
- 一貫したスペーシングシステムを守る
- 階層を視覚的に明確に（ボーダーの太さ、影）
- ホワイトスペースを効果的に使う

### DON'T ❌
- カラフルな色を多用しない
- 過度な装飾や影を使わない
- 不統一なスペーシング
- 小さすぎるタッチターゲット
- 読みにくいコントラスト比

---

## デザイントークン（Flutter実装用）

```dart
// lib/utils/design_tokens.dart

class DesignTokens {
  // Colors
  static const backgroundPrimary = Color(0xFFFAFAFA);
  static const backgroundSecondary = Color(0xFFFFFFFF);
  static const foregroundPrimary = Color(0xFF374151);
  static const foregroundSecondary = Color(0xFF6B7280);
  static const borderLight = Color(0xFFE5E7EB);
  static const borderMedium = Color(0xFFD1D5DB);
  
  // Spacing
  static const spaceXs = 4.0;
  static const spaceSm = 8.0;
  static const spaceMd = 16.0;
  static const spaceLg = 24.0;
  static const spaceXl = 32.0;
  
  // Typography
  static const fontSizeBody = 14.0;
  static const fontSizeBodyLarge = 16.0;
  static const fontSizeH4 = 18.0;
  
  // Border Radius
  static const radiusSm = 4.0;
  static const radiusMd = 6.0;
  static const radiusLg = 8.0;
}
```

---

このガイドラインに従って、統一感のあるモノクロベースのミニマルなデザインを実装します。


