#!/bin/bash
# Skill to GitHub - 推送 Skill 到 GitHub 仓库
# 用法：./push-to-github.sh <skill-name> [repo-url]

set -e

SKILL_NAME="$1"
REPO_URL="${2:-}"
SKILL_DIR="$HOME/.agents/skills/$SKILL_NAME"
SKILLS_REPO="$HOME/.agents/skills-repo"

if [ -z "$SKILL_NAME" ]; then
    echo "❌ 用法：$0 <skill-name> [repo-url]"
    echo ""
    echo "示例:"
    echo "  $0 pinchtab"
    echo "  $0 pinchtab https://github.com/your-username/skills.git"
    exit 1
fi

echo "📦 推送 Skill 到 GitHub: $SKILL_NAME"
echo ""

# 检查 Skill 是否存在
if [ ! -d "$SKILL_DIR" ]; then
    echo "❌ Skill 不存在：$SKILL_DIR"
    exit 1
fi

# 检查 SKILL.md
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo "❌ 缺少 SKILL.md"
    exit 1
fi

# 克隆或更新 skills 仓库
if [ ! -d "$SKILLS_REPO" ]; then
    if [ -z "$REPO_URL" ]; then
        echo "❌ 首次使用需要指定 GitHub 仓库 URL"
        echo ""
        echo "用法：$0 $SKILL_NAME <repo-url>"
        echo "示例：$0 $SKILL_NAME https://github.com/your-username/skills.git"
        exit 1
    fi
    
    echo "📁 克隆 Skills 仓库..."
    git clone "$REPO_URL" "$SKILLS_REPO"
else
    echo "📁 更新 Skills 仓库..."
    cd "$SKILLS_REPO"
    git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || true
fi

# 复制 Skill 到仓库
echo "📝 复制 Skill 到仓库..."
mkdir -p "$SKILLS_REPO/$SKILL_NAME"
cp -r "$SKILL_DIR"/* "$SKILLS_REPO/$SKILL_NAME/"

# 提交并推送
cd "$SKILLS_REPO"

echo ""
echo "📊 Git 状态:"
git status

echo ""
read -p "是否提交并推送？[y/N] " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "❌ 已取消"
    exit 0
fi

git add "$SKILL_NAME/"
git commit -m "feat: add $SKILL_NAME skill" || echo "⚠️  没有变化"
git push origin main 2>/dev/null || git push origin master 2>/dev/null || true

echo ""
echo "✅ 推送完成！"
echo ""
echo "🔗 GitHub 链接:"
echo "   https://github.com/YOUR_USERNAME/skills/tree/main/$SKILL_NAME"
echo ""
echo "💡 安装命令:"
echo "   curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/skills/main/install.sh | bash"
