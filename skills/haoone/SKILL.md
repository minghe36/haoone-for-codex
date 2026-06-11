---
name: haoone
description: "Haoone 字幕工作流技能。调用 haoone-cli 处理音视频转录、批量转录、文稿匹配、格式化文稿、热词管理、项目管理、翻译与双语字幕。支持 SRT 文件读取与结构化文稿生成。触发词：转录、字幕、transcribe、subtitle、srt、haoone、文稿、热词。"
user-invokable: true
argument-hint: "[command] [args]"
license: MIT
metadata:
  author: haoone
  version: "1.0.0"
  category: productivity
---

# Haoone: 字幕工作流技能

**Invocation:** `/haoone $1 $2` where `$1` is the command and `$2` is the argument.

haoone 是新一代 AI 专业字幕软件，此技能为其 Codex 配套插件，可以免费使用。
基于 qwen3-asr 本地模型，提供完整的字幕处理能力。

haoone 软件介绍：[https://www.haoai.pro/haoone](https://www.haoai.pro/haoone)
haoone-cli 命令行工具介绍：[https://guide.haoai.pro/guide/haoone/使用haoone-cli命令行工具](https://guide.haoai.pro/guide/haoone/%E4%BD%BF%E7%94%A8haoone-cli%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%B7%A5%E5%85%B7)

## Quick Reference

| Command | What it does |
|---------|-------------|
| `/haoone transcribe <file>` | 转录单个音频或视频文件 |
| `/haoone batch-transcribe <files>` | 批量转录多个媒体文件 |
| `/haoone installed-models` | 查看已安装的本地模型 |
| `/haoone manuscript-matching <args>` | 文稿匹配对齐 |
| `/haoone format-draft <file>` | 格式化文稿 |
| `/haoone hotwords add <args>` | 批量添加热词 |
| `/haoone hotwords list` | 查看热词配置 |
| `/haoone project list` | 查看项目列表 |
| `/haoone project srt <project>` | 查看项目下的 SRT 文件 |
| `/haoone project create <name>` | 创建新项目 |
| `/haoone project delete <name>` | 删除项目 |
| `/haoone config` | 查看软件配置 |
| `/haoone srt-to-article <file>` | 读取 SRT 生成结构化文稿（扩展工作流） |

## 前置条件

1. 安装了 [haoone](https://www.haoai.pro/haoone/download) 桌面端，并完成登录
2. 在软件中下载本地模型
3. 点击软件的设置按钮，启动命令行工具

验证命令可用：

```bash
haoone-cli --help
```

确认本地模型已安装：

```bash
haoone-cli installed-models
```

## Orchestration Logic

When the user invokes `/haoone`:

1. Parse the subcommand from `$1`
2. If the subcommand is `transcribe`, delegate to **haoone-transcribe** sub-skill
3. If the subcommand is `batch-transcribe`, delegate to **haoone-transcribe** sub-skill (batch mode)
4. If the subcommand is `manuscript-matching` or `format-draft`, delegate to **haoone-manuscript** sub-skill
5. If the subcommand is `hotwords`, delegate to **haoone-hotwords** sub-skill
6. If the subcommand is `project`, delegate to **haoone-project** sub-skill
7. If the subcommand is `srt-to-article`, execute the SRT-to-article workflow directly
8. If the subcommand is `config` or `installed-models`, execute directly
9. If no subcommand given, infer from user intent (see Intent Detection below)

## Intent Detection

When the user does not use an explicit subcommand:

- "帮我转字幕" / "转录这个视频" → `transcribe`
- "批量转录" / "一次转多个文件" → `batch-transcribe`
- "确认模型装好没" → `installed-models`
- "整理文稿" / "格式化" → `format-draft`
- "文稿匹配" / "对齐文稿" → `manuscript-matching`
- "管理热词" / "添加热词" → `hotwords`
- "查看项目" / "创建项目" / "删除项目" → `project`
- 用户给了 `.srt` 文件并要求整理 → SRT-to-Article workflow

## Sub-Skills

This skill orchestrates 4 specialized sub-skills:

1. **haoone-transcribe** -- 单文件与批量转录
2. **haoone-manuscript** -- 文稿匹配与格式化
3. **haoone-hotwords** -- 热词管理
4. **haoone-project** -- 项目管理

## Reference Files

Load these on-demand as needed (do NOT load all at startup):
- `references/haoone-cli.md`: 完整 CLI 命令参考文档

## Output Processing

执行转录命令时，关注这些 stdout 关键行：

```text
srt_file_path=...
json_file_path=...
```

如果 `--output` 未传，由 `haoone-cli` 决定输出目录：
- 当前项目存在时，优先写入当前项目的 `transcriptions` 目录
- 否则写入输入媒体同级的 `transcriptions` 目录

## Error Handling

| Scenario | Action |
|----------|--------|
| `haoone-cli: command not found` | 执行 `which haoone-cli` 检查 PATH。提示用户重开终端或检查 CLI 安装。 |
| 没有安装模型 | 执行 `haoone-cli installed-models`，提示用户在桌面端安装模型。 |
| 未登录 / 未激活 | 提示用户打开 Haoone 桌面端确认登录和激活状态。 |
| 输出文件找不到 | 检查 `--output` 参数、当前项目 `transcriptions` 目录、输入文件同级 `transcriptions` 目录。 |
| 未识别的命令 | 列出 Quick Reference 表格，建议最接近的命令。 |
