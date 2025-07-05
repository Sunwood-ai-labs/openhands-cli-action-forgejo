#!/bin/bash

# シンプルOpenHandsテスト
echo "🚀 OpenHands実行テスト"

TASK="Create a file called test.txt with content 'Hello World'"

echo "タスク: $TASK"
echo "実行中..."

uv run python -m openhands.core.main \
  -t "$TASK"

# python -m openhands.core.main -t "Create a file called test.txt with content 'Hello World'"
# docker-compose exec oh-cli-dev openhands -t "Create a file called test.txt with content 'Hello World'"
# docker-compose exec oh-cli-dev openhands --help
# docker-compose exec oh-cli-dev python -m openhands.core.main -t "Create a file called test.txt with content 'Hello World'"
echo "完了！"