#!/bin/bash
# AI Co-Founder - 项目初始化脚本
# 用法：./init-project.sh <project-name>

set -e

PROJECT_NAME="$1"

if [ -z "$PROJECT_NAME" ]; then
    echo "❌ 用法：$0 <project-name>"
    echo ""
    echo "示例:"
    echo "  $0 water-tracker"
    echo "  $0 my-saas"
    exit 1
fi

echo "🚀 初始化项目：$PROJECT_NAME"
echo ""

# 创建项目结构
mkdir -p "$PROJECT_NAME"/{src,docs,tests,deploy,assets}

# 创建 README 模板
cat > "$PROJECT_NAME/README.md" << EOF
# $PROJECT_NAME

## 📖 产品描述

[描述产品做什么，解决什么问题]

## 🎯 目标用户

[谁会使用这个产品]

## ✨ 核心功能

### v1.0
- [ ] 功能 1
- [ ] 功能 2
- [ ] 功能 3

### v2.0 (计划)
- [ ] 功能 4
- [ ] 功能 5

## 🛠️ 技术栈

- **前端**: 
- **后端**: 
- **数据库**: 
- **部署**: 

## 📊 开发状态

- [ ] Phase 1: Discovery
- [ ] Phase 2: Planning
- [ ] Phase 3: Building
- [ ] Phase 4: Polish
- [ ] Phase 5: Deploy

## 📚 文档

- [产品文档](./docs/product.md)
- [技术文档](./docs/technical.md)
- [部署指南](./docs/deploy.md)

---

*Created with AI Co-Founder*
EOF

# 创建产品文档模板
cat > "$PROJECT_NAME/docs/product.md" << EOF
# 产品文档

## 产品愿景

[一句话描述产品愿景]

## 用户画像

### 主要用户
- 年龄：
- 职业：
- 痛点：

### 使用场景
1. 场景 1
2. 场景 2

## 功能清单

### Must Have (v1.0)
- [ ] 核心功能 1
- [ ] 核心功能 2

### Nice to Have (v2.0)
- [ ] 优化功能 1
- [ ] 优化功能 2

## 竞品分析

| 竞品 | 优势 | 劣势 | 我们的差异化 |
|------|------|------|-------------|
| 竞品 1 | | | |
| 竞品 2 | | | |
EOF

# 创建技术文档模板
cat > "$PROJECT_NAME/docs/technical.md" << EOF
# 技术文档

## 架构设计

[系统架构图]

## 技术选型

### 前端
- 框架：
- 理由：

### 后端
- 框架：
- 理由：

### 数据库
- 类型：
- 理由：

## API 设计

### 核心接口
- POST /api/xxx
- GET /api/xxx

## 数据模型

[数据库表结构]
EOF

# 创建部署文档模板
cat > "$PROJECT_NAME/docs/deploy.md" << EOF
# 部署指南

## 环境要求

- Node.js >= 18
- npm >= 9
- [其他依赖]

## 本地开发

\`\`\`bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev
\`\`\`

## 生产部署

### 方案 1: Vercel
\`\`\`bash
npm install -g vercel
vercel deploy
\`\`\`

### 方案 2: 自建服务器
\`\`\`bash
npm run build
pm2 start npm --name "$PROJECT_NAME" -- start
\`\`\`

## 维护指南

### 日志查看
\`\`\`bash
pm2 logs $PROJECT_NAME
\`\`\`

### 备份数据
\`\`\`bash
# 数据库备份命令
\`\`\`
EOF

echo ""
echo "✅ 项目结构创建完成！"
echo ""
echo "📁 目录结构:"
find "$PROJECT_NAME" -type f | sed 's/^/   /'
echo ""
echo "💡 下一步:"
echo "   1. 编辑 README.md 描述你的产品"
echo "   2. 填写 docs/product.md 产品需求"
echo "   3. 开始 Phase 1: Discovery"
echo ""
echo "🚀 开始构建你的产品吧！"
