# AI Hub

AI 全家桶配置中心。

## 包含内容

- **Claude Code** — 设置、用户画像、长期记忆
- **cc-connect** — 多平台桥接配置、会话数据
- **DeepSeek** — API 代理配置（通过 cc-connect 环境变量注入）

## 目录结构

```
├── claude/
│   ├── settings.json          # Claude Code 设置
│   └── memory/                # AI 长期记忆
│       ├── MEMORY.md          # 记忆索引
│       ├── user-profile.md    # 用户画像
│       └── dragon-ball-music-rankings.md
├── cc-connect/
│   ├── config.toml            # cc-connect 主配置
│   └── data/                  # 运行时数据
└── README.md
```

## 注意事项

所有密钥和 Token 已替换为占位符，使用前请填入真实值。
