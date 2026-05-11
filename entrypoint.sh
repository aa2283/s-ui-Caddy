#!/bin/sh

# 1. 启动隧道 (已确认正常)
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" &

echo "--- 正在尝试启动 sui 面板 ---"

# 2. 这里的改动至关重要：
# 很多版本不需要加 "run"，直接运行即可。
# 如果直接运行还退出，尝试执行后台运行。
/app/sui > /dev/stdout 2>&1 &

# 3. 这里的 32619 还是错的！
# 你的日志显示隧道依然在尝试转发到 32619。
# 请务必去 Cloudflare 官网把 Service 改成 http://localhost:2095

# 4. 检查是否真的跑起来了
sleep 5
echo "当前监听端口状态 (必须看到 2095 才行):"
netstat -tuln

tail -f /dev/null
