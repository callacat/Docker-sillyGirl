#!/bin/sh

# 每次启动容器复制傻妞到 /usr/local/sillyGirl
cp /etc/sillyplus/sillyGirl /usr/local/sillyGirl/sillyGirl

# 启动sillyGirl程序
start_sillyGirl() {
    /usr/local/sillyGirl/sillyGirl -t
}

# 重启sillyGirl程序
restart_sillyGirl() {
    echo "Restarting sillyGirl..."
    pkill sillyGirl  # 结束正在运行的sillyGirl进程
    start_sillyGirl  # 启动sillyGirl
}

# 监控日志输出并执行操作
monitor_logs() {
    tail -f /path/to/sillyGirl.log | while read -r line; do
        if echo "$line" | grep -q "使用静默模式运行相关的字样"; then
            restart_sillyGirl  # 出现指定字样时重启sillyGirl
        fi
    done
}

# 主函数
main() {
    start_sillyGirl  # 启动sillyGirl程序
    monitor_logs    # 监控日志输出并执行操作
}

main "$@"
