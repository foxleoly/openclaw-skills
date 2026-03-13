# Smart Search - 智能搜索

## 📖 描述

**智能搜索 Skill** - 根据查询类型自动选择最佳工具（web_search / web_fetch / PinchTab）。

**核心理念：**
> 合适的工具做合适的事 - 快速搜索用 API，复杂页面用浏览器

**核心优势：**
-  **智能判断** - 自动选择最佳工具
- ⚡ **速度优先** - 能用 API 就不开浏览器
- 🔐 **登录支持** - 需要登录时自动用 PinchTab
- 💰 **节省资源** - 避免不必要的浏览器启动

**适用场景：**
- ✅ 快速查询（天气、新闻、定义）
- ✅ 深度研究（多篇文档分析）
- ✅ 登录内容（Gmail、Notion、付费墙）
- ✅ 动态页面（JavaScript 渲染内容）

---

## 🎯 触发短语

用户可能会说：
- "查一下 xxx"
- "搜索 xxx"
- "帮我找 xxx 的资料"
- "上网查查 xxx"
- "看看 xxx 怎么说"
- "xxx 是什么"
- "今天的 xxx 新闻"
- "帮我抓取 xxx 的内容"

---

## 🧠 智能判断逻辑

### 决策树

```
用户查询
    │
    ▼
┌─────────────────┐
│ 我能直接回答吗？ │
│ (常识/历史知识)  │
└─────────────────┘
    │
    ├─ 是 → 直接回复 ✅
    │
    └─ 否
         │
         ▼
    ┌─────────────────┐
    │ 需要最新信息吗？ │
    │ (新闻/天气/股价) │
    └─────────────────┘
         │
         ├─ 是 → web_search (Brave API)
         │        │
         │        ▼
         │   需要详细内容吗？
         │        │
         │        ├─ 否 → 返回搜索结果 ✅
         │        │
         │        └─ 是
         │             │
         │             ▼
         │        ┌─────────────────┐
         │        │ 页面类型判断     │
         │        └─────────────────┘
         │             │
         │             ├─ 静态页面 → web_fetch ✅
         │             │
         │             ├─ 动态页面 → PinchTab ✅
         │             │
         │             └─ 需要登录 → PinchTab ✅
         │
         └─ 否 → 直接回复或追问
```

---

## 🛠️ 用例

### 用例 1：快速搜索

**用户：** "查一下今天的热搜"

**判断流程：**
1. ❌ 不是常识问题（需要最新信息）
2. ✅ 用 `web_search` 搜索
3. ✅ 返回搜索结果列表

**执行：**
```python
# 调用 web_search
results = web_search(query="今天的热搜", count=10)

# 返回格式化的搜索结果
🔍 今天的热搜（2026-03-13）

1. [标题 1] - 来源
   https://...

2. [标题 2] - 来源
   https://...
```

---

### 用例 2：静态页面抓取

**用户：** "帮我看看 Wikipedia 上 AI 的定义"

**判断流程：**
1. ❌ 不是常识问题（需要最新内容）
2. ✅ 用 `web_search` 找到 Wikipedia 链接
3. ✅ 判断：Wikipedia 是静态页面
4. ✅ 用 `web_fetch` 提取内容

**执行：**
```python
# 搜索找到链接
results = web_search(query="AI definition Wikipedia")
url = results[0]['url']

# 提取内容
content = web_fetch(url=url)

# 返回内容摘要
📄 Wikipedia: Artificial Intelligence

[内容摘要...]

📚 来源：https://...
```

---

### 用例 3：动态页面/登录内容

**用户：** "查一下我的 Gmail 有没有新邮件"

**判断流程：**
1. ❌ 需要登录（Gmail）
2. ✅ 用 `PinchTab` 打开
3. ✅ 保持登录态
4. ✅ 提取内容

**执行：**
```bash
# PinchTab 打开 Gmail
pinchtab nav https://mail.google.com
sleep 3

# 提取邮件列表
pinchtab text --selector=".email-item"
```

---

### 用例 4：付费墙内容

**用户：** "帮我看看这篇付费文章的内容"

**判断流程：**
1. ❌ 付费墙（需要特殊处理）
2. ✅ 用 `PinchTab`（可能有登录态/cookies）
3. ✅ 尝试绕过付费墙
4. ✅ 提取内容

**执行：**
```bash
# PinchTab 打开文章
pinchtab nav "$URL"
sleep 3

# 尝试提取（如果登录态有效）
pinchtab text --selector=".article-body"
```

---

### 用例 5：多篇文档分析

