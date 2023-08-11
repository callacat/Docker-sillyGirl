#!/bin/sh

# 检查并创建目标路径
prepare_target_paths() {
    # if [ ! -d "/usr/local/sillyGirl/language" ]; then
    #     echo "/usr/local/sillyGirl/language 目录不存在，开始创建"
    #     mkdir -p /usr/local/sillyGirl/language
    # fi

    # if [ ! -d "/usr/local/sillyGirl/plugins" ]; then
    #     echo "/usr/local/sillyGirl/plugins 目录不存在，开始创建"
    #     mkdir -p /usr/local/sillyGirl/plugins
    # fi

    # chmod 777 /usr/local/sillyGirl/language /usr/local/sillyGirl/plugins

    if [ ! -L "/etc/sillyplus/language" ]; then
        echo "指向 /etc/sillyplus/language 的软链接不存在，开始创建"
        ln -s /usr/local/sillyGirl/language /etc/sillyplus/
    fi

    if [ ! -L "/etc/sillyplus/plugins" ]; then
        echo "指向 /etc/sillyplus/plugins 的软链接不存在，开始创建"
        ln -s /usr/local/sillyGirl/plugins /etc/sillyplus/
    fi
}

# 启动sillyGirl程序并监控输出
start_sillyGirl() {
    exec /usr/local/sillyGirl/sillyGirl -t
}

# 监控程序输出并执行操作
monitor_output() {
    # echo "进入监控程序..."
    /usr/local/sillyGirl/sillyGirl -t | while IFS= read -r line; do
        echo "$line" # 输出到标准输出（stdout）
    done
}

# 主函数
main() {
    prepare_target_paths # 检查并创建目标路径
    start_sillyGirl &
    monitor_output # 启动监控程序输出并执行操作
}

main "$@"
