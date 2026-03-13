# OpenClaw Skills

🦞 我的 OpenClaw Skills 集合 - 完全托管在 GitHub 上！

---

## 📦 可用 Skills

| Skill | 描述 | 状态 |
|-------|------|------|
| [pinchtab](./pinchtab/) | 浏览器自动化控制 | ✅ 就绪 |
| [smart-search](./smart-search/) | 智能搜索（自动选择工具） | ✅ 就绪 |
| [skill-creator](./skill-creator/) | 创建新 Skills 的工具 | ✅ 就绪 |
| [agent-reach](./agent-reach/) | 全网搜索工具集成 | ✅ 就绪 |
| [resend](./resend/) | Resend 邮件平台集成 | ✅ 就绪 |

---

## 🚀 快速安装

### 方式 1：一键安装（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/foxleoly/openclaw-skills/main/install.sh | bash
```

### 方式 2：Git Clone

```bash
# 克隆仓库
git clone https://github.com/foxleoly/openclaw-skills.git ~/.agents/skills-repo

# 创建软链接
ln -s ~/.agents/skills-repo/pinchtab ~/.agents/skills/pinchtab
ln -s ~/.agents/skills-repo/smart-search ~/.agents/skills/smart-search
ln -s ~/.agents/skills-repo/skill-creator ~/.agents/skills/skill-creator
ln -s ~/.agents/skills-repo/agent-reach ~/.agents/skills/agent-reach
ln -s ~/.agents/skills-repo/resend ~/.agents/skills/resend
```

### 方式 3：手动下载

```bash
# 下载单个 Skill
mkdir -p ~/.agents/skills/pinchtab
curl -fsSL https://raw.githubusercontent.com/foxleoly/openclaw-skills/main/pinchtab/SKILL.md \
  -o ~/.agents/skills/pinchtab/SKILL.md
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
~/.agents/skills/skill-creator/scripts/push-to-github.sh "skill-name" "https://github.com/foxleoly/openclaw-skills.git"
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

