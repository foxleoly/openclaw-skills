#!/bin/bash
# 工具选择器 - 根据 URL 判断使用哪个工具
# 用法：./choose-tool.sh <URL>

URL="$1"

if [ -z "$URL" ]; then
    echo "❌ 用法：$0 <URL>"
    exit 1
fi

# 需要登录的网站
LOGIN_SITES="mail\.google|notion\.so|github\.com|twitter\.com|facebook\.com|linkedin\.com|instagram\.com"

# 动态内容网站（JavaScript 渲染）
DYNAMIC_SITES="twitter\.com|facebook\.com|instagram\.com|linkedin\.com|tiktok\.com"

# 静态内容网站（优先用 web_fetch）
STATIC_SITES="wikipedia\.org|medium\.com|substack\.com|gitbook\.io|notion\.site"

# 判断逻辑
if echo "$URL" | grep -qE "$LOGIN_SITES"; then
    echo "pinchtab"
    echo "# 需要登录" >&2
elif echo "$URL" | grep -qE "$DYNAMIC_SITES"; then
    echo "pinchtab"
    echo "# 动态内容" >&2
elif echo "$URL" | grep -qE "$STATIC_SITES"; then
    echo "web_fetch"
    echo "# 静态内容" >&2
else
    echo "auto"
    echo "# 未知类型，让主脚本决定" >&2
fi
