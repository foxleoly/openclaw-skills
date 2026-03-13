# PinchTab 使用示例

## 📖 基础示例

### 1. 启动服务

```bash
# 启动 PinchTab 服务器
pinchtab

# 指定端口
pinchtab --port 9868

# 指定 Chrome 路径
pinchtab --chrome-path /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome
```

---

### 2. 导航到网页

```bash
# 基础导航
pinchtab nav https://example.com

# 导航并等待加载
pinchtab nav https://example.com
sleep 3  # 等待 3 秒
```

---

### 3. 获取页面快照

```bash
# 获取可交互元素
pinchtab snap -i -c

# 获取完整快照
pinchtab snap

# 过滤特定元素
pinchtab snap --filter=interactive
```

**输出示例：**
```
- button "登录" [e1]
- input "用户名" [e2]
- input "密码" [e3]
- button "提交" [e4]
```

---

### 4. 点击元素

```bash
# 点击按钮
pinchtab click e1

# 点击链接
pinchtab click e5
```

---

### 5. 填写表单

```bash
# 填写输入框
pinchtab fill e2 "username123"

# 填写多个字段
pinchtab fill e2 "user@example.com"
pinchtab fill e3 "password123"

# 提交表单
pinchtab press e4 Enter
```

---

### 6. 提取文本

```bash
# 提取页面主要内容（Token 高效）
pinchtab text

# 提取特定区域
pinchtab text --selector=".article-content"
```

---

### 7. 截图

```bash
# 截取当前页面
pinchtab screenshot

# 保存到指定路径
pinchtab screenshot -o /tmp/screenshot.png

# 全屏截图
pinchtab screenshot --full-page
```

---

## 🔁 多实例示例

### 1. 创建多个实例

```bash
# 创建第一个实例（Alice）
curl -s -X POST http://localhost:9867/instances/launch \
  -H "Content-Type: application/json" \
  -d '{"profileId":"alice","mode":"headless"}'

# 创建第二个实例（Bob）
curl -s -X POST http://localhost:9867/instances/launch \
  -H "Content-Type: application/json" \
  -d '{"profileId":"bob","mode":"headless"}'
```

### 2. 列出所有实例

```bash
curl http://localhost:9867/instances | jq '.'
```

### 3. 在指定实例中打开网页

```bash
# 假设实例 ID 是 abc123
curl -s -X POST http://localhost:9867/instances/abc123/tabs/open \
  -H "Content-Type: application/json" \
  -d '{"url":"https://example.com"}'
```

### 4. 停止实例

```bash
# 停止指定实例
curl -s -X DELETE http://localhost:9867/instances/abc123

# 停止所有实例（使用脚本）
./scripts/multi-instance.sh stopall
```

---

## 🤖 AI Agent 自动化示例

### 示例 1：自动登录

```bash
#!/bin/bash
# 自动登录示例

URL="https://example.com/login"
USERNAME="user@example.com"
PASSWORD="secret123"

# 导航到登录页
pinchtab nav "$URL"
sleep 2

# 获取快照
SNAP=$(pinchtab snap -i -c)

# 找到用户名输入框（假设是 e2）
pinchtab fill e2 "$USERNAME"

# 找到密码输入框（假设是 e3）
pinchtab fill e3 "$PASSWORD"

# 找到提交按钮（假设是 e4）
pinchtab click e4

echo "✅ 登录完成"
```

---

### 示例 2：数据抓取

```bash
#!/bin/bash
# 抓取文章标题和内容

URL="https://example.com/article/123"

# 导航
pinchtab nav "$URL"
sleep 2

# 提取标题
TITLE=$(pinchtab text --selector="h1")

# 提取内容
CONTENT=$(pinchtab text --selector=".article-body")

# 输出结果
echo "标题：$TITLE"
echo ""
echo "内容："
echo "$CONTENT"
```

---

### 示例 3：批量操作

```bash
#!/bin/bash
# 批量打开多个网页并截图

URLS=(
  "https://example.com"
  "https://example.org"
  "https://example.net"
)

for URL in "${URLS[@]}"; do
  echo "🌐 处理：$URL"
  
  # 导航
  pinchtab nav "$URL"
  sleep 2
  
  # 截图
  FILENAME=$(echo "$URL" | sed 's/[^a-zA-Z0-9]/_/g')
  pinchtab screenshot -o "/tmp/$FILENAME.png"
  
  echo "✅ 完成：$URL"
  echo ""
done
```

---

## 📊 HTTP API 示例

### 1. 健康检查

```bash
curl http://localhost:9867/health
```

### 2. 启动实例

```bash
RESPONSE=$(curl -s -X POST http://localhost:9867/instances/launch \
  -H "Content-Type: application/json" \
  -d '{"name":"work","mode":"headless","profileId":"default"}')

INSTANCE_ID=$(echo "$RESPONSE" | jq -r '.id')
echo "实例 ID: $INSTANCE_ID"
```

### 3. 打开标签页

```bash
TAB_RESPONSE=$(curl -s -X POST http://localhost:9867/instances/$INSTANCE_ID/tabs/open \
  -H "Content-Type: application/json" \
  -d '{"url":"https://example.com"}')

TAB_ID=$(echo "$TAB_RESPONSE" | jq -r '.tabId')
echo "标签页 ID: $TAB_ID"
```

### 4. 获取快照

```bash
curl "http://localhost:9867/tabs/$TAB_ID/snapshot?filter=interactive"
```

### 5. 执行操作

```bash
# 点击
curl -X POST "http://localhost:9867/tabs/$TAB_ID/action" \
  -H "Content-Type: application/json" \
  -d '{"kind":"click","ref":"e5"}'

# 填写
curl -X POST "http://localhost:9867/tabs/$TAB_ID/action" \
  -H "Content-Type: application/json" \
  -d '{"kind":"fill","ref":"e3","text":"Hello World"}'

# 按键
curl -X POST "http://localhost:9867/tabs/$TAB_ID/action" \
  -H "Content-Type: application/json" \
  -d '{"kind":"press","ref":"e7","key":"Enter"}'
```

---

## 🔧 脚本工具示例

### 使用提供的脚本

```bash
# 检查服务状态
./scripts/check-status.sh

# 快速导航并截图
./scripts/quick-nav.sh https://example.com

# 提取页面内容
./scripts/extract-content.sh https://example.com/article

# 管理多实例
./scripts/multi-instance.sh list
./scripts/multi-instance.sh start alice
./scripts/multi-instance.sh stop abc123
./scripts/multi-instance.sh stopall
```

---

## 📚 参考资料

- **官方文档**: https://pinchtab.com/docs
- **GitHub**: https://github.com/pinchtab/pinchtab
- **核心概念**: https://pinchtab.com/docs/core-concepts
- **安全指南**: https://github.com/pinchtab/pinchtab/blob/main/docs/guides/security.md
