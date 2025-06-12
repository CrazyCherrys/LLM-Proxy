# LLM-Proxy

LLM-Proxy 是一个高性能的 API 代理服务，专为 LLM (Large Language Model) API 调用设计。它提供了灵活的配置选项、缓存控制、WebSocket 支持等特性，帮助开发者更高效地管理和使用 LLM API。

## 特性

- 🚀 高性能：基于 Nginx 的高性能代理
- 🔒 安全：支持 SSL/TLS，可配置安全头部
- 🔄 缓存：智能缓存控制，提升响应速度
- 🌐 WebSocket：完整的 WebSocket 支持
- ⚙️ 可配置：通过环境变量轻松配置
- 🐳 Docker：支持容器化部署
- 📊 监控：内置访问日志和错误日志

## 快速开始

### 使用 Docker

```bash
# 克隆仓库
git clone https://github.com/yourusername/llm-proxy.git
cd llm-proxy

# 配置环境变量
export TARGET_API=https://your-llm-api.com

# 启动服务
docker-compose up -d
```

### 直接部署

```bash
# 安装 Nginx
sudo apt-get update
sudo apt-get install nginx

# 复制配置文件
sudo cp config/nginx.conf /etc/nginx/conf.d/llm-proxy.conf

# 启动服务
sudo nginx -t && sudo nginx
```

## 配置说明

### 环境变量

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| TARGET_API | 目标 API 地址 | - |
| PORT | 监听端口 | 80 |
| WORKER_PROCESSES | Nginx 工作进程数 | auto |

### 配置文件

主要配置文件位于 `config/nginx.conf`，包含以下主要部分：

- 代理设置
- 缓存控制
- WebSocket 支持
- 安全头部
- 日志配置

## 目录结构

```
llm-proxy/
├── config/             # 配置文件目录
│   └── nginx.conf     # Nginx 主配置文件
├── src/               # 源代码目录
│   └── nginx/         # Nginx 相关脚本
├── docs/              # 文档目录
├── examples/          # 示例配置
├── Dockerfile         # Docker 构建文件
├── docker-compose.yml # Docker Compose 配置
└── README.md         # 项目说明文档
```

## 使用示例

### 基本代理

```bash
# 代理到目标 API
curl http://localhost/v1/chat/completions
```

### WebSocket 连接

```javascript
const ws = new WebSocket('ws://localhost/v1/chat/stream');
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

- 项目维护者：[Your Name]
- 邮箱：[your.email@example.com]
- 项目链接：[https://github.com/yourusername/llm-proxy]

## 致谢

- [Nginx](https://nginx.org/)
- [Docker](https://www.docker.com/) 