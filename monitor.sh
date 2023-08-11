#!/bin/sh

# 检查并创建目标路径
prepare_target_paths() {
    if [ ! -d "/etc/sillyplus/language" ]; then
        mkdir -p /etc/sillyplus/language
    fi

    if [ ! -d "/etc/sillyplus/plugins" ]; then
        mkdir -p /etc/sillyplus/plugins
    fi

    chmod 777 /etc/sillyplus/language /etc/sillyplus/plugins

    if [ ! -L "/usr/local/sillyGirl/language" ]; then
        ln -s /etc/sillyplus/language /usr/local/sillyGirl/
    fi

    if [ ! -L "/usr/local/sillyGirl/plugins" ]; then
        ln -s /etc/sillyplus/plugins /usr/local/sillyGirl/
    fi
}

# 启动sillyGirl程序并监控输出
start_sillyGirl() {
    exec /usr/local/sillyGirl/sillyGirl -t
}

# 监控程序输出并执行操作
monitor_output() {
    /usr/local/sillyGirl/sillyGirl -t | while IFS= read -r line; do
        echo "$line" # 输出到标准输出（stdout）
    done
}

# 主函数
main() {
    prepare_target_paths
    start_sillyGirl &
    monitor_output
}

main "$@"