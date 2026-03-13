#!/bin/bash
# Skill Creator - 创建新 Skill
# 用法：./create-skill.sh <skill-name> <description>

set -e

SKILL_NAME="$1"
DESCRIPTION="$2"
SKILL_DIR="$HOME/.agents/skills/$SKILL_NAME"

if [ -z "$SKILL_NAME" ]; then
    echo "❌ 用法：$0 <skill-name> <description>"
    echo ""
    echo "示例:"
    echo "  $0 \"weather-query\" \"查询天气信息\""
    echo "  $0 \"github-helper\" \"GitHub 操作助手\""
    exit 1
fi

if [ -z "$DESCRIPTION" ]; then
    DESCRIPTION="自定义技能 - $SKILL_NAME"
fi

echo "📁 创建 Skill 目录：$SKILL_DIR"
mkdir -p "$SKILL_DIR/scripts"
mkdir -p "$SKILL_DIR/assets"

echo "📝 生成 SKILL.md..."

CURRENT_DATE=$(date +%Y-%m-%d)
CURRENT_USER=$(whoami)

cat > "$SKILL_DIR/SKILL.md" << EOF
# $SKILL_NAME

## 📖 描述

$DESCRIPTION

## 🎯 触发短语

用户可能会说：
- "触发短语 1"
- "触发短语 2"

## 🛠️ 用例

### 用例 1：场景名称

**用户：** "用户可能说的话"

**步骤：**
1. 步骤 1
2. 步骤 2

## 📋 输入/输出

### 输入
- **参数 1**: 描述

### 输出
- **返回值**: 描述

## 🔧 脚本

### 脚本 1：脚本名称

\`\`\`bash
#!/bin/bash
# 脚本内容
\`\`\`

## 📚 参考资料

1. **参考标题**  
   https://example.com

---

*Last Updated: $CURRENT_DATE*  
*Version: 1.0.0*  
*License: MIT*
EOF

echo ""
echo "✅ Skill 创建完成！"
echo ""
echo "📁 位置：$SKILL_DIR"
echo ""
echo "📂 目录结构:"
echo "   $SKILL_NAME/"
echo "   ├── SKILL.md"
echo "   ├── scripts/"
echo "   └── assets/"
echo ""
echo "💡 下一步："
echo "   1. 编辑 SKILL.md 添加详细内容"
echo "   2. 添加脚本到 scripts/"
echo "   3. 测试 Skill"
echo ""
echo "🔗 打开编辑："
echo "   code $SKILL_DIR/SKILL.md"
