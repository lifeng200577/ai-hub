---
name: inspection-automation
description: 巡检表自动化系统完整配置与使用规则
metadata: 
  node_type: memory
  type: project
  originSessionId: 8f0bba44-a300-4bae-a275-686066827477
---

# 巡检表自动化系统

## 使用方式
用户说日期+班次，AI 自动改日期、改频道数、定时发邮件。

例："6月15日白班" 或 "今天夜班，晚上七点三十"

## 文件模板
- 白班模板：`/root/projects/c-nexus/.cc-connect/attachments/任志财20260602白班监播监控巡检表2026.xlsx`
- 夜班模板：`/root/projects/c-nexus/.cc-connect/attachments/任志财20260606夜班监播监控巡检表2026.xlsx`
- 自动化脚本：`/root/projects/c-nexus/auto-inspection.py`

## 发送规则
- 白班 → 当天 21:00（或用户指定时间）
- 夜班 → 第二天 9:00（或用户指定时间）
- 用户可以指定任意发送时间
- 全部使用北京时间（UTC+8）

## 邮件配置
- SMTP：smtp.qiye.aliyun.com 或 smtp.mxhichina.com
- 端口：465 (SSL)
- 发件人：renzhicai@lnitv.com
- 当前收件人：renzhicai@lnitv.com

## 白班特殊处理
- IPTV 频道数自动从 141 改为 142

## 工作流程
1. 用户说日期+班次+发送时间
2. AI 改日期改频道数
3. AI 展示结果，等用户确认
4. 用户确认后，AI 用 at 命令设定时任务
5. 到点自动发邮件

## 注意事项
- 必须用 /usr/bin/python3 完整路径（at 环境不认简称）
- at 命令必须带 TZ='Asia/Shanghai'（服务器是 UTC）
- 发邮件前必须让用户确认
- 不要擅自发邮件或设定时任务

**Why:** 用户工作需要的全自动巡检表处理流水线，从微信收文件到钉钉邮箱发结果全链路打通。
**How to apply:** 每次用户提到巡检表、白班、夜班、监播、发邮件时，按此流程操作。
