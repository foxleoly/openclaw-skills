#!/bin/bash
# PinchTab 提取页面内容（Token 高效）
# 用法：./extract-content.sh <URL>

set -e

if [ -z "$1" ]; then
    echo "❌ 用法：$0 <URL>"
    echo ""
    echo "示例："
    echo "   $0 https://example.com/article"
    exit 1
fi

URL="$1"
PINCHTAB_URL="${PINCHTAB_URL:-http://localhost:9867}"

echo "🌐 导航到：$URL"
pinchtab nav "$URL"

echo "⏳ 等待页面加载..."
sleep 2

echo ""
echo "📝 提取内容（Token 高效模式）："
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
pinchtab text
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo ""
echo "✅ 提取完成！"
echo ""
echo "💡 提示："
echo "   - 使用 'text' 命令比截图节省 5-13 倍 Token"
echo "   - 典型文章约 800 tokens（截图约 10,000 tokens）"
