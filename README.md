# Haoone for Codex

Haoone for Codex 字幕工作流插件，基于最先进的本地模型，为 Codex GUI 提供完整的音视频转录与字幕处理能力。

官网：https://haoai.pro/haoone

## Features

- 单文件音视频转录（SRT + JSON 输出）
- 批量转录多个媒体文件
- 文稿匹配对齐（仅限激活用户）
- 文稿格式化
- 热词批量添加与管理
- 项目创建、查看、删除
- SRT 字幕转结构化文稿（扩展工作流）
- 软件配置与模型状态查看

## Invocation

主要 skill 名称为 `haoone`，支持以下 Codex 入口：

- Slash command: `/haoone transcribe /path/to/media.mp4`
- Explicit skill call: `$haoone batch-transcribe /path/to/a.mp3,/path/to/b.mp4`
- Natural language: 帮我把这个视频转成字幕

### Subcommands

| Command | Description |
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
| `/haoone srt-to-article <file>` | 读取 SRT 生成结构化文稿 |

## Repository Layout

```
haoone-for-codex/
├── .codex-plugin/plugin.json          # Plugin metadata
├── .agents/plugins/marketplace.json   # Marketplace registration
├── agents/
│   └── haoone.md                      # Agent definition
├── assets/
│   ├── icon.svg                       # Composer icon
│   └── logo.svg                       # Plugin logo
├── scripts/
│   └── install_plugin.py              # Install / uninstall script
├── install.sh                         # Shell installer
├── skills/
│   ├── haoone/
│   │   ├── SKILL.md                   # Main skill (orchestrator)
│   │   └── references/
│   │       └── haoone-cli.md          # Full CLI reference docs
│   ├── haoone-transcribe/
│   │   └── haoone-transcribe.md       # Sub-skill: transcription
│   ├── haoone-manuscript/
│   │   └── haoone-manuscript.md       # Sub-skill: manuscript & formatting
│   ├── haoone-hotwords/
│   │   └── haoone-hotwords.md         # Sub-skill: hotwords management
│   └── haoone-project/
│       └── haoone-project.md          # Sub-skill: project management
└── LICENSE
```

## Prerequisites

1. 安装 [Haoone 桌面端](https://www.haoai.pro/haoone/download) 并完成登录
2. 在桌面端中下载本地模型（推荐 `中英-v2-2026`）
3. 点击软件设置按钮，启动命令行工具（haoone-cli）

验证环境：

```bash
haoone-cli --help
haoone-cli installed-models
```

## Install

macOS / Linux:

```bash
git clone https://github.com/minghe36/haoone-for-codex.git
cd haoone-for-codex
./install.sh
```

The installer:
1. Copies the plugin to `~/plugins/haoone-for-codex`
2. Updates `~/.agents/plugins/marketplace.json` with the local plugin entry

## Uninstall

```bash
python3 scripts/install_plugin.py uninstall
```

## Verification

```bash
# Install script help
python3 scripts/install_plugin.py --help

# Verify plugin files
ls ~/plugins/haoone-for-codex/

# Verify marketplace entry
cat ~/.agents/plugins/marketplace.json
```

## Sub-Skills

主 skill `haoone` 调度以下 4 个子技能：

| Sub-Skill | Responsibility |
|-----------|---------------|
| `haoone-transcribe` | 单文件与批量转录 |
| `haoone-manuscript` | 文稿匹配、格式化、SRT 转文稿 |
| `haoone-hotwords` | 热词批量添加与查看 |
| `haoone-project` | 项目 CRUD、配置查看、模型检查 |

## Error Handling

| Scenario | Resolution |
|----------|-----------|
| `haoone-cli: command not found` | 运行 `which haoone-cli`，重开终端或检查 CLI 安装 |
| 没有安装模型 | 运行 `haoone-cli installed-models`，在桌面端安装模型 |
| 未登录 / 未激活 | 打开 Haoone 桌面端确认登录和激活状态 |
| 输出文件找不到 | 检查 `--output`、项目 `transcriptions/`、输入文件同级 `transcriptions/` |

## Credits

- Adapted from [haoone-skill](https://github.com/minghe36/haoone-skill)
- Plugin layout inspired by [codex-seo](https://github.com/BestLemoon/codex-seo)
- Haoone 桌面端: [https://www.haoai.pro/haoone](https://www.haoai.pro/haoone)
- CLI 文档: [https://guide.haoai.pro/guide/haoone/使用haoone-cli命令行工具](https://guide.haoai.pro/guide/haoone/%E4%BD%BF%E7%94%A8haoone-cli%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%B7%A5%E5%85%B7)

## License

MIT — see [LICENSE](./LICENSE)
