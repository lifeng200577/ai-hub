#!/usr/bin/env python3
"""发送邮件脚本 - 阿里企业邮箱 SMTP"""

import smtplib
import sys
import os
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders

# SMTP 配置
SMTP_SERVER = "smtp.mxhichina.com"
SMTP_PORT = 465
SMTP_USER = "renzhicai@lnitv.com"
SMTP_PASS = os.environ.get("SMTP_PASS", "CcZvi1xqXmfYlZ0b")


def send_mail(to_addr, subject, body, attachments=None):
    msg = MIMEMultipart()
    msg["From"] = SMTP_USER
    msg["To"] = to_addr
    msg["Subject"] = subject
    msg.attach(MIMEText(body, "plain", "utf-8"))

    if attachments:
        for filepath in attachments:
            filename = os.path.basename(filepath)
            with open(filepath, "rb") as f:
                part = MIMEBase("application", "octet-stream")
                part.set_payload(f.read())
                encoders.encode_base64(part)
                part.add_header(
                    "Content-Disposition",
                    f'attachment; filename="{filename}"',
                )
                msg.attach(part)

    with smtplib.SMTP_SSL(SMTP_SERVER, SMTP_PORT) as server:
        server.login(SMTP_USER, SMTP_PASS)
        server.sendmail(SMTP_USER, to_addr, msg.as_string())

    print(f"✅ 邮件已发送到 {to_addr}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法: python3 send-mail.py <收件地址> [附件路径]")
        sys.exit(1)

    to = sys.argv[1]
    files = sys.argv[2:] if len(sys.argv) > 2 else None
    send_mail(to, "🤖 AI Hub 测试邮件", "这是一封测试邮件，如果你收到了说明配置成功！", files)
