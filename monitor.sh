#!/bin/sh

# 启动sillyGirl程序
start_sillyGirl() {
    # echo "Starting sillyGirl..."
    /usr/local/sillyGirl/sillyGirl -t
}

# 重启当前容器
restart_container() {
    echo "不进入静默模式，重启当前容器..."
    leep 3
    kill -s TERM 1
}

# 监控程序输出并执行操作
monitor_output() {
    echo "进入监控程序..."
    while IFS= read -r line; do
        if echo "$line" | grep -q "程序以静默形式运行"; then
            restart_container  # 出现指定字样时重启当前容器
        fi
        echo "$line"  # 输出到标准输出（stdout）
    done 
}

# 主函数
main() {
    start_sillyGirl &
    monitor_output  # 使用管道符号连接两个命令
}

main "$@"
