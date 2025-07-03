<div align="center">

![Image](https://github.com/user-attachments/assets/dbb00f34-8c14-4a3d-be1e-1d7ad7a573c0)

# 🤖 Forgejo Claude Code Actions

*セルフホストGitでClaude Assistantを活用した自動コード生成・改善システム*

![Claude Code](https://img.shields.io/badge/Claude-Code%20Assistant-FF6B35?style=for-the-badge&logo=anthropic&logoColor=white)
![Forgejo](https://img.shields.io/badge/Forgejo-Self%20Hosted-4285F4?style=for-the-badge&logo=forgejo&logoColor=white)
![Actions](https://img.shields.io/badge/Actions-Automated-28A745?style=for-the-badge&logo=github-actions&logoColor=white)

---

[![Docker](https://img.shields.io/badge/Docker-Container-2496ED?style=flat-square&logo=docker&logoColor=white)](https://www.docker.com/)
[![Node.js](https://img.shields.io/badge/Node.js-20.x-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org/)
[![Bun](https://img.shields.io/badge/Bun-Runtime-000000?style=flat-square&logo=bun&logoColor=white)](https://bun.sh/)
[![TypeScript](https://img.shields.io/badge/TypeScript-Support-3178C6?style=flat-square&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Japanese](https://img.shields.io/badge/Language-日本語対応-FF6B6B?style=flat-square&logo=japan&logoColor=white)](https://github.com/)

</div>

## 🌟 概要

Forgejo Claude Code Actionsは、セルフホストGitプラットフォームのForgejoで**Anthropic Claude**を活用した自動コード生成・改善システムです。GitHubのClaude Code Base Actionを参考に、ForgejoのActions機能で動作するよう最適化されています。

### ✨ 主な機能

https://github.com/user-attachments/assets/95359f7d-6fa9-4b06-92e7-bda51fb9956b

- 🔗 **メンション機能**: `@claude` でClaudeを呼び出し
- 📝 **自動コード生成**: Issues、PR、コメントから自動的にコード生成
- 🔄 **自動プルリクエスト**: 変更があった場合に自動PR作成
- 👀 **リアルタイム反応**: 処理状況を絵文字リアクションで通知
- 🌏 **日本語完全対応**: UIとメッセージが日本語
- ⚡ **高速実行**: Bunランタイムによる高速処理

## 🚀 セットアップ

### 1. 環境要件

- **Forgejo**: Actions機能が有効化されていること
- **Docker**: コンテナ実行環境
- **Anthropic API Key**: Claude API アクセス用

### 2. シークレット設定

ForgejoのリポジトリSettings > Secretsで以下を設定：

```yaml
ANTHROPIC_API_KEY: "your-anthropic-api-key-here"
CLAUDE_BOT_TOKEN: "optional-custom-github-token"  # オプション
```

### 3. ワークフロー配置

ワークフローファイルは以下の場所に配置されています：


[.forgejo/workflows/claude-code-forgejo.yaml](.forgejo/workflows/claude-code-forgejo.yaml)

```bash
# .forgejo/workflows/ ディレクトリに配置
mkdir -p .forgejo/workflows/
cp claude-code-forgejo.yaml .forgejo/workflows/
```

## 📖 使用方法

### Issues での利用

新しいIssueを作成し、本文に `@claude` を含めて要求を記述：

```markdown
@claude このプロジェクトのテストカバレッジを改善してください
```

### Pull Request での利用

PR作成時、説明欄に `@claude` を含めてレビューや改善要求：

```markdown
@claude このPRのコード品質を向上させてください
```

### コメントでの利用

既存のIssueやPRのコメントで `@claude` をメンション：

```markdown
@claude バグを修正して、テストケースも追加してください
```

## 🔧 技術仕様

### サポートツール

Claudeが使用可能なツール一覧：

| ツール | 説明 |
|--------|------|
| `Bash(bun install)` | 依存関係のインストール |
| `Bash(bun test)` | テスト実行 |
| `Bash(bun run format)` | コードフォーマット |
| `Bash(bun typecheck)` | TypeScript型チェック |
| `Edit` | ファイル編集 |
| `Replace` | テキスト置換 |
| `View` | ファイル表示 |
| `GlobTool` | ファイル検索 |
| `GrepTool` | テキスト検索 |
| `Write` | ファイル作成 |

### ワークフロートリガー

```yaml
on:
  issue_comment:
    types: [created]      # コメント作成時
  issues:
    types: [opened]       # Issue作成時
  pull_request:
    types: [opened, synchronize]  # PR作成・更新時
```

### 実行環境

- **OS**: Ubuntu Latest (Docker)
- **Node.js**: v20.x
- **Package Manager**: Bun
- **Timezone**: Asia/Tokyo
- **Max Runtime**: 30分

## 📊 ワークフロー詳細

### 実行フロー

```mermaid
graph TD
    A[イベント発生] --> B{@claude含む?}
    B -->|Yes| C[👀 処理開始リアクション]
    B -->|No| D[スキップ]
    C --> E[環境セットアップ]
    E --> F[リポジトリチェックアウト]
    F --> G[プロンプト抽出]
    G --> H[Claude実行]
    H --> I{変更あり?}
    I -->|Yes| J[自動PR作成]
    I -->|No| K[結果コメント]
    J --> L[👍 成功リアクション]
    K --> L
    H -->|エラー| M[👎 失敗リアクション]
```

### 出力例

**成功時の自動PR:**
```markdown
🤖 Claude Assistant による自動更新

TypeScriptの型安全性を向上させ、テストカバレッジを95%に改善しました。

### 変更内容
- `src/types.ts` - 新しい型定義追加
- `tests/unit/` - テストケース追加
- `package.json` - 依存関係更新

---
このプルリクエストは Claude Assistant によって自動生成されました
```

## 🛠️ カスタマイズ

### モデル変更

```yaml
model: "claude-sonnet-4-20250514"  # 他のClaudeモデルに変更可能
```

### タイムアウト調整

```yaml
timeout_minutes: 30  # 実行時間制限（分）
```

### 許可ツール調整

```yaml
allowed_tools: "Bash(bun install),Edit,View"  # 必要なツールのみ許可
```

## 🔒 セキュリティ

- ✅ **最小権限**: 必要最小限の権限のみ付与
- ✅ **シークレット管理**: API Keyは暗号化保存
- ✅ **実行制限**: 30分タイムアウト
- ✅ **スコープ制限**: リポジトリ内のみアクセス

## 🐛 トラブルシューティング

### よくある問題

1. **API Key エラー**
   ```
   解決: ANTHROPIC_API_KEY が正しく設定されているか確認
   ```

2. **権限エラー**
   ```
   解決: Actionsに必要な権限が付与されているか確認
   ```

3. **タイムアウト**
   ```
   解決: timeout_minutesを増やすか、プロンプトを簡潔にする
   ```

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. フィーチャーブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'Add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📜 ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は [LICENSE](LICENSE) ファイルをご覧ください。

## 🙏 謝辞

- [Anthropic](https://www.anthropic.com/) - Claude AI Platform
- [Forgejo](https://forgejo.org/) - Self-hosted Git platform
- [GitHub Actions](https://github.com/features/actions) - Original inspiration

---

<div align="center">

**🚀 セルフホストGitでAIアシスタントを活用しよう！**

Made with ❤️ by the Open Source Community

</div>
