# LLM-Proxy 使用说明

## 目录
- [安装](#安装)
- [配置](#配置)
- [使用](#使用)
- [高级配置](#高级配置)
- [故障排除](#故障排除)

## 安装

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

## 使用

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
```nginx
worker_processes 4;
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