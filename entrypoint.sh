#!/bin/sh

# 1. 启动隧道（这部分已经完全正常了）
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" &

echo "--- 正在强制启动面板 ---"
# 我们不再用 cd，直接尝试镜像里最可能的几个路径
/usr/local/s-ui/s-ui run & 
s-ui run &

# 2. 检查端口是否真的出现了
sleep 5
echo "当前容器内部监听状态："
netstat -tuln | grep -E '2095|2096'

# 3. 保持容器运行
tail -f /dev/null
