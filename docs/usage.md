# LLM-Proxy 使用说明

## 目录
- [安装](#安装)
- [配置](#配置)
- [使用](#使用)
- [高级配置](#高级配置)
- [故障排除](#故障排除)

## 安装

### 使用 Docker 安装

1. 克隆仓库：
```bash
git clone https://github.com/yourusername/llm-proxy.git
cd llm-proxy
```

2. 配置环境变量：
```bash
export TARGET_API=https://your-llm-api.com
export PORT=8080  # 可选，默认 80
```

3. 启动服务：
```bash
docker-compose up -d
```

### 直接安装

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

## 配置

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

## 使用

### 基本代理

```bash
# 代理到目标 API
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

## 高级配置

### 自定义缓存策略

在 `nginx.conf` 中修改缓存配置：

```nginx
# 缓存设置
proxy_cache_path /tmp/nginx_cache levels=1:2 keys_zone=my_cache:10m max_size=10g inactive=60m use_temp_path=off;

location /v1/ {
    proxy_cache my_cache;
    proxy_cache_use_stale error timeout http_500 http_502 http_503 http_504;
    proxy_cache_valid 200 60m;
}
```

### SSL 配置

1. 准备 SSL 证书
2. 在 `nginx.conf` 中添加 SSL 配置：

```nginx
server {
    listen 443 ssl;
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    # ... 其他配置
}
```

## 故障排除

### 常见问题

1. 502 Bad Gateway
   - 检查目标 API 是否可访问
   - 检查网络连接
   - 查看 Nginx 错误日志

2. 连接超时
   - 检查目标 API 响应时间
   - 调整超时设置

3. WebSocket 连接失败
   - 确认目标 API 支持 WebSocket
   - 检查 WebSocket 配置

### 日志查看

```bash
# 访问日志
tail -f /var/log/nginx/access.log

# 错误日志
tail -f /var/log/nginx/error.log
```

### 性能优化

1. 调整工作进程数：
```bash
export WORKER_PROCESSES=4
```

2. 启用压缩：
```nginx
gzip on;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
```

3. 调整缓存策略：
```nginx
proxy_cache_valid 200 60m;
proxy_cache_use_stale error timeout http_500 http_502 http_503 http_504;
``` 