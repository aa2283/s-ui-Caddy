#!/bin/sh

echo "--- Diagnostic Start ---"
echo "Current Token length: ${#TUNNEL_TOKEN}"
echo "Searching for s-ui binary..."
# 暴力搜索所有可能的二进制文件
ACTUAL_SUI=$(find / -name "*s-ui*" -type f -executable | head -n 1)
echo "Found potential binary at: $ACTUAL_SUI"
echo "--- Diagnostic End ---"

# 1. 启动隧道 (改变参数顺序，确保变量被读取)
echo "Starting Cloudflare Tunnel..."
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" --no-autoupdate > /dev/stdout 2>&1 &

# 2. 等待隧道握手
sleep 5

# 3. 运行面板
if [ -n "$ACTUAL_SUI" ]; then
    echo "Starting panel from $ACTUAL_SUI"
    exec "$ACTUAL_SUI" run
else
    echo "Using fallback command..."
    exec s-ui run
fi
