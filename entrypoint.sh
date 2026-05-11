#!/bin/sh

# 1. 极其简单的启动方式：直接把 token 喂给 run 指令
# 删掉所有多余的 --no-autoupdate 等参数，只留核心
echo "Starting Cloudflare Tunnel..."
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" &

# 2. 解决 s-ui 找不到的“死计”
# 既然我们怎么都找不到 s-ui 的位置，我们用一种暴力但有效的办法
echo "Attempting to start s-ui..."
# 尝试运行原镜像原本打算运行的那个脚本
if [ -f "/usr/local/s-ui/s-ui" ]; then
    exec /usr/local/s-ui/s-ui run
else
    # 最后的挣扎：如果找不到，就尝试直接喊名字
    exec s-ui run
fi
