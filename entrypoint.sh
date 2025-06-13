#!/bin/bash

# 设置默认端口
PORT=${PORT:-80}

# 替换配置文件中的API地址
sed -i "s|https://api.996444.cn|$TARGET_API|g" /etc/nginx/conf.d/default.conf
sed -i "s|api.996444.cn|$(echo $TARGET_API | sed 's|^https://||')|g" /etc/nginx/conf.d/default.conf

# 设置工作进程数
if [ ! -z "$WORKER_PROCESSES" ]; then
    sed -i "s/worker_processes auto;/worker_processes $WORKER_PROCESSES;/" /etc/nginx/nginx.conf
fi

# 确保日志目录存在
mkdir -p /var/log/nginx

# 启动Nginx（前台运行）
exec nginx -g 'daemon off;'