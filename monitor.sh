#!/bin/sh

# 启动sillyGirl程序
start_sillyGirl() {
    echo "Starting sillyGirl..."
    /usr/local/sillyGirl/sillyGirl -t
}

# 重启当前容器
restart_container() {
    echo "Restarting container..."
    kill -s TERM 1
}

# 监控程序输出并执行操作
monitor_output() {
    /usr/local/sillyGirl/sillyGirl -t | while read -r line; do
        if echo "$line" | grep -q "程序以静默形式运行"; then
            echo "重启当前容器..."
            restart_container  # 出现指定字样时重启当前容器
        fi
    done
}

# 主函数
main() {
    start_sillyGirl  # 启动sillyGirl程序
    monitor_output   # 监控程序输出并执行操作
}

main "$@"
