#!/bin/sh

# 重启当前容器
restart_container() {
    echo "不进入静默模式，重启当前容器..."
    sleep 3
    kill -s TERM 1
}

# 监控程序输出并执行操作
monitor_output() {
    echo "进入监控程序..."
    /usr/local/sillyGirl/sillyGirl -t | while IFS= read -r line; do
        echo "$line"  # 输出到标准输出（stdout）
        if echo "$line" | grep -q "程序以静默模式运行"; then
            restart_container  # 出现指定字样时重启当前容器
        fi
    done 
}

# 主函数
main() {
    monitor_output  # 启动监控程序输出并执行操作
}

main "$@"
