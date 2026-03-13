# Smart Search 使用示例

## 📖 快速示例

### 示例 1：简单搜索

```bash
# 查询今天的热搜
./smart-search.sh "今天的热搜" quick

# 输出：
🔍 智能搜索
📝 查询：今天的热搜
📊 深度：quick

📊 搜索结果：

1. [微博热搜榜] - weibo.com
   https://s.weibo.com/top/summary

2. [知乎热榜] - zhihu.com
   https://www.zhihu.com/hot

3. [百度热搜] - baidu.com
   https://top.baidu.com/

✅ 搜索完成！
```

---

### 示例 2：提取文章内容

```bash
# 查询并提取详细内容
./smart-search.sh "AI 记忆系统最新进展" normal

# 输出：
🔍 智能搜索
📝 查询：AI 记忆系统最新进展
📊 深度：normal

📡 正在搜索...

📖 普通模式 - 提取第一个结果
📄 目标 URL: https://example.com/ai-memory-article

📝 使用 web_fetch...

📄 页面内容摘要：
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
AI 记忆系统（AI Memory System）是 2026 年最热门的研究方向...

主要进展包括：
1. MemOS 发布了 v2.0 版本
2. 长期记忆检索准确率提升 43%
3. 多 agent 记忆共享成为可能
...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ 搜索完成！
```

---

### 示例 3：深度研究

```bash
# 深度研究模式
./smart-search.sh "AI memory system research 2026" deep

# 输出：
🔍 智能搜索
📝 查询：AI memory system research 2026
📊 深度：deep

📚 深度研究模式 - 提取前 3 个结果

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 来源 1: https://arxiv.org/abs/2507.03724
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 使用 web_fetch...

[论文摘要] MemOS: A Memory OS for AI System...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 来源 2: https://github.com/MemTensor/MemOS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 使用 web_fetch...

[GitHub 项目介绍] AI memory OS for LLM and Agent systems...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 来源 3: https://memos.openmem.net
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔐 使用 PinchTab...（需要登录）

[官网内容]...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 汇总分析
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

综合以上 3 个来源，AI 记忆系统的主要进展：

1. **架构创新**
   - MemOS 提出 Memory OS 概念
   - 统一的存储/检索/管理 API

2. **性能提升**
   - 检索准确率 +43.7%
   - Token 消耗 -35.2%

3. **应用场景**
   - 多 agent 协作
   - Skill 进化与复用
   - 个性化交互

✅ 搜索完成！
```

---

## 🔧 工具选择示例

### 示例 4：自动判断工具

```bash
# 判断某个 URL 应该用什么工具
./choose-tool.sh "https://mail.google.com"
# 输出：pinchtab（需要登录）

./choose-tool.sh "https://wikipedia.org/wiki/AI"
# 输出：web_fetch（静态内容）

./choose-tool.sh "https://twitter.com/elonmusk"
# 输出：pinchtab（动态内容）

./choose-tool.sh "https://example.com/blog"
# 输出：auto（未知类型）
```

---

## 🎯 实际使用场景

### 场景 1：查资料写报告

```bash
# 深度研究模式，收集多篇资料
./smart-search.sh "AI agent memory best practices" deep

# 然后基于提取的内容写报告
```

---

### 场景 2：监控竞品动态

```bash
# 创建一个监控脚本
cat > monitor-competitor.sh << 'EOF'
#!/bin/bash
URLS=(
  "https://competitor1.com/blog"
  "https://competitor2.com/news"
  "https://competitor3.com/updates"
)

for URL in "${URLS[@]}"; do
  echo "检查：$URL"
  ./choose-tool.sh "$URL" | xargs -I {} {} "$URL"
done
EOF

chmod +x monitor-competitor.sh
./monitor-competitor.sh
```

---

### 场景 3：日常新闻简报

```bash
# 每天早上自动搜索新闻
cat > daily-briefing.sh << 'EOF'
#!/bin/bash
DATE=$(date '+%Y-%m-%d')

echo "📰 每日新闻简报 - $DATE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

./smart-search.sh "AI news today" quick
echo ""
./smart-search.sh "tech news today" quick
echo ""
./smart-search.sh "startup funding news" quick
EOF

# 添加到 crontab
crontab -e
# 每天 8 点运行
0 8 * * * /path/to/daily-briefing.sh | mail -s "每日新闻简报" leo@example.com
```

---

## 📊 深度模式对比

| 模式 | 速度 | 内容量 | 适合场景 |
|------|------|--------|---------|
| **quick** | ⚡⚡ |  少 | 快速查链接 |
| **normal** | ⚡⚡ | 📄 中 | 单篇详细内容 |
| **deep** | ⚡ | 📚 多 | 研究报告/综合分析 |

---

## 💡 高级技巧

### 技巧 1：批量 URL 处理

```bash
# 创建 URL 列表
cat > urls.txt << EOF
https://example.com/article1
https://example.com/article2
https://example.com/article3
EOF

# 批量提取
./batch-fetch.sh urls.txt /tmp/output
```

---

### 技巧 2：结合 PinchTab 登录态

```bash
# 先用 PinchTab 登录
pinchtab nav "https://example.com/login"
pinchtab fill e2 "username"
pinchtab fill e3 "password"
pinchtab click e4

# 然后访问需要登录的页面
pinchtab nav "https://example.com/premium-content"
CONTENT=$(pinchtab text)

# 保存登录态
# PinchTab 会自动保存 cookies 到配置文件
```

---

### 技巧 3：缓存搜索结果

```bash
# 创建缓存目录
CACHE_DIR=~/.cache/smart-search
mkdir -p "$CACHE_DIR"

# 搜索前检查缓存
CACHE_KEY=$(echo "$QUERY" | md5sum | cut -d' ' -f1)
CACHE_FILE="$CACHE_DIR/$CACHE_KEY.json"

if [ -f "$CACHE_FILE" ]; then
    echo "📦 使用缓存结果..."
    cat "$CACHE_FILE"
else
    echo "📡 搜索中..."
    # 执行搜索并保存缓存
    RESULT=$(web_search --query "$QUERY")
    echo "$RESULT" > "$CACHE_FILE"
    echo "$RESULT"
fi
```

---

## 🐛 故障排除

### 问题 1：PinchTab 未响应

```bash
# 检查服务状态
./check-status.sh

# 重启服务
pinchtab stop
pinchtab start
```

---

### 问题 2：web_fetch 提取失败

```bash
# 可能是动态页面，改用 PinchTab
URL="https://example.com/dynamic-content"
TOOL=$(./choose-tool.sh "$URL")

if [ "$TOOL" = "auto" ]; then
    echo "尝试用 PinchTab..."
    pinchtab nav "$URL"
    sleep 3
    pinchtab text
fi
```

---

### 问题 3：搜索结果不准确

```bash
# 尝试更具体的查询词
./smart-search.sh "AI memory system research paper 2026" deep

# 或者指定来源
./smart-search.sh "site:arxiv.org AI memory" deep
```

---

## 📚 参考资料

1. **Smart Search Skill 文档**  
   SKILL.md

2. **PinchTab 文档**  
   https://pinchtab.com/docs

3. **web_search API**  
   https://docs.openclaw.ai/tools/web

4. **web_fetch 工具**  
   https://docs.openclaw.ai/tools/web-fetch
