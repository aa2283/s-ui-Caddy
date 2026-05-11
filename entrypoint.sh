#!/bin/sh
# 1. 先跑隧道，丢到后台，并把日志强制打出来
echo "Starting Cloudflare Tunnel..."
/usr/local/bin/cloudflared tunnel --no-autoupdate run --token ${TUNNEL_TOKEN} > /dev/stdout 2>&1 &

# 2. 等一下 s-ui 环境
sleep 2

# 3. 运行原镜像的 s-ui（不加 &，让它留在前台占领日志）
echo "Starting s-ui..."
exec s-ui run
