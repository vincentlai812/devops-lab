#!/usr/bin/env bash
# 用法：./scripts/deploy.sh <環境名稱> <版本> <套件檔>
set -euo pipefail
ENV_NAME="$1"
VERSION="$2"
PACKAGE="$3"
 
test -f "$PACKAGE" || { echo "找不到套件 $PACKAGE"; exit 1; }
echo "開始部署 $PACKAGE（版本 $VERSION）到 $ENV_NAME"

# === 模擬部署：課堂預設 ===
mkdir -p "deploy/$ENV_NAME"
unzip -oq "$PACKAGE" -d "deploy/$ENV_NAME"
echo "$VERSION" > "deploy/$ENV_NAME/DEPLOYED_VERSION"
 
# === 改用測試主機時，以下列方式取代上方區塊 ===
# scp "$PACKAGE" deploy@<HOST>:/tmp/app.zip
# ssh deploy@<HOST> "unzip -oq /tmp/app.zip -d /var/www/$ENV_NAME"
 
echo "部署完成"
