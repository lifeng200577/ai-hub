#!/bin/bash
# AI Hub 每日自动同步脚本
# 把最新的记忆和配置文件脱敏后同步到 GitHub
# 敏感信息映射从外部文件读取，不会提交到仓库

REPO_DIR="/root/projects/c-nexus"
MEMORY_DIR="/root/.claude/projects/-root-projects-c-nexus/memory"
CC_CONNECT_DIR="/root/.cc-connect"
SECRETS_FILE="/root/.ai-hub-secrets"

cd "$REPO_DIR" || exit 1

# 加载敏感信息映射表
if [ -f "$SECRETS_FILE" ]; then
    source "$SECRETS_FILE"
else
    echo "$(date): 找不到 $SECRETS_FILE，跳过同步"
    exit 1
fi

# 脱敏函数：把真实值替换成占位符
sanitize() {
    local file="$1"
    for pair in "${SECRET_MAP[@]}"; do
        secret="${pair%%|*}"
        placeholder="${pair##*|}"
        sed -i "s|${secret}|${placeholder}|g" "$file"
    done
}

# 1. 同步记忆文件（无需脱敏）
cp "$MEMORY_DIR"/*.md "$REPO_DIR/claude/memory/" 2>/dev/null

# 2. 同步 cc-connect 配置并脱敏
cp "$CC_CONNECT_DIR/config.toml" "$REPO_DIR/cc-connect/config.toml" 2>/dev/null
sanitize "$REPO_DIR/cc-connect/config.toml"

cp "$CC_CONNECT_DIR/data/dir_history.json" "$REPO_DIR/cc-connect/data/" 2>/dev/null

# 会话文件脱敏
for f in "$CC_CONNECT_DIR/data/sessions/"*.json; do
    [ -f "$f" ] || continue
    base=$(basename "$f")
    cp "$f" "$REPO_DIR/cc-connect/data/sessions/$base"
    sanitize "$REPO_DIR/cc-connect/data/sessions/$base"
done

# 3. 提交并推送
git add -A
if git diff --cached --quiet; then
    echo "$(date): 没有变化，跳过推送"
    exit 0
fi

git commit -m "🤖 每日自动同步 - $(date '+%Y-%m-%d %H:%M')"
git push origin main 2>&1
echo "$(date): 同步完成"
