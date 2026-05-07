# GitHub Claude Code Skills 搜索结果

> 搜索日期：2026-05-07  
> 关键词：`claude code skills`、`claude skills slash commands anthropic`

---

## 精选仓库列表

### 综合资源 / Awesome Lists

| 仓库 | Stars | 描述 |
|------|-------|------|
| [hesreallyhim/awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | ⭐ 42,759 | 精选 Claude Code skills、hooks、slash-commands、agent orchestrators、插件大全 |
| [VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills) | ⭐ 20,494 | 1000+ agent skills 合集，兼容 Claude Code、Codex、Gemini CLI、Cursor 等 |
| [sujayjayjay/awesome-claude-code-skills](https://github.com/sujayjayjay/awesome-claude-code-skills) | ⭐ 1 | 按类别整理的 Claude Code skills、plugins、hooks、slash commands |

### 大型 Skills 库

| 仓库 | Stars | 描述 |
|------|-------|------|
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | ⭐ 174,696 | 性能优化系统，涵盖 Skills、instincts、memory、security，支持 Claude Code / Codex / Cursor |
| [sickn33/antigravity-awesome-skills](https://github.com/sickn33/antigravity-awesome-skills) | ⭐ 36,604 | 1,400+ agentic skills，含安装 CLI、bundles、workflows，兼容多种 AI 编程工具 |
| [ShadmanSakibRahman/claude-skills-hub](https://github.com/ShadmanSakibRahman/claude-skills-hub) | ⭐ 1 | 178+ 生产就绪的自定义 slash commands，覆盖 16 个分类 |

### 专项 Skills 工具

| 仓库 | Stars | 描述 |
|------|-------|------|
| [safishamsi/graphify](https://github.com/safishamsi/graphify) | ⭐ 43,922 | 将代码库、SQL schema、文档转为可查询知识图谱的 AI skill |
| [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | ⭐ 55,379 | 削减 65% tokens 的 Claude Code skill（穴居人语言风格） |
| [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) | ⭐ 20,517 | Manus 风格持久化 markdown 规划工作流 skill |
| [npow/claude-skills](https://github.com/npow/claude-skills) | ⭐ 3 | 可复用 slash-command 工作流，提升复杂多步骤任务可靠性 |

### 框架 & 工作区

| 仓库 | Stars | 描述 |
|------|-------|------|
| [pfangueiro/claude-code-agents](https://github.com/pfangueiro/claude-code-agents) | ⭐ 3 | 自愈 AI agent 框架，13 个 SDLC 代理、26 skills、13 slash commands、9 hooks |
| [Piyush8296/claude-workspace](https://github.com/Piyush8296/claude-workspace) | ⭐ 2 | 生产就绪工作区，13 skills、8 agents、11 slash commands & 10 hooks |
| [imserhatdemir/Claude-Skills](https://github.com/imserhatdemir/Claude-Skills) | ⭐ 4 | 47 个自定义 slash commands，涵盖代码审查、安全审计、架构设计、DevOps |
| [XeldarAlz/everything-claude-unity](https://github.com/XeldarAlz/everything-claude-unity) | ⭐ 7 | Unity 游戏开发专用，20 AI agents、22 slash commands、41 skills、9 hooks |

### 桌面 & 管理工具

| 仓库 | Stars | 描述 |
|------|-------|------|
| [farion1231/cc-switch](https://github.com/farion1231/cc-switch) | ⭐ 61,205 | 跨平台桌面 All-in-One 工具，支持 Claude Code / Codex / Gemini CLI 等 |
| [iOfficeAI/AionUi](https://github.com/iOfficeAI/AionUi) | ⭐ 23,898 | 免费本地开源 Cowork 应用，支持 20+ CLI 工具 |
| [Mduffy37/claudeworks](https://github.com/Mduffy37/claudeworks) | ⭐ 9 | Claude Code 配置管理 & 插件市场，支持 per-profile MCPs/skills/agents |
| [theihtisham/omni-skills-forge](https://github.com/theihtisham/omni-skills-forge) | ⭐ 13 | 通用 skill & slash-command 管理器，支持构建、分享、安装社区 skills |
| [santifer/career-ops](https://github.com/santifer/career-ops) | ⭐ 43,114 | 基于 Claude Code 的 AI 求职系统，14 种 skill 模式 |

---

## 分类汇总

### Skill 类型
- **Slash Commands** — 自定义 `/` 指令，在对话中触发特定工作流
- **Hooks** — 事件驱动的自动化脚本（SessionStart / Stop / ToolUse 等）
- **Agents** — 专职代理，处理特定 SDLC 任务
- **Instincts** — 内嵌行为规范，让模型默认遵循某些规则

### 常见 Skill 分类
- 代码审查 & 安全审计
- 架构设计 & 规划
- DevOps & CI/CD
- 知识图谱 & RAG
- Token 优化
- 游戏开发（Unity）
- 职业 & 求职自动化

---

## 如何安装 Skill

大多数 skill 以 Markdown 文件形式存储，放置于项目的 `.claude/commands/` 目录下：

```bash
# 示例：手动安装一个 skill
mkdir -p .claude/commands
curl -o .claude/commands/my-skill.md \
  https://raw.githubusercontent.com/<owner>/<repo>/main/<skill>.md
```

部分仓库提供 CLI 安装工具，例如 `antigravity-awesome-skills` 和 `omni-skills-forge`。

---

*数据来源：GitHub 公开搜索结果*
