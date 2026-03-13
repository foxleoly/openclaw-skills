#!/bin/bash
# PinchTab 安装脚本
# 用法：curl -fsSL https://raw.githubusercontent.com/.../install.sh | bash

set -e

echo "🦞 PinchTab 安装脚本"
echo "===================="
echo ""

# 检测操作系统
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "📊 系统信息："
echo "   操作系统：$OS"
echo "   架构：$ARCH"
echo ""

# 选择安装方法
echo "选择安装方法："
echo "1. 官方脚本（推荐）"
echo "2. npm"
echo "3. Docker"
echo "4. 源码编译"
echo ""
read -p "请选择 [1-4]: " choice

case $choice in
    1)
        echo ""
        echo "📦 使用官方脚本安装..."
        curl -fsSL https://pinchtab.com/install.sh | bash
        ;;
    
    2)
        echo ""
        echo "📦 使用 npm 安装..."
        if ! command -v npm &> /dev/null; then
            echo "❌ npm 未安装，请先安装 Node.js"
            exit 1
        fi
        npm install -g pinchtab
        ;;
    
    3)
        echo ""
        echo "📦 使用 Docker 安装..."
        if ! command -v docker &> /dev/null; then
            echo "❌ Docker 未安装"
            exit 1
        fi
        docker run -d \
            --name pinchtab \
            -p 127.0.0.1:9867:9867 \
            -v pinchtab-data:/data \
            --shm-size=2g \
            pinchtab/pinchtab
        echo "✅ Docker 容器已启动"
        ;;
    
    4)
        echo ""
        echo "📦 源码编译安装..."
        if ! command -v go &> /dev/null; then
            echo "❌ Go 未安装，请先安装 Go 1.25+"
            exit 1
        fi
        
        TEMP_DIR=$(mktemp -d)
        cd "$TEMP_DIR"
        
        echo "克隆仓库..."
        git clone https://github.com/pinchtab/pinchtab.git
        cd pinchtab
        
        echo "验证环境..."
        ./doctor.sh
        
        echo "编译..."
        go build ./cmd/pinchtab
        
        echo "安装到 /usr/local/bin..."
        sudo mv pinchtab /usr/local/bin/
        
        echo "清理临时文件..."
        cd -
        rm -rf "$TEMP_DIR"
        ;;
    
    *)
        echo "❌ 无效选择"
        exit 1
        ;;
esac

echo ""
echo "✅ 安装完成！"
echo ""
echo "🚀 启动 PinchTab："
echo "   pinchtab"
echo ""
echo "📖 查看文档："
echo "   https://pinchtab.com/docs"
echo ""
echo "💡 测试安装："
echo "   pinchtab --version"
