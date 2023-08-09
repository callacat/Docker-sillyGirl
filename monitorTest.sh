#!/bin/sh

# 启动sillyGirl程序并监控输出
start_sillyGirl() {
    exec /usr/local/sillyGirl/sillyGirl -t
}

# 重启当前容器
restart_container() {
    kill -s TERM 1
}

# 监控程序输出并执行操作
monitor_output() {
    # echo "进入监控程序..."
    /usr/local/sillyGirl/sillyGirl -t | while IFS= read -r line; do
        echo "$line" # 输出到标准输出（stdout）
        if echo "$line" | grep -q "程序以静默模式运行"; then
            restart_container # 出现指定字样时重启当前容器
        fi
    done
}

# 主函数
main() {
    ln -s /etc/sillyplus/language /usr/local/sillyGirl/language
    ln -s /etc/sillyplus/plugins /usr/local/sillyGirl/plugins
    start_sillyGirl &
    monitor_output # 启动监控程序输出并执行操作
}

main "$@"