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

## 收件人列表（群发六人）
- lifangfang@lnitv.com（黎芳芳）
- renzhicai@lnitv.com（任志财）
- wujian@lnitv.com（吴健）
- xukaixuan@lnitv.com（徐凯旋）
- gezhijia@lnitv.com（葛志佳）
- liuweiwang@lnitv.com（刘伟旺）

## 工作流程（三步走，严格执行，不可跳步）
1. 用户说日期+班次+发送时间
2. AI 改日期改频道数，生成文件
3. **第一步**：AI 以文字信息展示预览（收件人列表、标题、附件文件名、正文、计划发送时间），**不发邮件、不设 at**
4. **第二步**：用户确认内容无误 → AI 问"只发任志财还是群发六人" → 用户决定
5. **第三步**：用户确认后，AI 用 at 命令设定时任务，到点自动发。**绝对不能用 --now 立即发**

## 用户排班制度
- 四天一轮：白班 → 夜班 → 休息 → 休息（白夜休休）
- 基准日：2026年6月11日北京时间凌晨，当前为夜班
- 推算：6月11日夜班 → 6月10日白班 → 6月9日&8日休息
- 注意：服务器UTC时间比北京时间晚8小时，以北京时间为准

## 注意事项
- 必须用 /usr/bin/python3 完整路径（at 环境不认简称）
- at 命令必须带 TZ='Asia/Shanghai'（服务器是 UTC）
- ⚠️ 发邮件前必须让用户确认，绝对不擅自发或设定时任务
- ⚠️ 分两步：① 先发任志财一人 → 用户确认 → ② 再发群发六人
- ⚠️ 绝对不能用 --now 直接群发，必须用 at 定时
- 曾犯错误(2026-06-11)：跳过了确认步骤，直接 --now 群发六人，用户紧急撤回

**Why:** 用户工作需要的全自动巡检表处理流水线，从微信收文件到钉钉邮箱发结果全链路打通。
**How to apply:** 每次用户提到巡检表、白班、夜班、监播、发邮件时，按此流程操作。
