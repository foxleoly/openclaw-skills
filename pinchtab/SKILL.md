# PinchTab - 浏览器自动化控制

## 📖 描述

**PinchTab** 是一个轻量级 HTTP 服务器，让 AI 代理能够直接控制 Chrome 浏览器。

**核心优势：**
- 🚀 **12MB 独立二进制** - 无需外部依赖
- 💰 **节省 Token** - 文本提取仅需 800 tokens/页（比截图省 5-13 倍）
- 🔒 **多实例隔离** - 支持多个并行 Chrome 进程，独立配置文件
- 🎯 **无障碍优先** - 稳定的元素引用（e1, e2...）代替脆弱的坐标
- 📦 **ARM64 优化** - 完美支持 Raspberry Pi

**适用场景：**
- ✅ 网页自动化操作（点击、填写、提交）
- ✅ 数据抓取（Token 高效提取）
- ✅ 多账号并行任务
- ✅ 需要登录态持久化的场景

---

## 🎯 触发短语

用户可能会说：
- "用浏览器打开 xxx"
- "帮我抓取 xxx 的数据"
- "自动填写表单并提交"
- "多开几个浏览器窗口"
- "控制 Chrome 做 xxx"
- "用 PinchTab 访问 xxx"
- "浏览器自动化"
- "网页操作"

---

## 🛠️ 用例

### 用例 1：基础网页操作

**用户：** "用浏览器打开 pinchtab.com 并点击第一个链接"

**步骤：**
1. 检查 PinchTab 服务是否运行
2. 导航到目标网址
3. 获取页面快照
4. 点击指定元素

---

### 用例 2：表单自动填写

**用户：** "帮我填写登录表单，用户名 test@example.com，密码 123456"

**步骤：**
1. 导航到登录页面
2. 获取可交互元素
3. 填写用户名字段
4. 填写密码字段
5. 提交表单

---

### 用例 3：高效数据提取

**用户：** "抓取这篇文章的主要内容"

**步骤：**
1. 导航到文章页面
2. 使用 `text` 命令提取（比截图省 token）
3. 返回结构化内容

---

### 用例 4：多实例并行

**用户：** "开两个浏览器窗口，分别登录 alice 和 bob 的账号"

**步骤：**
1. 创建第一个实例（profile: alice）
2. 创建第二个实例（profile: bob）
3. 分别导航到目标网站
4. 并行执行操作

---

## 📋 输入/输出

### 输入
- **操作类型**: navigate | click | fill | press | text | snapshot | instances
- **目标 URL**: 网页地址
- **元素引用**: e1, e2, e3...（从快照获取）
- **填充内容**: 表单字段值
- **配置文件 ID**: 用于多实例隔离

### 输出
- **操作结果**: 成功/失败状态
- **页面快照**: 可交互元素列表
- **提取文本**: 页面主要内容
- **实例列表**: 运行中的浏览器实例

---

## 🔧 命令参考

### 基础命令

```bash
# 启动服务
pinchtab

# 导航到网页
pinchtab nav https://example.com

# 获取页面快照（可交互元素）
pinchtab snap -i -c

# 点击元素
pinchtab click e5

# 填写输入框
pinchtab fill e3 "要输入的内容"

# 按下按键（如 Enter）
pinchtab press e7 Enter

# 提取文本（token 高效）
pinchtab text

# 截图
pinchtab screenshot
```

### HTTP API

```bash
# 启动实例
curl -s -X POST http://localhost:9867/instances/launch \
  -H "Content-Type: application/json" \
  -d '{"name":"work","mode":"headless"}'

# 打开标签页
curl -s -X POST http://localhost:9867/instances/$INST/tabs/open \
  -H "Content-Type: application/json" \
  -d '{"url":"https://example.com"}'

# 获取快照
curl "http://localhost:9867/tabs/$TAB/snapshot?filter=interactive"

# 执行操作
curl -X POST "http://localhost:9867/tabs/$TAB/action" \
  -H "Content-Type: application/json" \
  -d '{"kind":"click","ref":"e5"}'
```

---

## 📜 脚本

### 脚本 1：检查服务状态

