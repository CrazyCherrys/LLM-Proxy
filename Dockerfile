# 使用官方Nginx镜像作为基础镜像
FROM nginx:alpine

# 复制Nginx配置文件
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 设置环境变量
ENV TARGET_API="https://api.996444.cn"

# 复制启动脚本
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# 暴露80端口
EXPOSE 80

# 使用自定义启动脚本
ENTRYPOINT ["/docker-entrypoint.sh"] 