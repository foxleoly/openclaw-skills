# 🔐 安全指南

**重要：不要上传任何敏感信息到 GitHub！**

---

## ❌ 禁止上传的内容

### API Keys
- OpenAI API Key (sk-...)
- Anthropic API Key (sk-ant-...)
- Resend API Key (re_...)
- Google API Key
- GitHub Token (ghp_..., gho_...)
- 任何其他 API Key

### 配置文件
- .env 文件
- config.json（包含敏感信息）
- credentials.json
- 任何包含密码的文件

### 个人信息
- 真实邮箱地址（用 user@example.com 代替）
- 真实密码（用 your_password_here 代替）
- 电话号码
- 地址

---

## ✅ 正确做法

### 1. 使用占位符

```bash
# 错误
OPENAI_API_KEY=sk-abc123def456...
PASSWORD=mysecretpassword

# 正确
OPENAI_API_KEY=your_api_key_here
PASSWORD=your_password_here
```

### 2. 使用 .env 文件（本地）

```bash
# 创建 .env 文件（已在 .gitignore 中）
cat > .env << EOF
OPENAI_API_KEY=your_key_here
RESEND_API_KEY=your_key_here
EOF

# 确保 .env 不会被提交
git check-ignore .env  # 应该输出 .env
```

### 3. 在文档中说明

配置步骤：
1. 复制配置文件 cp .env.example .env
2. 填写你的 API Key
3. 不要提交 .env 文件

---

## 🛡️ 本仓库的安全措施

### 1. .gitignore

已配置忽略以下文件：
- .env* - 所有环境变量文件
- *.key - 密钥文件
- config.json - 配置文件
- credentials/ - 凭证目录
- secrets/ - 秘密目录

### 2. 示例代码审查

所有示例代码使用：
- 占位符 URL（https://example.com）
- 占位符 Key（your_api_key_here）
- 占位符密码（your_password_here）

---

## 🔍 如果不小心上传了敏感信息

### 立即行动

1. 立即删除文件
   git rm --cached .env
   git commit -m "security: remove sensitive file"
   git push

2. 撤销 Key
   - 立即在对应平台撤销泄露的 API Key
   - 生成新的 Key

3. 清理 Git 历史（如果已推送）
   - 使用 BFG Repo-Cleaner
   - git reflog expire --expire=now --all
   - git gc --prune=now --aggressive
   - git push --force

4. 监控异常
   - 检查 API 使用记录
   - 监控异常流量

---

*Last Updated: 2026-03-13*