**用户：** "研究一下 AI 记忆系统的最新进展"

**判断流程：**
1. ❌ 需要深度研究
2. ✅ 用 `web_search` 找到相关论文/文章
3. ✅ 用 `web_fetch` 提取前 3-5 篇内容
4. ✅ 汇总分析

**执行：**
```python
# 搜索
results = web_search(query="AI memory system 2026", count=5)

# 提取每篇内容
contents = []
for r in results[:3]:
    content = web_fetch(url=r['url'])
    contents.append(content)

# 汇总分析
summary = analyze_and_summarize(contents)
```

---

## 📋 输入/输出

### 输入
- **查询内容**: 用户的搜索请求
- **深度级别**: quick | normal | deep（可选）
- **偏好工具**: auto | api | browser（可选）

### 输出
- **搜索结果**: 链接列表（web_search）
- **页面内容**: 提取的文本（web_fetch/PinchTab）
- **汇总分析**: 多篇文档的综合（deep 模式）
- **工具说明**: 告知用户使用了什么工具

---

## 🔧 工具选择规则

### 规则 1：优先 API

```
IF 查询类型 IN [新闻，天气，股价，体育比分，热搜]
THEN 使用 web_search
```

### 规则 2：静态页面

```
IF 域名 IN [wikipedia.org, medium.com, 博客，文档站]
AND 不需要登录
THEN 使用 web_fetch
```

### 规则 3：动态页面

```
IF 需要 JavaScript 渲染
OR 需要交互（点击/滑动）
OR 有反爬虫
THEN 使用 PinchTab
```

### 规则 4：登录内容

```
IF 需要登录 (Gmail, Notion, GitHub, 付费内容)
THEN 使用 PinchTab
```

### 规则 5：批量处理

```
IF 需要处理 > 5 个 URL
THEN 使用 web_fetch 并发（不用 PinchTab）
```

---

## 📜 脚本

### 脚本 1：智能搜索主脚本

```bash
#!/bin/bash
# Smart Search - 智能搜索主脚本
# 用法：./smart-search.sh "搜索关键词" [depth]

QUERY="$1"
DEPTH="${2:-normal}"  # quick | normal | deep

echo "🔍 智能搜索：$QUERY"
echo "📊 深度：$DEPTH"
echo ""

# 步骤 1：总是先用 web_search 找到相关链接
echo "📡 搜索中..."
RESULTS=$(web_search --query "$QUERY" --count 5)

echo "✅ 找到 $(echo $RESULTS | jq '.results | length') 个结果"
echo ""

# 步骤 2：根据深度决定是否提取内容
case $DEPTH in
    quick)
        # 只返回搜索结果
        echo "$RESULTS" | jq '.results[] | "\(.title)\n\(.url)\n"'
        ;;
    
    normal)
        # 提取第一个结果的内容
        FIRST_URL=$(echo "$RESULTS" | jq -r '.results[0].url')
        echo "📄 提取内容：$FIRST_URL"
        
        # 判断是否需要 PinchTab（简单判断：是否需要登录）
        if echo "$FIRST_URL" | grep -qE "(mail\.google|notion\.so|github\.com)"; then
            echo "🔐 检测到需要登录，使用 PinchTab..."
            pinchtab nav "$FIRST_URL"
            sleep 3
            pinchtab text
        else
            echo "📝 使用 web_fetch..."
            web_fetch --url "$FIRST_URL"
        fi
        ;;
    
    deep)
        # 提取前 3 个结果并汇总
        echo "📚 深度研究模式..."
        for i in 0 1 2; do
            URL=$(echo "$RESULTS" | jq -r ".results[$i].url")
            echo ""
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "📄 来源 $((i+1)): $URL"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            
            if echo "$URL" | grep -qE "(mail\.google|notion\.so)"; then
                pinchtab nav "$URL"
                sleep 3
                pinchtab text
            else
                web_fetch --url "$URL"
            fi
        done
        ;;
esac
```

### 脚本 2：工具选择器

```bash
#!/bin/bash
# 根据 URL 判断使用哪个工具
# 用法：./choose-tool.sh <URL>

URL="$1"

# 需要登录的网站
LOGIN_SITES="mail\.google|notion\.so|github\.com|twitter\.com|facebook\.com"

# 动态内容网站
DYNAMIC_SITES="twitter\.com|facebook\.com|instagram\.com|linkedin\.com"

# 静态内容网站
STATIC_SITES="wikipedia\.org|medium\.com|substack\.com|gitbook\.io"

if echo "$URL" | grep -qE "$LOGIN_SITES"; then
    echo "pinchtab"  # 需要登录
elif echo "$URL" | grep -qE "$DYNAMIC_SITES"; then
    echo "pinchtab"  # 动态内容
elif echo "$URL" | grep -qE "$STATIC_SITES"; then
    echo "web_fetch"  # 静态内容
else
    echo "auto"  # 让主脚本决定
fi
```

