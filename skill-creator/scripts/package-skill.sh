#!/bin/bash
# Skill Packer - 打包 Skill 为 ZIP
# 用法：./package-skill.sh <skill-dir> [output-dir]

set -e

SKILL_DIR="$1"
OUTPUT_DIR="${2:-/tmp}"

if [ -z "$SKILL_DIR" ]; then
    echo "❌ 用法：$0 <skill-dir> [output-dir]"
    echo ""
    echo "示例:"
    echo "  $0 ~/.agents/skills/weather-query"
    echo "  $0 ~/.agents/skills/weather-query ~/Downloads"
    exit 1
fi

SKILL_NAME=$(basename "$SKILL_DIR")
ZIP_FILE="$OUTPUT_DIR/$SKILL_NAME.zip"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo "📦 打包 Skill: $SKILL_NAME"
echo ""

# 检查目录是否存在
if [ ! -d "$SKILL_DIR" ]; then
    echo "❌ 目录不存在：$SKILL_DIR"
    exit 1
fi

# 检查 SKILL.md 是否存在
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo "❌ 缺少 SKILL.md"
    exit 1
fi

# 确保输出目录存在
mkdir -p "$OUTPUT_DIR"

# 创建正确的 ZIP 结构
# 正确：my-skill.zip -> my-skill/SKILL.md
# 错误：my-skill.zip -> SKILL.md（直接在根目录）

echo "创建临时目录..."
TEMP_DIR=$(mktemp -d)

echo "复制 Skill 文件..."
cp -r "$SKILL_DIR" "$TEMP_DIR/"

echo "创建 ZIP 文件..."
cd "$TEMP_DIR"
zip -rq "$ZIP_FILE" "$SKILL_NAME"

# 验证 ZIP 结构
echo ""
echo "验证 ZIP 结构..."
ZIP_CONTENTS=$(unzip -l "$ZIP_FILE" | head -20)
echo "$ZIP_CONTENTS"

# 清理
rm -rf "$TEMP_DIR"

echo ""
echo "✅ 打包完成！"
echo ""
echo "📁 ZIP 文件：$ZIP_FILE"
echo "📊 文件大小：$(du -h "$ZIP_FILE" | cut -f1)"
echo ""
echo "💡 上传到 Claude:"
echo "   1. 打开 Claude"
echo "   2. 上传 $ZIP_FILE"
echo "   3. 测试 Skill"
echo ""
echo "🔗 或安装到 OpenClaw:"
echo "   cp $ZIP_FILE ~/.agents/skills/"
echo "   unzip -o $ZIP_FILE -d ~/.agents/skills/"
