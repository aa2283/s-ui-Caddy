#!/bin/sh

# 1. 启动隧道（保持它绿着）
/usr/local/bin/cloudflared tunnel run --token "${TUNNEL_TOKEN}" &

echo "--- 正在进行全盘地毯式搜索 ---"

# 查找所有名为 s-ui 且可执行的文件，并排除脚本本身
SEARCH_SUI=$(find / -name "s-ui" -type f -executable | grep -v "entrypoint.sh")
echo "搜索 s-ui 结果: $SEARCH_SUI"

# 如果没找到，搜索任何包含 sui 字符的可执行文件（万一它叫 s-ui-linux-amd64 呢）
if [ -z "$SEARCH_SUI" ]; then
    echo "搜索 *sui* 结果:"
    find / -name "*sui*" -type f -executable
fi

# 2. 尝试启动（如果找到了）
if [ -n "$SEARCH_SUI" ]; then
    echo "尝试从找到的路径启动..."
    $SEARCH_SUI run &
else
    echo "错误：全盘未找到 s-ui 二进制文件！"
fi

# 3. 打印当前所有开放端口（确认面板是否起步）
sleep 5
echo "当前活跃端口监听状态:"
netstat -tuln

tail -f /dev/null
