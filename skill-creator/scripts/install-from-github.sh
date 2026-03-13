#!/bin/bash
# Install Skills from GitHub
# 用法：curl -fsSL https://raw.githubusercontent.com/USER/skills/main/install.sh | bash
# 或者：./install-from-github.sh <repo-url> [skill-name]

set -e

REPO_URL="${1:-}"
SKILL_NAME="${2:-all}"
SKILLS_DIR="$HOME/.agents"
SKILLS_REPO="$SKILLS_DIR/skills-repo"

echo "🦞 OpenClaw Skills 安装脚本"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 如果没有指定仓库 URL，使用默认值
if [ -z "$REPO_URL" ]; then
    echo "⚠️  未指定 GitHub 仓库 URL"
    echo ""
    echo "用法 1: 指定仓库 URL"
    echo "  $0 https://github.com/your-username/skills.git"
    echo ""
    echo "用法 2: 从 Raw URL 安装单个 Skill"
    echo "  curl -fsSL https://raw.githubusercontent.com/user/repo/main/pinchtab/SKILL.md \\"
    echo "    -o ~/.agents/skills/pinchtab/SKILL.md"
    echo ""
    exit 1
fi

# 提取用户名和仓库名
REPO_NAME=$(basename "$REPO_URL" .git)
GITHUB_USER=$(echo "$REPO_URL" | sed -n 's|.*/\([^/]*\)/[^/]*|\1|p')

echo "📦 安装 Skills"
echo "   仓库：$REPO_NAME"
echo "   用户：$GITHUB_USER"
echo "   目标：$SKILL_NAME"
echo ""

# 创建目录
mkdir -p "$SKILLS_DIR/skills"

# 克隆仓库
if [ ! -d "$SKILLS_REPO" ]; then
    echo "📁 克隆仓库..."
    git clone "$REPO_URL" "$SKILLS_REPO"
else
    echo "📁 更新仓库..."
    cd "$SKILLS_REPO"
    git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || echo "⚠️  更新失败"
fi

# 安装 Skills
echo ""
echo "🔧 安装 Skills..."

if [ "$SKILL_NAME" = "all" ]; then
    # 安装所有 Skills
    for SKILL_DIR in "$SKILLS_REPO"/*/; do
        if [ -f "$SKILL_DIR/SKILL.md" ]; then
            NAME=$(basename "$SKILL_DIR")
            echo "  安装：$NAME"
            mkdir -p "$SKILLS_DIR/skills/$NAME"
            cp -r "$SKILL_DIR"* "$SKILLS_DIR/skills/$NAME/"
        fi
    done
else
    # 安装指定 Skill
    SOURCE_DIR="$SKILLS_REPO/$SKILL_NAME"
    if [ -d "$SOURCE_DIR" ] && [ -f "$SOURCE_DIR/SKILL.md" ]; then
        echo "  安装：$SKILL_NAME"
        mkdir -p "$SKILLS_DIR/skills/$SKILL_NAME"
        cp -r "$SOURCE_DIR"* "$SKILLS_DIR/skills/$SKILL_NAME/"
    else
        echo "❌ Skill 不存在：$SKILL_NAME"
        exit 1
    fi
fi

echo ""
echo "✅ 安装完成！"
echo ""
echo "📁 安装位置：$SKILLS_DIR/skills/"
echo ""
echo "📦 已安装的 Skills:"
ls -1 "$SKILLS_DIR/skills/" | sed 's/^/   - /'
echo ""
echo "💡 使用方法:"
echo "   重启 OpenClaw 或重新加载 skills"
echo ""
echo "🔗 GitHub 仓库:"
echo "   https://github.com/$GITHUB_USER/$REPO_NAME"
