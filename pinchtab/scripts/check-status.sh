#!/bin/bash
# PinchTab 服务状态检查
# 用法：./check-status.sh

set -e

PINCHTAB_URL="${PINCHTAB_URL:-http://localhost:9867}"

echo "🔍 检查 PinchTab 服务状态..."
echo ""

# 检查服务是否运行
if curl -s "$PINCHTAB_URL/health" > /dev/null 2>&1; then
    echo "✅ PinchTab 服务运行中"
    echo ""
    echo "📊 健康状态："
    curl -s "$PINCHTAB_URL/health" | jq '.'
    echo ""
    
    echo "📁 运行中的实例："
    curl -s "$PINCHTAB_URL/instances" | jq '.instances | length' | xargs -I {} echo "  - {} 个实例"
    echo ""
    
    echo "📋 配置文件："
    curl -s "$PINCHTAB_URL/profiles" | jq '.profiles | length' | xargs -I {} echo "  - {} 个配置文件"
    echo ""
else
    echo "❌ PinchTab 服务未运行"
    echo ""
    echo "💡 启动命令："
    echo "   pinchtab"
    echo ""
    echo "   或指定端口："
    echo "   pinchtab --port 9868"
    echo ""
    echo "   Docker 启动："
    echo "   docker run -d --name pinchtab -p 127.0.0.1:9867:9867 pinchtab/pinchtab"
    exit 1
fi
