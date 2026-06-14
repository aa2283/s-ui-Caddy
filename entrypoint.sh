#!/bin/sh

echo "=== 1. 正在启动 Cloudflare 隧道 ==="
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" &

echo "=== 2. 验证网络监听状态（启动前） ==="
sleep 2

echo "=== 3. 正在前台启动 s-ui 面板并实时输出日志 ==="
# 去掉末尾的 &，让 s-ui 作为容器的主进程在前台运行！
# 这样它的所有日志、节点连接、报错，都会100%实时刷新在 Northflank 的日志控制台上！
exec /app/sui