### 脚本 3：批量提取器

```bash
#!/bin/bash
# 批量提取多个 URL 的内容
# 用法：./batch-fetch.sh <urls.txt> [output_dir]

URLS_FILE="$1"
OUTPUT_DIR="${2:-/tmp/smart-search}"

mkdir -p "$OUTPUT_DIR"

echo "📚 批量提取模式"
echo "📁 输出目录：$OUTPUT_DIR"
echo ""

COUNTER=0
while IFS= read -r URL; do
    COUNTER=$((COUNTER + 1))
    
    # 跳过空行和注释
    [[ -z "$URL" || "$URL" =~ ^# ]] && continue
    
    echo "[$COUNTER] 处理：$URL"
    
    # 选择工具
    TOOL=$(./choose-tool.sh "$URL")
    
    if [ "$TOOL" = "pinchtab" ]; then
        echo "  🔐 使用 PinchTab..."
        pinchtab nav "$URL"
        sleep 2
        pinchtab text > "$OUTPUT_DIR/page-$COUNTER.txt"
    else
        echo "  📝 使用 web_fetch..."
        web_fetch --url "$URL" > "$OUTPUT_DIR/page-$COUNTER.txt"
    fi
    
    echo "  ✅ 完成"
    echo ""
done < "$URLS_FILE"

echo "🎉 批量提取完成！"
echo "📁 共处理 $COUNTER 个页面"
echo "📂 输出位置：$OUTPUT_DIR"
```

---

## ⚙️ 配置

### 配置文件示例

```yaml
# ~/.agents/skills/smart-search/config.yaml

# 默认搜索深度
default_depth: normal

# 工具优先级
tool_priority:
  - web_search    # 第一优先（最快）
  - web_fetch     # 第二优先（静态页面）
  - pinchtab      # 最后手段（动态/登录）

# 需要登录的网站列表
login_required_sites:
  - mail.google.com
  - notion.so
  - github.com
  - twitter.com

# 动态内容网站列表
dynamic_sites:
  - twitter.com
  - facebook.com
  - instagram.com

# 静态内容网站列表（优先用 web_fetch）
static_sites:
  - wikipedia.org
  - medium.com
  - substack.com
  - gitbook.io

# PinchTab 配置
pinchtab:
  url: http://localhost:9867
  timeout: 30
  headless: true
```

---

## 🐛 常见问题

### Q1: 什么时候用 web_search vs PinchTab？

**A:** 
- `web_search` = 搜索引擎 API（返回搜索结果列表）
- `PinchTab` = 浏览器自动化（打开具体页面操作）

**通常配合使用：**
```
web_search 找链接 → PinchTab 打开页面 → 提取内容
```

---

### Q2: PinchTab 启动太慢怎么办？

**A:** 
1. 保持 PinchTab 服务常驻运行
2. 简单页面优先用 `web_fetch`
3. 批量处理时用并发

```bash
# 后台运行 PinchTab
pinchtab &

# 或者用 Docker
docker run -d --name pinchtab -p 9867:9867 pinchtab/pinchtab
```

---

### Q3: 如何判断页面是否需要登录？

**A:** 
```bash
# 简单判断：检查 URL
if echo "$URL" | grep -qE "(mail\.google|notion\.so|github\.com)"; then
    echo "需要登录"
fi

# 进阶判断：用 PinchTab 检查页面状态
pinchtab nav "$URL"
CONTENT=$(pinchtab text)
if echo "$CONTENT" | grep -q "登录\|Login\|Sign in"; then
    echo "检测到登录提示"
fi
```

---

## 📚 参考资料

1. **PinchTab 文档**  
   https://pinchtab.com/docs

2. **web_search 工具**  
   https://docs.openclaw.ai/tools/web

3. **web_fetch 工具**  
   https://docs.openclaw.ai/tools/web-fetch

4. **Playwright 对比**  
   https://playwright.dev

---

## 🔗 相关技能

- **pinchtab** - 浏览器自动化
- **web-search** - 网络搜索
- **web-fetch** - 网页抓取
- **camofox** - 反检测浏览器

---

*Last Updated: 2026-03-13*  
*Version: 1.0.0*  
*License: MIT*
