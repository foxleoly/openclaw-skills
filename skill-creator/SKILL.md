# Skill Creator - 创建 Claude/OpenClaw Skills

## 📖 描述

**Skill Creator** 是一个元技能（meta-skill），用于自动创建新的 Claude/OpenClaw Skills。

**核心功能：**
- 📝 自动生成 SKILL.md 模板（带 YAML frontmatter）
- 📁 创建正确的目录结构
- 🔧 生成辅助脚本和示例
- ✅ 验证 Skill 结构是否符合规范

**遵循标准：**
- [Agent Skills Specification](https://agentskills.io)
- [Claude Skills 官方规范](https://support.claude.com/en/articles/12512198-how-to-create-custom-skills)
- [OpenClaw Skills 规范](https://docs.openclaw.ai/skills)

**适用场景：**
- ✅ 快速创建新 Skill
- ✅ 标准化 Skill 结构
- ✅ 批量生成 Skills
- ✅ 学习和理解 Skill 规范

---

## 🎯 触发短语

用户可能会说：
- "创建一个 skill"
- "帮我写个 skill"
- "生成 skill 模板"
- "创建 xxx skill"
- "skill creator"
- "帮我打包 skill"
- "验证 skill 结构"

---

## 🛠️ 用例

### 用例 1：创建简单 Skill

**用户：** "创建一个天气查询 skill"

**步骤：**
1. 创建目录 `~/.agents/skills/weather-query/`
2. 生成 SKILL.md（带 YAML frontmatter）
3. 添加基本指令和示例

---

### 用例 2：创建复杂 Skill

**用户：** "创建一个带脚本的 skill"

**步骤：**
1. 创建目录结构
2. 生成 SKILL.md
3. 创建 scripts/ 目录
4. 生成可执行脚本
5. 添加 examples.md

---

### 用例 3：验证 Skill 结构

**用户：** "检查我的 skill 结构对不对"

**步骤：**
1. 检查目录结构
2. 验证 SKILL.md 格式
3. 检查 YAML frontmatter
4. 验证引用文件存在

---

## 📋 输入/输出

### 输入
- **Skill 名称**: 人类友好的名称
- **Skill 描述**: 清晰的功能描述
- **触发短语**: 用户可能说的话
- **用例**: 2-3 个具体使用场景
- **依赖**: 需要的软件包（可选）

### 输出
- **目录结构**: `~/.agents/skills/<skill-name>/`
- **SKILL.md**: 核心技能文件
- **辅助文件**: scripts/, examples.md, references.md（可选）

---

## 📐 Skill 结构规范

### 最小结构

```
my-skill/
└── SKILL.md
```

### 完整结构

```
my-skill/
├── SKILL.md              # 必需，核心技能文件
├── examples.md           # 可选，使用示例
├── references.md         # 可选，参考资料
├── scripts/              # 可选，可执行脚本
│   ├── script1.sh
│   └── script2.py
└── assets/               # 可选，资源文件
    └── image.png
```

---

## 📝 SKILL.md 模板

### YAML Frontmatter（必需）

```yaml
---
name: Skill 名称
description: 清晰描述这个技能做什么，何时使用
version: 1.0.0
author: 作者名
created: 2026-03-13
updated: 2026-03-13
license: MIT
tags:
  - 标签 1
  - 标签 2
dependencies:
  - python>=3.8
  - requests
---
```

### Markdown Body（必需）

```markdown
# Skill 名称

## 📖 描述

详细描述技能的功能和使用场景。

## 🎯 触发短语

用户可能会说：
- "触发短语 1"
- "触发短语 2"

## 🛠️ 用例

### 用例 1：场景名称

**用户：** "用户可能说的话"

**步骤：**
1. 步骤 1
2. 步骤 2

## 📋 输入/输出

### 输入
- **参数 1**: 描述

### 输出
- **返回值**: 描述

## 🔧 脚本

### 脚本 1：脚本名称

```bash
#!/bin/bash
# 脚本内容
```

## 📚 参考资料

1. **参考标题**  
   https://example.com

---

*Last Updated: 2026-03-13*  
*Version: 1.0.0*  
*License: MIT*
```

---

## 🚀 GitHub 托管工作流

**我们的 Skills 都放在自己的 GitHub 仓库！**

### 优势
- ✅ 完全控制，不依赖第三方
- ✅ 版本管理（git tag/release）
- ✅ CI/CD 自动测试
- ✅ 团队共享（private/public repo）
- ✅ 一键安装（git clone / curl）

### 推荐仓库结构

```
your-username/skills/
├── README.md              # Skills 列表
├── pinchtab/              # PinchTab Skill
│   └── SKILL.md
├── smart-search/          # Smart Search Skill
│   └── SKILL.md
└── skill-creator/         # Skill Creator
    └── SKILL.md
```

### 安装方式

```bash
# 方式 1：git clone
git clone https://github.com/your-username/skills.git ~/.agents/skills-repo
ln -s ~/.agents/skills-repo/pinchtab ~/.agents/skills/pinchtab

# 方式 2：curl 下载单个 Skill
curl -fsSL https://raw.githubusercontent.com/your-username/skills/main/pinchtab/SKILL.md \
  -o ~/.agents/skills/pinchtab/SKILL.md

# 方式 3：安装脚本
curl -fsSL https://raw.githubusercontent.com/your-username/skills/main/install.sh | bash
```

---

## 🔧 脚本

### 脚本 1：创建 Skill

```bash
#!/bin/bash
# 用法：./create-skill.sh <skill-name> <description>

SKILL_NAME="$1"
DESCRIPTION="$2"
SKILL_DIR="$HOME/.agents/skills/$SKILL_NAME"

if [ -z "$SKILL_NAME" ]; then
    echo "❌ 用法：$0 <skill-name> <description>"
    exit 1
fi

echo "📁 创建 Skill 目录：$SKILL_DIR"
mkdir -p "$SKILL_DIR/scripts"
mkdir -p "$SKILL_DIR/assets"

echo "📝 生成 SKILL.md..."
cat > "$SKILL_DIR/SKILL.md" << EOF
---
name: $SKILL_NAME
description: $DESCRIPTION
version: 1.0.0
author: $(whoami)
created: $(date +%Y-%m-%d)
license: MIT
---

# $SKILL_NAME

## 📖 描述

$DESCRIPTION

## 🎯 触发短语

用户可能会说：
- "触发短语 1"
- "触发短语 2"

## 🛠️ 用例

### 用例 1：场景名称

**用户：** "用户可能说的话"

**步骤：**
1. 步骤 1
2. 步骤 2

## 📚 参考资料

1. **参考标题**  
   https://example.com

---

*Last Updated: $(date +%Y-%m-%d)*  
*Version: 1.0.0*  
*License: MIT*
EOF

echo ""
echo "✅ Skill 创建完成！"
echo ""
echo "📁 位置：$SKILL_DIR"
echo ""
echo "💡 下一步："
echo "   1. 编辑 $SKILL_DIR/SKILL.md 添加详细内容"
echo "   2. 添加脚本到 $SKILL_DIR/scripts/"
echo "   3. 测试 Skill"
EOF

chmod +x "$SKILL_DIR/SKILL.md"
```

### 脚本 2：验证 Skill

```bash
#!/bin/bash
# 用法：./validate-skill.sh <skill-dir>

SKILL_DIR="$1"

if [ -z "$SKILL_DIR" ]; then
    echo "❌ 用法：$0 <skill-dir>"
    exit 1
fi

echo "🔍 验证 Skill 结构：$SKILL_DIR"
echo ""

ERRORS=0

# 检查 SKILL.md 是否存在
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo "❌ 缺少 SKILL.md"
    ERRORS=$((ERRORS + 1))
else
    echo "✅ SKILL.md 存在"
    
    # 检查 YAML frontmatter
    if head -1 "$SKILL_DIR/SKILL.md" | grep -q "^---"; then
        echo "✅ YAML frontmatter 格式正确"
    else
        echo "❌ YAML frontmatter 格式错误（必须以 --- 开头）"
        ERRORS=$((ERRORS + 1))
    fi
    
    # 检查必需字段
    if grep -q "^name:" "$SKILL_DIR/SKILL.md"; then
        echo "✅ name 字段存在"
    else
        echo "❌ 缺少 name 字段"
        ERRORS=$((ERRORS + 1))
    fi
    
    if grep -q "^description:" "$SKILL_DIR/SKILL.md"; then
        echo "✅ description 字段存在"
    else
        echo "❌ 缺少 description 字段"
        ERRORS=$((ERRORS + 1))
    fi
fi

# 检查目录结构
if [ -d "$SKILL_DIR/scripts" ]; then
    echo "✅ scripts/ 目录存在"
fi

if [ -d "$SKILL_DIR/assets" ]; then
    echo "✅ assets/ 目录存在"
fi

echo ""
if [ $ERRORS -eq 0 ]; then
    echo "✅ 验证通过！Skill 结构正确"
    exit 0
else
    echo "❌ 发现 $ERRORS 个错误"
    exit 1
fi
```

### 脚本 3：打包 Skill

```bash
#!/bin/bash
# 用法：./package-skill.sh <skill-dir> [output-dir]

SKILL_DIR="$1"
OUTPUT_DIR="${2:-/tmp}"

if [ -z "$SKILL_DIR" ]; then
    echo "❌ 用法：$0 <skill-dir> [output-dir]"
    exit 1
fi

SKILL_NAME=$(basename "$SKILL_DIR")
ZIP_FILE="$OUTPUT_DIR/$SKILL_NAME.zip"

echo "📦 打包 Skill: $SKILL_NAME"
echo ""

# 检查目录结构
if [ ! -f "$SKILL_DIR/SKILL.md" ]; then
    echo "❌ 缺少 SKILL.md"
    exit 1
fi

# 创建正确的 ZIP 结构
# 正确：my-skill.zip -> my-skill/SKILL.md
# 错误：my-skill.zip -> SKILL.md

TEMP_DIR=$(mktemp -d)
cp -r "$SKILL_DIR" "$TEMP_DIR/"

cd "$TEMP_DIR"
zip -r "$ZIP_FILE" "$SKILL_NAME"

echo "✅ 打包完成！"
echo ""
echo "📁 ZIP 文件：$ZIP_FILE"
echo ""

# 清理
rm -rf "$TEMP_DIR"
```

---

## ⚙️ 配置

### 默认配置

```yaml
# ~/.agents/skills/skill-creator/config.yaml

default_author: $(whoami)
default_license: MIT
skills_directory: ~/.agents/skills
validate_on_create: true
create_scripts_dir: true
create_assets_dir: true
```

---

## 🐛 常见问题

### Q1: SKILL.md 的 YAML frontmatter 格式？

**A:** 必须以 `---` 开头和结尾：

```yaml
---
name: 技能名称
description: 描述
---

# Markdown 内容从这里开始
```

---

### Q2: 如何测试 Skill？

**A:** 
1. 创建完成后，重启 OpenClaw 或重新加载 skills
2. 用触发短语测试
3. 观察是否正确调用

---

### Q3: Skill 可以引用其他文件吗？

**A:** 可以，在 SKILL.md 中引用：

```markdown
## 📚 参考资料

详见 [examples.md](./examples.md)
```

---

## 📚 参考资料

1. **Claude 官方 Skill 文档**  
   https://support.claude.com/en/articles/12512198-how-to-create-custom-skills

2. **Agent Skills Specification**  
   https://agentskills.io

3. **OpenClaw Skills 文档**  
   https://docs.openclaw.ai/skills

4. **Awesome Claude Skills**  
   https://github.com/ComposioHQ/awesome-claude-skills

5. **Claude Skills 2.0 教程**  
   https://www.youtube.com/watch?v=rihf3-mpNG4

---

## 🔗 相关技能

- **pinchtab** - 浏览器自动化
- **smart-search** - 智能搜索
- **weather** - 天气查询
- **github** - GitHub 操作

---

*Last Updated: 2026-03-13*  
*Version: 1.0.0*  
*License: MIT*
