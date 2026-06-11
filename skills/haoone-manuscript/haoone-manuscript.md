---
name: haoone-manuscript
description: "文稿处理子技能。支持文稿匹配对齐和文稿格式化。"
---

# Haoone Manuscript: 文稿匹配与格式化

## 文稿匹配

将已有文稿与转录结果对齐：

```bash
haoone-cli \
  manuscript-matching \
  --manuscript-path /path/to/manuscript.txt \
  -n transcript_name \
  -p project_name
```

关键参数：

| 参数 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `--manuscript-path` | 是 | 无 | 文稿文件路径 |
| `--name` / `-n` | 是 | 无 | 转录名称（定位转录结果 JSON） |
| `--project` / `-p` | 否 | 当前项目 | 项目名称 |
| `--enable-splite-follows-script` / `-f` | 否 | `false` | 是否按文稿拆行 |

> 注意：文稿匹配仅限激活用户使用。

成功后会输出生成的字幕文件路径。

## 文稿格式化

```bash
haoone-cli \
  format-draft \
  -p /path/to/manuscript.txt
```

参数：

| 参数 | 必填 | 说明 |
|------|------|------|
| `--path` / `-p` | 是 | 输入文稿文件路径 |

格式化结果直接打印到终端。保存文件：

```bash
haoone-cli \
  format-draft \
  -p /path/to/manuscript.txt > /path/to/manuscript.formatted.txt
```

## SRT 转结构化文稿（扩展工作流）

这不是 `haoone-cli` 原生命令，而是本技能额外提供的工作流。

### 触发条件

- 用户提供了 `.srt` 文件
- 用户说"帮我整理成文稿" / "把字幕转成文章" / "按章节输出内容摘要"

### 执行步骤

1. 如果用户提供完整路径，直接读取 `.srt` 文件
2. 如果用户提供文件名，先调用 `haoone-cli get-project-srt-list` 查找
3. 如果用户给了项目名，使用 `haoone-cli get-project-srt-list -p project_name`
4. 匹配目标文件路径（多个候选时优先完全匹配，仍无法确定则向用户确认）
5. 读取 `.srt` 文件全文
6. 去掉序号、时间轴等字幕控制信息
7. 按语义合并连续字幕，恢复自然段
8. 根据内容组织结构化文稿

### 输出要求

- 默认输出中文
- 不改写原意，不凭空补充事实
- 去掉明显重复的字幕残片
- 存在主题切换时按小节组织

### 推荐输出模板

```markdown
# 标题

## 内容概览

一句话概括核心内容。

## 结构化正文

### 小节 1

整理后的正文内容。

### 小节 2

整理后的正文内容。

## 关键要点

- 要点 1
- 要点 2
- 要点 3
```
