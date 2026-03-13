#!/bin/bash
# Skill Validator - 验证 Skill 结构
# 用法：./validate-skill.sh <skill-dir>

set -e

SKILL_DIR="$1"

if [ -z "$SKILL_DIR" ]; then
    echo "❌ 用法：$0 <skill-dir>"
    echo ""
    echo "示例:"
    echo "  $0 ~/.agents/skills/weather-query"
    exit 1
fi

echo "🔍 验证 Skill 结构：$SKILL_DIR"
echo ""

ERRORS=0
WARNINGS=0

# 检查目录是否存在
if [ ! -d "$SKILL_DIR" ]; then
    echo "❌ 目录不存在：$SKILL_DIR"
    exit 1
fi

# 检查 SKILL.md 是否存在
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo "❌ 缺少 SKILL.md"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ SKILL.md 存在"
    
    # 检查 YAML frontmatter
    FIRST_LINE=$(head -1 "$SKILL_DIR/SKILL.md")
    if [ "$FIRST_LINE" = "---" ]; then
        echo "✅ YAML frontmatter 格式正确"
    else
        echo "❌ YAML frontmatter 格式错误（必须以 --- 开头）"
        ERRORS=$((ERRORS + 1))
    fi
    
    # 检查必需字段
    if grep -q "^name:" "$SKILL_DIR/SKILL.md"; then
        NAME=$(grep "^name:" "$SKILL_DIR/SKILL.md" | cut -d':' -f2- | xargs)
        echo "✅ name 字段存在：$NAME"
    else
        echo "❌ 缺少 name 字段"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q "^description:" "$SKILL_DIR/SKILL.md"; then
        echo "✅ description 字段存在"
    else
        echo "❌ 缺少 description 字段"
        ERRORS=$((ERRORS + 1))
    fi
    
    # 检查可选字段
    if grep -q "^version:" "$SKILL_DIR/SKILL.md"; then
        echo "✅ version 字段存在"
    else
        echo "⚠️  version 字段缺失（建议添加）"
        WARNINGS=$((WARNINGS + 1))
    fi
    
    if grep -q "^license:" "$SKILL_DIR/SKILL.md"; then
        echo "✅ license 字段存在"
    else
        echo "⚠️  license 字段缺失（建议添加）"
        WARNINGS=$((WARNINGS + 1))
    fi
fi

# 检查目录结构
if [ -d "$SKILL_DIR/scripts" ]; then
    SCRIPT_COUNT=$(find "$SKILL_DIR/scripts" -name "*.sh" -o -name "*.py" | wc -l | xargs)
    echo "✅ scripts/ 目录存在 ($SCRIPT_COUNT 个脚本)"
else
    echo "⚠️  scripts/ 目录缺失（可选）"
    WARNINGS=$((WARNINGS + 1))
fi

if [ -d "$SKILL_DIR/assets" ]; then
    ASSET_COUNT=$(find "$SKILL_DIR/assets" -type f | wc -l | xargs)
    echo "✅ assets/ 目录存在 ($ASSET_COUNT 个文件)"
else
    echo "⚠️  assets/ 目录缺失（可选）"
    WARNINGS=$((WARNINGS + 1))
fi

if [ -f "$SKILL_DIR/examples.md" ]; then
    echo "✅ examples.md 存在"
else
    echo "⚠️  examples.md 缺失（建议添加）"
    WARNINGS=$((WARNINGS + 1))
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "验证结果：$ERRORS 个错误，$WARNINGS 个警告"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $ERRORS -eq 0 ]; then
    if [ $WARNINGS -eq 0 ]; then
        echo "✅ 完美！Skill 结构正确"
    else
        echo "✅ 验证通过（有 $WARNINGS 个建议改进）"
    fi
    exit 0
else
    echo "❌ 发现 $ERRORS 个错误，请修复后重试"
    exit 1
fi
