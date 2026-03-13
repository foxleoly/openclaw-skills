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

## 📚 正在使用的外部 Skills

这些 Skills 由其他开发者创建，我们也在项目中集成使用：

| Skill | 作者 | 描述 | 链接 |
|-------|------|------|------|
| **agent-reach** | OpenClaw Community | 全网搜索工具集成（Twitter/X, Reddit, YouTube 等） | [GitHub](https://github.com/openclaw/openclaw/tree/main/skills/agent-reach) |
| **resend** | OpenClaw Community | Resend 邮件平台集成（发送/接收/模板） | [GitHub](https://github.com/openclaw/openclaw/tree/main/skills/resend) |
| **weather** | OpenClaw Community | 天气查询（wttr.in / Open-Meteo） | [GitHub](https://github.com/openclaw/openclaw/tree/main/skills/weather) |
| **github** | OpenClaw Community | GitHub 操作（issues/PRs/CI） | [GitHub](https://github.com/openclaw/openclaw/tree/main/skills/github) |
| **apple-notes** | OpenClaw Community | Apple Notes 管理（memo CLI） | [GitHub](https://github.com/openclaw/openclaw/tree/main/skills/apple-notes) |
| **apple-reminders** | OpenClaw Community | Apple Reminders 管理（remindctl） | [GitHub](https://github.com/openclaw/openclaw/tree/main/skills/apple-reminders) |

> 💡 **说明：** 这些外部 Skills 通过 OpenClaw 官方渠道安装，不在本仓库中分发。

---

## 🔗 参考资料

- [Agent Skills Specification](https://agentskills.io)
- [Claude Skills 官方文档](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
- [OpenClaw 文档](https://docs.openclaw.ai/skills)
- [OpenClaw 官方 Skills](https://github.com/openclaw/openclaw/tree/main/skills)

---

## 📄 License

MIT License

---

*Last Updated: 2026-03-13*