```bash
#!/bin/bash
# 检查 PinchTab 是否运行
if curl -s http://localhost:9867/health > /dev/null 2>&1; then
    echo "✅ PinchTab 服务运行中"
    curl -s http://localhost:9867/health | jq '.'
else
    echo "❌ PinchTab 服务未运行"
    echo "启动命令：pinchtab"
fi
```

### 脚本 2：快速导航并截图

```bash
#!/bin/bash
# 用法：./quick-nav.sh https://example.com

URL="$1"
if [ -z "$URL" ]; then
    echo "用法：$0 <URL>"
    exit 1
fi

# 导航
echo " 导航到：$URL"
pinchtab nav "$URL"

# 等待加载
sleep 2

# 截图
echo "📸 截取屏幕..."
pinchtab screenshot -o /tmp/pinchtab-screenshot-$(date +%s).png

echo "✅ 完成"
```

### 脚本 3：提取页面内容

```bash
#!/bin/bash
# 用法：./extract-content.sh https://example.com/article

URL="$1"
if [ -z "$URL" ]; then
    echo "用法：$0 <URL>"
    exit 1
fi

# 导航
pinchtab nav "$URL"
sleep 2

# 提取文本（token 高效）
echo "📝 提取内容..."
pinchtab text
```

### 脚本 4：多实例管理

```bash
#!/bin/bash
# 列出所有运行中的实例

echo "📊 运行中的实例："
curl -s http://localhost:9867/instances | jq '.'

echo ""
echo "📁 配置文件："
curl -s http://localhost:9867/profiles | jq '.'
```

---

## ⚙️ 安装

### 方法 1：官方脚本（推荐）

```bash
curl -fsSL https://pinchtab.com/install.sh | bash
```

### 方法 2：npm

```bash
npm install -g pinchtab
```

### 方法 3：Docker

```bash
docker run -d \
  --name pinchtab \
  -p 127.0.0.1:9867:9867 \
  -v pinchtab-data:/data \
  --shm-size=2g \
  pinchtab/pinchtab
```

### 方法 4：源码编译

```bash
git clone https://github.com/pinchtab/pinchtab.git
cd pinchtab
./doctor.sh              # 验证环境
go build ./cmd/pinchtab  # 编译
```

---

## 🔒 安全配置

### 默认安全设置

PinchTab 默认采用本地优先策略：
- `server.bind = 127.0.0.1`（仅本地访问）
- 敏感端点默认关闭
- 外部 Chrome 附加默认关闭
- IDPI（间接提示注入防护）默认启用

### API Token 配置

```bash
# 生成 API Token
export PINCHTAB_API_TOKEN="your-secret-token"

# 启动时指定
pinchtab --api-token "$PINCHTAB_API_TOKEN"
```

### 域名白名单

```json
{
  "security": {
    "idpi": {
      "enabled": true,
      "allowed_domains": ["example.com", "trusted-site.org"]
    }
  }
}
```

---

## 🐛 常见问题

### Q1: 服务启动失败

**检查端口占用：**
```bash
lsof -i :9867
```

**解决方案：** 更换端口
```bash
pinchtab --port 9868
```

### Q2: Chrome 找不到

**检查 Chromium 路径：**
```bash
which chromium
which google-chrome
```

**手动指定：**
```bash
pinchtab --chrome-path /usr/bin/chromium
```

### Q3: 元素引用失效

**原因：** 页面刷新后元素引用会变化

**解决方案：** 重新获取快照
```bash
pinchtab snap -i -c
```

---

## 📚 参考资料

1. **官方文档**  
   https://pinchtab.com/docs

2. **GitHub 仓库**  
   https://github.com/pinchtab/pinchtab

3. **核心概念指南**  
   https://pinchtab.com/docs/core-concepts

4. **安全配置指南**  
   https://github.com/pinchtab/pinchtab/blob/main/docs/guides/security.md

5. **SMCP/MCP 插件**  
   https://github.com/pinchtab/pinchtab/blob/main/plugins/README.md

6. **开发指南**  
   https://github.com/pinchtab/pinchtab/blob/main/DEVELOPMENT.md

---

## 🔗 相关技能

- **browser** - OpenClaw 内置浏览器控制
- **camofox** - 反检测浏览器自动化
- **web-fetch** - 网页内容提取
- **web-search** - 网络搜索

---

*Last Updated: 2026-03-13*  
*Version: 1.0.0*  
*License: MIT*
