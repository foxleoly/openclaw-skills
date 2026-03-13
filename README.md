# OpenClaw Skills

🦞 我的 OpenClaw Skills 集合 - 完全托管在 GitHub 上！

---

## 📦 可用 Skills

| Skill | 描述 | 状态 |
|-------|------|------|
| [pinchtab](./pinchtab/) | 浏览器自动化控制 | ✅ |
| [smart-search](./smart-search/) | 智能搜索（自动选择工具） | ✅ |
| [skill-creator](./skill-creator/) | Skill 创建工具 | ✅ |

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

## 📄 License

MIT License

---

*Last Updated: 2026-03-13*
