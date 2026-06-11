---
name: haoone-transcribe
description: "音视频转录子技能。支持单文件转录和批量转录，基于 qwen3-asr 本地模型生成 SRT 字幕和 JSON 结果。"
---

# Haoone Transcribe: 音视频转录

## 单文件转录

```bash
haoone-cli \
  transcribe \
  --timeline-name demo \
  --audio-file-path /path/to/audio.mp3
```

关键参数：

| 参数 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `--timeline-name` / `-n` | 否 | 自动从文件名提取 | 时间线名称 |
| `--audio-file-path` / `-f` | 是 | 无 | 输入音频或视频路径 |
| `--output` / `-o` | 否 | 自动推断 | 输出目录 |
| `--model` / `-m` | 否 | `中英-v2-2026` | 转录模型名 |
| `--language` / `-l` | 否 | `zh` | 语言代码 |
| `--enable-ai-correction` / `-a` | 否 | `false` | 是否启用 AI 智能拆行与热词替换 |
| `--max-subtitle-length` / `-s` | 否 | `25` | 单行字幕最大长度 |

示例：

```bash
haoone-cli \
  transcribe \
  -n interview01 \
  -f /Users/you/Desktop/interview01.mp3 \
  -m 中英-v2-2026 \
  -l zh
```

启用 AI 智能拆行与热词替换：

```bash
haoone-cli \
  transcribe \
  -n interview01 \
  -m 中英-v2-2026 \
  -f /Users/you/Desktop/interview01.mp4 \
  -a true \
  -l zh \
  -s 22
```

输出结果包括 `*.srt` 和 `*.json` 文件。

## 批量转录

```bash
haoone-cli \
  batch-transcribe \
  --audio-file-path /path/to/a.mp3,/path/to/b.mp4 \
  --output /path/to/out
```

关键参数：

| 参数 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `--audio-file-path` / `-f` | 是 | 无 | 输入媒体文件，逗号分隔 |
| `--output` / `-o` | 否 | 自动推断 | 输出目录 |
| `--model` / `-m` | 否 | `中英-v2-2026` | 转录模型名 |
| `--language` / `-l` | 否 | `zh` | 语言代码 |
| `--enable-online-transcript` / `-w` | 否 | `false` | 是否启用在线转录 |
| `--enable-ai-correction` / `-a` | 否 | `true` | 是否启用 AI 智能拆行与热词替换 |
| `--max-subtitle-length` / `-s` | 否 | `25` | 单行字幕最大长度 |

## 输出处理

关注 stdout 中的关键行：

```text
srt_file_path=...
json_file_path=...
```

输出目录推断规则：
- 指定 `--output` 时写入指定目录
- 当前项目存在时，写入当前项目的 `transcriptions` 目录
- 否则写入输入文件同级的 `transcriptions` 目录

## 故障排查

- `command not found` → 检查 `which haoone-cli`，重开终端
- 没有模型 → 执行 `haoone-cli installed-models`，在桌面端安装
- 转录失败 → 检查桌面端登录状态、网络、本地模型
