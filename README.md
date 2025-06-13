# LLM-Proxy

LLM-Proxy 是一个高性能的 API 代理服务，专为 LLM (Large Language Model) API 调用设计。它提供了灵活的配置选项、缓存控制、WebSocket 支持等特性，帮助开发者更高效地管理和使用 LLM API。

## 特性

- 🚀 高性能：基于 Nginx 的高性能代理
- 🔒 安全：支持 SSL/TLS，可配置安全头部
- 🔄 缓存：智能缓存控制，提升响应速度
- 🌐 WebSocket：完整的 WebSocket 支持
- ⚙️ 可配置：通过环境变量或配置文件轻松配置
- 📊 监控：内置访问日志和错误日志

## 快速开始

### 直接部署

1. 安装 Nginx：
```bash
sudo apt-get update
sudo apt-get install nginx
```

2. 复制配置文件：
```bash
sudo cp config/nginx.conf /etc/nginx/conf.d/llm-proxy.conf
```

3. 启动服务：
```bash
sudo nginx -t && sudo nginx
```

## 配置说明

### 主要配置文件

- `config/nginx.conf`：主配置文件，包含代理、缓存、WebSocket、健康检查等设置

### 关键路径

- `/v1/`：所有以 `/v1/` 开头的请求会被代理到目标 API
- `/health`：健康检查接口，返回 `healthy` 字符串
- `/`：根路径，返回欢迎页面

### 变量说明

| 变量名 | 说明 | 示例 |
|--------|------|------|
| TARGET_API | 目标 API 地址 | https://your-llm-api.com |

## 目录结构

```
llm-proxy/
├── config/             # 配置文件目录
│   └── nginx.conf     # Nginx 主配置文件
├── src/               # 源代码目录
│   └── nginx/         # Nginx 相关脚本
├── docs/              # 文档目录
├── examples/          # 示例配置
├── README.md          # 项目说明文档
├── LICENSE            # 许可证
└── .gitignore         # Git 忽略文件
```

## 使用示例

### 基本代理

```bash
curl http://localhost/v1/chat/completions
```

### WebSocket 连接

```javascript
const ws = new WebSocket('ws://localhost/v1/chat/stream');
```

### 健康检查

```bash
curl http://localhost/health
```

## 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 联系方式

- 项目维护者：[CrazyCherrys]
- 邮箱：[sax_czarist2j@icloud.com]
- 项目链接：[https://github.com/CrazyCherrys/LLM-Proxy]

## 致谢

- [Nginx](https://nginx.org/) 