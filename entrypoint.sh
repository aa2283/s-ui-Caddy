#!/bin/sh

# 1. 启动隧道（并在后台稳住）
echo "Starting Cloudflare Tunnel..."
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" > /dev/stdout 2>&1 &

# 2. 这里的改动极其重要：即使下面的命令报错，脚本也不会退出
set +e 

echo "Attempting to locate s-ui binary..."
# 打印一下当前的路径和文件，帮我们“排雷”
ls -F /usr/local/bin/
ls -F /usr/bin/

# 3. 尝试所有可能的真名（有些镜像里叫 s-ui-linux-amd64 之类的）
echo "Starting Panel..."
s-ui run || /usr/local/bin/s-ui run || /usr/bin/s-ui run || ./s-ui run

# 4. 关键：为了不让容器重启，我们加一个死循环，让隧道在后台一直跑
echo "Panel failed to start, but keeping the container alive for the tunnel..."
tail -f /dev/null
