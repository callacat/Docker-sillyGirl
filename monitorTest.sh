#!/bin/bash

# 检查并创建目标路径
prepare_target_paths() {
    if [ ! -d "/etc/sillyplus/language" ]; then
        # echo "/etc/sillyplus/language 目录不存在，开始创建"
        mkdir -p /etc/sillyplus/language
    fi

    if [ ! -d "/etc/sillyplus/plugins" ]; then
        # echo "/etc/sillyplus/plugins 目录不存在，开始创建"
        mkdir -p /etc/sillyplus/plugins
    fi

    chmod 777 /etc/sillyplus/language /etc/sillyplus/plugins

    if [ ! -L "/usr/local/sillyGirl/language" ]; then
        # echo "指向 usr/local/sillyGirl/language 的软链接不存在，开始创建"
        ln -s /etc/sillyplus/language /usr/local/sillyGirl/
    fi

    if [ ! -L "/usr/local/sillyGirl/plugins" ]; then
        # echo "指向 usr/local/sillyGirl/plugins 的软链接不存在，开始创建"
        ln -s /etc/sillyplus/plugins /usr/local/sillyGirl/
    fi
}

# 启动sillyGirl程序并监控输出
start_sillyGirl() {
    (exec /usr/local/sillyGirl/sillyGirl -t) &
}

# 监控程序输出并执行操作
monitor_output() {
    # echo "进入监控程序..."
    /usr/local/sillyGirl/sillyGirl -t | tee /tmp/output.txt | while IFS= read -r line; do
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