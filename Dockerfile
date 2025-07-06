FROM python:3.12-bookworm

# 必要なパッケージをインストール
RUN apt-get update && \
    apt-get install -y curl git jq ca-certificates && \
    # Node.js 20
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    # uv (Pythonパッケージマネージャ)
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    # PATH設定
    echo 'export PATH="/root/.local/bin:$PATH"' >> /etc/profile.d/openhands_path.sh && \
    chmod +x /etc/profile.d/openhands_path.sh && \
    # バージョン確認
    python --version && \
    node --version && \
    npm --version && \
    /root/.local/bin/uv --version

# OpenHands用の初期セットアップ
RUN git config --global user.name "OpenHands Agent" && \
    git config --global user.email "openhands-agent@users.noreply.github.com" && \
    mkdir -p /root/.config/openhands && \
    mkdir -p /root/.openhands && \
    :

ENV PATH="/root/.local/bin:${PATH}"
ENV DEBUG=true

RUN uv pip install --system openhands-ai

# デフォルトコマンド
CMD ["bash"]
