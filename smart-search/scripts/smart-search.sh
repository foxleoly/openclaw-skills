#!/bin/bash
# Smart Search - 智能搜索主脚本
# 用法：./smart-search.sh "搜索关键词" [depth]

set -e

QUERY="$1"
DEPTH="${2:-normal}"  # quick | normal | deep

if [ -z "$QUERY" ]; then
    echo "❌ 用法：$0 \"搜索关键词\" [深度]"
    echo ""
    echo "深度选项:"
    echo "  quick   - 只返回搜索结果（最快）"
    echo "  normal  - 提取第一个结果的内容（默认）"
    echo "  deep    - 提取前 3 个结果并汇总分析"
    echo ""
    echo "示例:"
    echo "  $0 \"AI 记忆系统\""
    echo "  $0 \"今天的热搜\" quick"
    echo "  $0 \"AI memory research\" deep"
    exit 1
fi

echo "🔍 智能搜索"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 查询：$QUERY"
echo "📊 深度：$DEPTH"
echo "⏰ 时间：$(date '+%Y-%m-%d %H:%M:%S')"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 步骤 1：总是先用 web_search 找到相关链接
echo "📡 正在搜索..."
echo ""

# 调用 web_search（假设有这个命令，实际用 OpenClaw 工具）
# 这里用示例输出，实际应该调用工具
echo "[模拟] web_search --query \"$QUERY\" --count 5"
echo ""

# 步骤 2：根据深度决定是否提取内容
case $DEPTH in
    quick)
        echo "⚡ 快速模式 - 只返回搜索结果"
        echo ""
        echo "📊 搜索结果："
        echo ""
        echo "1. [示例结果 1] - 来源网站"
        echo "   https://example.com/article1"
        echo ""
        echo "2. [示例结果 2] - 来源网站"
        echo "   https://example.com/article2"
        echo ""
        echo "💡 提示：用 'normal' 或 'deep' 模式提取详细内容"
        ;;
    
    normal)
        echo "📖 普通模式 - 提取第一个结果"
        echo ""
        
        FIRST_URL="https://example.com/article1"
        echo "📄 目标 URL: $FIRST_URL"
        echo ""
        
        # 判断是否需要 PinchTab
        if echo "$FIRST_URL" | grep -qE "(mail\.google|notion\.so|github\.com)"; then
            echo "🔐 检测到需要登录，使用 PinchTab..."
            echo ""
            
            if command -v pinchtab &> /dev/null; then
                pinchtab nav "$FIRST_URL"
                sleep 3
                echo ""
                echo "📝 页面内容："
                echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                pinchtab text
                echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            else
                echo "⚠️  PinchTab 未安装，跳过内容提取"
            fi
        else
            echo "📝 使用 web_fetch..."
            echo ""
            echo "[模拟] web_fetch --url \"$FIRST_URL\""
            echo ""
            echo "📄 页面内容摘要："
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "[示例内容] 这里是页面主要内容..."
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        fi
        ;;
    
    deep)
        echo "📚 深度研究模式 - 提取前 3 个结果"
        echo ""
        
        URLS=(
            "https://example.com/article1"
            "https://example.com/article2"
            "https://example.com/article3"
        )
        
        for i in "${!URLS[@]}"; do
            URL="${URLS[$i]}"
            NUM=$((i + 1))
            
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "📄 来源 $NUM: $URL"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            
            if echo "$URL" | grep -qE "(mail\.google|notion\.so)"; then
                echo "🔐 使用 PinchTab..."
                if command -v pinchtab &> /dev/null; then
                    pinchtab nav "$URL"
                    sleep 3
                    pinchtab text
                fi
            else
                echo "📝 使用 web_fetch..."
                echo "[模拟] web_fetch --url \"$URL\""
                echo ""
                echo "[页面内容摘要...]"
            fi
            
            echo ""
        done
        
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "📊 汇总分析"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "[综合以上 3 个来源，得出以下结论...]"
        echo ""
        echo "💡 提示：这是示例输出，实际会调用 AI 分析汇总"
        ;;
    
    *)
        echo "❌ 未知深度：$DEPTH"
        echo "   可选：quick | normal | deep"
        exit 1
        ;;
esac

echo ""
echo "✅ 搜索完成！"
