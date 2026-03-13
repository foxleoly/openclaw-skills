#!/bin/bash
# PinchTab 快速导航并截图
# 用法：./quick-nav.sh <URL> [输出目录]

set -e

if [ -z "$1" ]; then
    echo "❌ 用法：$0 <URL> [输出目录]"
    echo ""
    echo "示例："
    echo "   $0 https://example.com"
    echo "   $0 https://example.com /tmp/screenshots"
    exit 1
fi

URL="$1"
OUTPUT_DIR="${2:-/tmp}"
TIMESTAMP=$(date +%s)
SCREENSHOT_PATH="$OUTPUT_DIR/pinchtab-screenshot-$TIMESTAMP.png"

PINCHTAB_URL="${PINCHTAB_URL:-http://localhost:9867}"

echo "🌐 导航到：$URL"
pinchtab nav "$URL"

echo "⏳ 等待页面加载..."
sleep 2

echo "📸 截取屏幕..."
pinchtab screenshot -o "$SCREENSHOT_PATH"

echo ""
echo "✅ 完成！"
echo ""
echo "📁 截图保存至：$SCREENSHOT_PATH"
echo ""
echo "💡 查看截图："
echo "   open $SCREENSHOT_PATH  # macOS"
echo "   xdg-open $SCREENSHOT_PATH  # Linux"
