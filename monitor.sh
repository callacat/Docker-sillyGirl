#!/bin/sh

LOG_FILE="/tmp/sillyGirl.log"

# 启动sillyGirl程序
start_sillyGirl() {
    echo "Starting sillyGirl..."
    /usr/local/sillyGirl/sillyGirl -t | tee -a "$LOG_FILE"
}

# 重启当前容器
restart_container() {
    echo "Restarting container..."
    kill -s TERM 1
}

# 监控程序输出并执行操作
monitor_output() {
    echo "进入监控程序..."
    tail -f "$LOG_FILE" | while IFS= read -r line; do
        if echo "$line" | grep -q "程序以静默形式运行"; then
            echo "重启当前容器..."
            restart_container  # 出现指定字样时重启当前容器
        fi
        echo "$line"  # 输出到标准输出（stdout）
    done 
}

# 主函数
main() {
    start_sillyGirl | monitor_output  # 使用管道符号连接两个命令
}

main "$@"
