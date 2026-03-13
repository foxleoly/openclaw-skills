#!/bin/bash
# OpenClaw Skills 一键安装脚本
# 用法：curl -fsSL https://raw.githubusercontent.com/foxleoly/openclaw-skills/main/install.sh | bash

set -e

REPO_URL="https://github.com/foxleoly/openclaw-skills.git"
SKILLS_DIR="$HOME/.agents"
SKILLS_REPO="$SKILLS_DIR/skills-repo"

echo "🦞 OpenClaw Skills 安装脚本"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 克隆或更新仓库
if [ ! -d "$SKILLS_REPO" ]; then
    echo "📁 克隆仓库..."
    git clone "$REPO_URL" "$SKILLS_REPO"
else
    echo "📁 更新仓库..."
    cd "$SKILLS_REPO"
    git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || echo "⚠️  更新失败"
fi

# 创建软链接
echo ""
echo "🔧 创建软链接..."

for SKILL_DIR in "$SKILLS_REPO"/*/; do
    if [ -f "$SKILL_DIR/SKILL.md" ]; then
        NAME=$(basename "$SKILL_DIR")
        LINK_PATH="$SKILLS_DIR/skills/$NAME"
        
        # 如果已存在，跳过
        if [ -L "$LINK_PATH" ] || [ -d "$LINK_PATH" ]; then
            echo "  ⏭️  跳过：$NAME (已存在)"
            continue
        fi
        
        echo "  安装：$NAME"
        ln -s "$SKILL_DIR" "$LINK_PATH"
    fi
done

echo ""
echo "✅ 安装完成！"
echo ""
echo "📁 安装位置：$SKILLS_DIR/skills/"
echo ""
echo "📦 已安装的 Skills:"
ls -1 "$SKILLS_DIR/skills/" | sed "s/^/   - /"
echo ""
echo "💡 使用方法:"
echo "   重启 OpenClaw 或重新加载 skills"
echo ""
echo "🔗 GitHub 仓库:"
echo "   $REPO_URL"

