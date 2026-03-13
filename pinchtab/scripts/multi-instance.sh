#!/bin/bash
# PinchTab 多实例管理
# 用法：./multi-instance.sh [start|stop|list] [profile_name]

set -e

PINCHTAB_URL="${PINCHTAB_URL:-http://localhost:9867}"

show_help() {
    echo "📖 用法：$0 [command] [options]"
    echo ""
    echo "命令:"
    echo "   list              - 列出所有实例"
    echo "   start <profile>   - 启动新实例（指定配置文件）"
    echo "   stop <id>         - 停止指定实例"
    echo "   stopall           - 停止所有实例"
    echo ""
    echo "示例:"
    echo "   $0 list"
    echo "   $0 start alice"
    echo "   $0 start bob"
    echo "   $0 stop abc123"
    echo "   $0 stopall"
}

case "${1:-list}" in
    list)
        echo "📊 运行中的实例："
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        curl -s "$PINCHTAB_URL/instances" | jq '.'
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "📁 配置文件："
        curl -s "$PINCHTAB_URL/profiles" | jq '.'
        ;;
    
    start)
        if [ -z "$2" ]; then
            echo "❌ 请指定配置文件名称"
            echo "   用法：$0 start <profile_name>"
            exit 1
        fi
        PROFILE="$2"
        echo "🚀 启动新实例（配置文件：$PROFILE）..."
        RESULT=$(curl -s -X POST "$PINCHTAB_URL/instances/launch" \
            -H "Content-Type: application/json" \
            -d "{\"profileId\":\"$PROFILE\",\"mode\":\"headless\"}")
        echo "$RESULT" | jq '.'
        INSTANCE_ID=$(echo "$RESULT" | jq -r '.id')
        echo ""
        echo "✅ 实例已启动！"
        echo "   实例 ID: $INSTANCE_ID"
        echo ""
        echo "💡 下一步操作："
        echo "   # 打开网页"
        echo "   curl -X POST \"$PINCHTAB_URL/instances/$INSTANCE_ID/tabs/open\" \\"
        echo "     -H \"Content-Type: application/json\" \\"
        echo "     -d '{\"url\":\"https://example.com\"}'"
        ;;
    
    stop)
        if [ -z "$2" ]; then
            echo "❌ 请指定实例 ID"
            echo "   用法：$0 stop <instance_id>"
            exit 1
        fi
        INSTANCE_ID="$2"
        echo "🛑 停止实例：$INSTANCE_ID"
        curl -s -X DELETE "$PINCHTAB_URL/instances/$INSTANCE_ID" | jq '.'
        echo "✅ 实例已停止"
        ;;
    
    stopall)
        echo "🛑 停止所有实例..."
        INSTANCES=$(curl -s "$PINCHTAB_URL/instances" | jq -r '.instances[].id')
        if [ -z "$INSTANCES" ]; then
            echo "ℹ️  没有运行中的实例"
            exit 0
        fi
        for ID in $INSTANCES; do
            echo "  停止：$ID"
            curl -s -X DELETE "$PINCHTAB_URL/instances/$ID" > /dev/null
        done
        echo "✅ 所有实例已停止"
        ;;
    
    *)
        show_help
        exit 1
        ;;
esac
