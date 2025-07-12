# 📚 OpenHands CLI Action - 使用例とデモ

このディレクトリには、OpenHands CLI Actionの様々な使用例とデモ環境が含まれています。

## 📁 ディレクトリ構成

### `oh-cli/` - OpenHands CLI開発環境

カスタムDockerfileを使ったOpenHands CLI実行環境です。

- **`Dockerfile`**: Python 3.12 + Node.js 20 + uvを組み合わせたカスタムOpenHands環境
- **`docker-compose.yml`**: 開発用のシンプルなコンテナ設定

#### 特徴
- ✨ **軽量**: Python 3.12-bookwormベース
- 🚀 **高速**: uvパッケージマネージャー使用
- 🔧 **開発向け**: ローカルファイルマウント対応

#### 使用方法
```bash
cd example/oh-cli/
docker-compose up -d --build
docker-compose exec oh-cli-dev openhands -t "Create a file called test.txt with content 'Hello World'"
```

### `oh-docker/` - 公式Docker環境

OpenHandsの公式Dockerイメージを使った環境です。

- **`docker-compose.yml`**: 公式イメージ (`docker.all-hands.dev/all-hands-ai/openhands:0.48`) 使用
- **環境変数**: `.env`ファイルから設定読み込み

#### 特徴
- 🏢 **公式**: OpenHands公式イメージ使用
- 🌐 **Webインターフェース**: ポート3003でアクセス可能
- 🔗 **Docker連携**: `/var/run/docker.sock`マウント対応

#### 使用方法
```bash
cd example/oh-docker/
# .envファイルを作成して必要な環境変数を設定
docker-compose up -d
# ブラウザでhttp://localhost:3003にアクセス
```

### `oh-cicd/` - CI/CD環境シミュレーション

ForgejoのActionsで実行される環境を再現したテスト用コンテナです。

- **`docker-compose.yml`**: Forgejo Actions実行環境を忠実に再現

#### 特徴
- 🎭 **環境再現**: Forgejo Actions環境の完全なシミュレーション
- 🔍 **テスト**: CICD環境でのエラー再現・デバッグ用
- ⚙️ **設定**: 実際のCI環境と同じ環境変数設定

#### 使用方法
```bash
cd example/oh-cicd/
docker-compose up -d --build
# CI/CD環境でのテスト実行
```

## 🚀 クイックスタート

### 1. 基本的な使用 (oh-cli)
```bash
cd example/oh-cli/
docker-compose up -d --build
docker-compose exec oh-cli-dev bash
```

### 2. Web UI使用 (oh-docker)
```bash
cd example/oh-docker/
# .envファイルを設定
docker-compose up -d
# http://localhost:3003にアクセス
```

### 3. CI/CD環境テスト (oh-cicd)
```bash
cd example/oh-cicd/
docker-compose up -d --build
# デバッグ・検証用
```

## ⚙️ 設定ファイル

各環境で使用される共通設定:

- **`.openhands/config.toml`**: OpenHands実行設定
- **`.openhands/settings.json`**: UI設定
- **`.env`**: 環境変数設定

## 📋 必要な環境変数

```bash
# 必須
ANTHROPIC_API_KEY=your-api-key-here

# 任意 (デフォルト値が設定されています)
LLM_MODEL=anthropic/claude-sonnet-4-20250514
MAX_ITERATIONS=30
RUNTIME=docker
```

## 🔧 トラブルシューティング

### Docker権限エラー
```bash
sudo usermod -aG docker $USER
# ログアウト・ログインが必要
```

### ポート競合
```bash
# ポート3003が使用中の場合
docker-compose down
lsof -ti:3003 | xargs kill -9
```

### API Key設定エラー
```bash
# .envファイルを確認
cat .env
# 正しいAPIキーが設定されているか確認
```

## 📚 参考資料

- [OpenHands公式ドキュメント](https://docs.all-hands.dev/)
- [メインREADME](../README.md)
- [Forgejo Actions](https://forgejo.org/docs/latest/user/actions/)

---

**💡 Tips**: 各環境は独立しているため、用途に応じて使い分けることができます。開発には`oh-cli`、デモには`oh-docker`、CI/CDテストには`oh-cicd`がおすすめです。