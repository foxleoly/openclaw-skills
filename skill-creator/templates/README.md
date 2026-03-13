# Awesome Skills

我的 OpenClaw / Claude Skills 集合 - 完全托管在 GitHub 上！

---

## 📦 可用 Skills

| Skill | 描述 | 状态 |
|-------|------|------|
| [pinchtab](./pinchtab/) | 浏览器自动化控制 | ✅ 就绪 |
| [smart-search](./smart-search/) | 智能搜索（自动选择工具） | ✅ 就绪 |
| [skill-creator](./skill-creator/) | 创建新 Skills 的工具 | ✅ 就绪 |

---

## 🚀 快速安装

### 方式 1：一键安装（推荐）

```bash
# 安装所有 Skills
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/skills/main/install.sh | bash
```

### 方式 2：Git Clone

```bash
# 克隆仓库
git clone https://github.com/YOUR_USERNAME/skills.git ~/.agents/skills-repo

# 创建软链接
ln -s ~/.agents/skills-repo/pinchtab ~/.agents/skills/pinchtab
ln -s ~/.agents/skills-repo/smart-search ~/.agents/skills/smart-search
ln -s ~/.agents/skills-repo/skill-creator ~/.agents/skills/skill-creator
```

### 方式 3：手动下载

```bash
# 下载单个 Skill
mkdir -p ~/.agents/skills/pinchtab
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/skills/main/pinchtab/SKILL.md \
  -o ~/.agents/skills/pinchtab/SKILL.md
```

---

## 📖 使用指南

### 查看已安装的 Skills

```bash
ls -la ~/.agents/skills/
```

### 更新 Skills

```bash
# 如果使用 git clone
cd ~/.agents/skills-repo && git pull

# 如果使用一键安装
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/skills/main/install.sh | bash
```

---

## 🛠️ 创建新 Skill

使用 `skill-creator` 工具：

```bash
# 创建新 Skill
~/.agents/skills/skill-creator/scripts/create-skill.sh "skill-name" "描述"

# 验证结构
~/.agents/skills/skill-creator/scripts/validate-skill.sh ~/.agents/skills/skill-name

# 推送到 GitHub
~/.agents/skills/skill-creator/scripts/push-to-github.sh "skill-name" "https://github.com/YOUR_USERNAME/skills.git"
```

---

## 📐 Skill 结构

```
skill-name/
├── SKILL.md              # 必需，核心技能文件
├── examples.md           # 可选，使用示例
├── scripts/              # 可选，可执行脚本
│   ├── script1.sh
│   └── script2.py
└── assets/               # 可选，资源文件
```

### SKILL.md 格式

```yaml
---
name: 技能名称
description: 清晰描述
version: 1.0.0
author: 作者名
license: MIT
---

# Markdown 内容
```

---

## 🔧 开发工作流

```
1. 本地创建 Skill
   ↓
2. 用 skill-creator 生成模板
   ↓
3. 编写 SKILL.md 和脚本
   ↓
4. 用 validate-skill.sh 验证
   ↓
5. 推送到 GitHub
   ↓
6. CI/CD 自动测试和发布
```

---

## 📚 参考资料

- [Agent Skills Specification](https://agentskills.io)
- [Claude Skills 官方文档](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
- [OpenClaw 文档](https://docs.openclaw.ai/skills)

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

---

## 📄 License

MIT License

---

*Last Updated: 2026-03-13*
