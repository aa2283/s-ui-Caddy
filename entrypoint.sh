#!/bin/sh

# 1. 启动隧道
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" &

echo "--- 正在尝试启动面板 ---"
# alireza7/s-ui 镜像的二进制文件通常在 /usr/local/s-ui/s-ui
# 我们先跳到那个目录，再启动
cd /usr/local/s-ui && ./s-ui run &

# 2. 检查 2095 端口是否真的开了
sleep 5
echo "检查本地端口监听状态:"
netstat -tuln | grep 2095

# 3. 只要端口没开，就保住容器不崩溃，方便我们调试
tail -f /dev/null
