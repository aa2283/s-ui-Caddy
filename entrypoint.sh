#!/bin/sh

# 1. 启动隧道（既然通了，就保持原样）
echo "Starting Cloudflare Tunnel..."
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" &

# 2. 这里的逻辑很关键：全盘搜索 s-ui 到底在哪里
echo "Searching for s-ui binary..."
SUI_BIN=$(find / -name "s-ui" -type f -executable | grep -v "entrypoint.sh" | head -n 1)

if [ -n "$SUI_BIN" ]; then
    echo "Found s-ui at: $SUI_BIN"
    # 3. 使用绝对路径启动面板
    echo "Starting panel..."
    exec "$SUI_BIN" run
else
    echo "CRITICAL ERROR: Could not find s-ui anywhere!"
    # 找不到也不要关机，保住隧道
    tail -f /dev/null
fi
