<div align="center">

![Image](https://github.com/user-attachments/assets/7c6e3e6f-1622-427e-9d4e-eb344833e370)

# 🤖 OpenHands CLI Action for Forgejo

*セルフホストGit ForgejoでClaude APIを活用した自動コード修正・PR生成アクション*

![OpenHands](https://img.shields.io/badge/OpenHands-Agent-FF6B35?style=for-the-badge&logo=anthropic&logoColor=white)
![Forgejo](https://img.shields.io/badge/Forgejo-Self%20Hosted-4285F4?style=for-the-badge&logo=forgejo&logoColor=white)
![Actions](https://img.shields.io/badge/Actions-Automated-28A745?style=for-the-badge&logo=github-actions&logoColor=white)

---

[![Docker](https://img.shields.io/badge/Docker-Container-2496ED?style=flat-square&logo=docker&logoColor=white)](https://www.docker.com/)
[![Node.js](https://img.shields.io/badge/Node.js-20.x-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org/)
[![Python](https://img.shields.io/badge/Python-3.12-blue?style=flat-square&logo=python&logoColor=white)](https://www.python.org/)
[![Japanese](https://img.shields.io/badge/Language-日本語対応-FF6B6B?style=flat-square&logo=japan&logoColor=white)](https://github.com/)

</div>

---

## 🌟 概要

**OpenHands CLI Action for Forgejo**は、ForgejoのセルフホストGit環境でAnthropic Claude APIを活用し、IssueやPR、コメント、ラベル付与などのイベントをトリガーに自動でコード修正・PR作成を行うCIアクションです。  
GitHub Actions互換のワークフローで、AIによる自動化を安全かつ柔軟に導入できます。

---

## ✨ 主な特徴

- 🔗 **メンション/ラベルトリガー**: `@openhands-agent`メンションや`fix-me`ラベルでAI修正を自動実行
- 📝 **自動コード修正**: Issue/PR/コメント内容をもとにClaude APIで修正案を生成
- 🔄 **自動PR作成**: 変更があれば自動でドラフトPRを作成
- 👀 **リアクション通知**: 実行状況を絵文字リアクションで可視化
- 🌏 **日本語完全対応**: UI・メッセージ・プロンプト全て日本語
- ⚡ **高速セットアップ**: Docker+uv+Node.jsによる軽量・高速な実行環境

---

## 🚀 セットアップ

### 1. 必要要件

- **Forgejo**: Actions機能が有効なセルフホストGit
- **Docker**: コンテナ実行環境
- **Anthropic API Key**: Claude API用

### 2. シークレット設定

ForgejoリポジトリのSettings > Secretsで以下を設定：

```yaml
ANTHROPIC_API_KEY: "your-anthropic-api-key-here"
GITHUB_TOKEN: "actions用トークン"
```

### 3. ワークフロー配置

ワークフローファイルは下記に配置されています：

- [.forgejo/workflows/openhands-cli-action-forgejo.yaml](.forgejo/workflows/openhands-cli-action-forgejo.yaml)

```bash
mkdir -p .forgejo/workflows/
cp openhands-cli-action-forgejo.yaml .forgejo/workflows/
```

### 4. Dockerイメージビルド（任意）

```bash
docker build -t openhands-action .
```

---
### 5. docker-composeによる起動

```bash
docker-compose up -d --build
```

- サービス名は `docker-compose.yml` の `services:` で定義されています（デフォルト: `app`）。
- サービス名を変更した場合は、下記コマンド例のサービス名も合わせて修正してください。

### 6. コマンド例

下記のコマンドで、コンテナ内でOpenHands CLIを実行できます（サービス名は適宜変更してください）:

```bash
docker-compose exec oh-cli-dev openhands -t "Create a file called test.txt with content 'Hello World'"
```

- サービス名が `app` の場合は `docker-compose exec app ...` に読み替えてください。

---

## 📖 使い方

### Issue/PR/コメントでの利用

- **Issue/PR本文やコメントに `@openhands-agent` を含めて投稿**
- **`fix-me` または `fix-me-experimental` ラベルを付与**
- **Issueの担当者に`openhands-agent`を割り当て**

#### 例

```markdown
@openhands-agent このプロジェクトのテストカバレッジを改善してください
```

---

## 🔧 技術仕様

### ワークフロートリガー

- Issue: 作成・ラベル付与・担当割当
- PR: ラベル付与
- コメント: 作成
- PRレビュー/コメント: 作成・提出

### 実行フロー概要

1. イベント発生（メンション/ラベル/担当割当）
2. 目アイコン👀リアクション
3. リポジトリチェックアウト
4. Claude API（OpenHands）で自動修正
5. 変更があればドラフトPR作成
6. 結果コメント・リアクション

### 実行環境

- **OS**: Python 3.12 + Node.js 20 (Docker)
- **パッケージ管理**: uv (Python), npm (Node.js)
- **OpenHands設定**: `.config/openhands/config.toml`  
  ```toml
  [sandbox]
  trusted_dirs = [ "/workspace", "/prj", "/home", "/tmp" ]
  ```
- **除外ファイル**: `.SourceSageignore`  
  - Git/ビルド/キャッシュ/アセット/一時ファイル/仮想環境/CI関連を除外

### Dockerfile構成

- Python3.12, Node.js20, uv, git, curl, jq, ca-certificatesをインストール
- OpenHands用configをコピー
- デフォルトコマンド: bash

---

## 📚 使用例とデモ

詳細な使用例とデモ環境については、[example/README.md](example/README.md)を参照してください。

- **oh-cli/**: カスタムDockerfileによる開発環境
- **oh-docker/**: 公式Dockerイメージを使用した環境  
- **oh-cicd/**: Forgejo Actions環境シミュレーション

---

## 🛠️ カスタマイズ

- **モデル変更**: ワークフロー内`LLM_MODEL`変数でClaudeモデル指定可
- **タイムアウト**: ワークフロー内`timeout_minutes`で調整
- **信頼ディレクトリ**: `.config/openhands/config.toml`で変更可
- **除外ルール**: `.SourceSageignore`を編集

---

## 🔒 セキュリティ

- ✅ **最小権限**: 必要な権限のみ付与
- ✅ **シークレット管理**: API Keyは暗号化
- ✅ **実行制限**: タイムアウト設定
- ✅ **サンドボックス**: 信頼ディレクトリ外はアクセス不可

---

## 🐛 トラブルシューティング

1. **API Keyエラー**  
   → `ANTHROPIC_API_KEY`が正しく設定されているか確認

2. **権限エラー**  
   → Actionsに必要な権限が付与されているか確認

3. **タイムアウト**  
   → `timeout_minutes`を増やすか、プロンプトを簡潔に

---

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. フィーチャーブランチを作成 (`git checkout -b feature/your-feature`)
3. 変更をコミット (`git commit -m 'Add your feature'`)
4. ブランチにプッシュ (`git push origin feature/your-feature`)
5. プルリクエストを作成

---

## 📜 ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細は [LICENSE](LICENSE) を参照してください。

---

## 🙏 謝辞

- [Anthropic](https://www.anthropic.com/) - Claude AI Platform
- [Forgejo](https://forgejo.org/) - Self-hosted Git platform
- [OpenHands](https://github.com/all-hands-ai/openhands) - AI自動化エージェント

---

<div align="center">

**🚀 セルフホストGitでAI自動化をはじめよう！**

Made with ❤️ by the Open Source Community

</div>
