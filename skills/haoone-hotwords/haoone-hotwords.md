---
name: haoone-hotwords
description: "热词管理子技能。支持批量添加热词和查看热词配置。"
---

# Haoone Hotwords: 热词管理

## 批量添加热词

直接传字符串：

```bash
haoone-cli \
  batch-add-hotwords \
  -l zh \
  --input "OpenAI=欧喷AI,Open A I"
```

从文件读取：

```bash
haoone-cli \
  batch-add-hotwords \
  -l zh \
  -f /path/to/hotwords.txt
```

参数：

| 参数 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `--language` / `-l` | 是 | 无 | 热词语言 |
| `--file` / `-f` | 否 | 无 | 从文件读取热词内容 |
| `--input` | 否 | 无 | 直接传入热词文本 |

规则：
- `--file` 和 `--input` 至少传一个
- 两者同时传时，优先读取 `--file`

支持两种输入格式：

格式一（等号分隔）：

```text
OpenAI=欧喷AI,Open A I
ChatGPT=chat g p t,Chat GP T
```

格式二（换行分隔）：

```text
OpenAI
欧喷AI
Open A I

ChatGPT
chat g p t
Chat GP T
```

## 查看热词配置

```bash
haoone-cli get-hotwords
```

输出信息包括：
- 语言
- 热词
- 别名
- 拼音
- 首字母
