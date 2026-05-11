#!/bin/sh

# 1. 启动隧道（保持原样，它已经很完美了）
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" &

echo "--- 发现程序真名：/app/sui ---"

# 2. 使用刚才搜索到的确切路径启动
# 注意：alireza7 的版本通常需要 run 参数
/app/sui run &

# 3. 给它几秒钟启动时间，然后检查端口
sleep 5
echo "检查 2095 端口是否已开启:"
netstat -tuln | grep 2095

# 4. 防止脚本退出
tail -f /dev/null
