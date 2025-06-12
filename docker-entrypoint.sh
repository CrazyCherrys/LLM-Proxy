#!/bin/sh

# 替换配置文件中的API地址
sed -i "s|https://api.996444.cn|$TARGET_API|g" /etc/nginx/conf.d/default.conf
sed -i "s|api.996444.cn|$(echo $TARGET_API | sed 's|^https://||')|g" /etc/nginx/conf.d/default.conf

# 启动Nginx
exec nginx -g 'daemon off;' 