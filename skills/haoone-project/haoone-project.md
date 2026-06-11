---
name: haoone-project
description: "项目管理子技能。支持查看项目列表、查看项目 SRT 文件、创建项目、删除项目、查看软件配置。"
---

# Haoone Project: 项目管理

## 查看软件配置

```bash
haoone-cli get-config
```

输出信息包括：
- 应用数据目录路径
- app.json 文件路径
- 激活状态
- 最近打开的项目
- 当前项目
- 项目目录
- 项目数量
- 自定义 API 配置（endpoint、model、apiKey 等）
- 用户 token 状态

## 查看项目列表

```bash
haoone-cli get-project-list
```

输出信息包括：
- 项目名
- 项目路径
- 更新时间
- 最近打开时间
- 是否为当前项目

## 查看项目下的 SRT 文件

```bash
haoone-cli \
  get-project-srt-list \
  -p project_name
```

参数：

| 参数 | 必填 | 默认值 | 说明 |
|------|------|--------|------|
| `--project-name` / `-p` | 否 | 当前项目 | 项目名称 |

递归查找指定项目目录下的所有 `.srt` 文件路径。

## 创建项目

```bash
haoone-cli \
  create-project \
  -n demo-project
```

参数：

| 参数 | 必填 | 说明 |
|------|------|------|
| `--name` / `-n` | 是 | 项目名称 |

## 删除项目

```bash
haoone-cli \
  delete-project \
  -n demo-project
```

参数：

| 参数 | 必填 | 说明 |
|------|------|------|
| `--name` / `-n` | 否 | 项目名称，不传时尝试删除当前项目 |

## 查看已安装模型

```bash
haoone-cli installed-models
```

适合确认本地模型是否已准备好。
