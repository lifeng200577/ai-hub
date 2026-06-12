---
name: inspection-automation
description: 巡检表自动化——改日期、改频道数、发邮件（禁定时任务）
metadata: 
  node_type: memory
  type: project
  originSessionId: 8f0bba44-a300-4bae-a275-686066827477
---

# 巡检表自动化

## ⚠️ 重要变更 (2026-06-12)
**禁止使用 at 定时发送。** 不再设定时任务。
只能：用户确认后，立即发送。

## 使用方式
用户说日期+班次，AI 改日期、改频道数、生成文件、发邮件。

## 文件模板
- 白班模板：`/root/projects/c-nexus/.cc-connect/attachments/任志财20260602白班监播监控巡检表2026.xlsx`
- 夜班模板：`/root/projects/c-nexus/.cc-connect/attachments/任志财20260606夜班监播监控巡检表2026.xlsx`
- 脚本：`/root/projects/c-nexus/auto-inspection.py`

## 白班特殊处理
- IPTV 频道数自动从 141 改为 142

## 邮件配置
- SMTP：smtp.mxhichina.com，端口 465 (SSL)
- 发件人：renzhicai@lnitv.com

## 收件人列表
- renzhicai@lnitv.com（任志财）
- lifangfang@lnitv.com（黎芳芳）
- wujian@lnitv.com（吴健）
- xukaixuan@lnitv.com（徐凯旋）
- gezhijia@lnitv.com（葛志佳）
- liuweiwang@lnitv.com（刘伟旺）

## 工作流程（三步，严格执行）
1. 用户说日期+班次 → AI 改日期改频道数，生成文件
2. AI 展示预览（收件人、标题、附件名、正文），**不发邮件**
3. 用户确认 → AI 问"只发任志财还是群发六人" → 用户决定
4. 用户决定后 → AI 立即发送（不用 at，不用 --now 跳过确认）

## ⛔ 铁律
- **绝对不用 at 设定时任务**
- **绝对不用 --now 跳过确认直接群发**
- **发之前必须展示预览，等用户确认**

## 用户排班制度
- 四天一轮：白班 → 夜班 → 休息 → 休息（白夜休休）
- 基准日：2026年6月11日北京时间凌晨，当前为夜班
- 注意：服务器UTC时间比北京时间晚8小时，以北京时间为准

## 曾犯错误
- 2026-06-11：跳过确认，--now 直接群发六人，用户紧急撤回
- 之后又犯过同样错误，不止一次
- 用户明确：再犯错就不配待在这台服务器里

**Why:** 改日期生成文件，用户确认后发邮件。不定时任务。
**How to apply:** 生成文件 → 展示预览 → 等确认 → 发送。不用 at。
