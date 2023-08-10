#!/bin/bash

# 检查并创建目标路径
prepare_target_paths() {
    if [ ! -d "/etc/sillyplus/language" ]; then
        echo "/etc/sillyplus/language 目录不存在，开始创建"
        mkdir -p /etc/sillyplus/language
    fi

    if [ ! -d "/etc/sillyplus/plugins" ]; then
        echo "/etc/sillyplus/plugins 目录不存在，开始创建"
        mkdir -p /etc/sillyplus/plugins
    fi

    chmod 777 /etc/sillyplus/language /etc/sillyplus/plugins

    if [ ! -L "/usr/local/sillyGirl/language" ]; then
        echo "指向 usr/local/sillyGirl/language 的软链接不存在，开始创建"
        ln -s /etc/sillyplus/language /usr/local/sillyGirl/
    fi

    if [ ! -L "/usr/local/sillyGirl/plugins" ]; then
        echo "指向 usr/local/sillyGirl/plugins 的软链接不存在，开始创建"
        ln -s /etc/sillyplus/plugins /usr/local/sillyGirl/
    fi
}

# 启动sillyGirl程序并监控输出
start_and_monitor_sillyGirl() {
    /usr/local/sillyGirl/sillyGirl -t | while IFS= read -r line; do
        echo "$line"
        if echo "$line" | grep -q "程序以静默模式运行"; then
            echo "触发重启"
            # restart_container
        fi
    done
}

# 重启当前容器
# restart_container() {
#     # 从 /etc/sillyplus/sillyGirl.pid 文件中读取进程 ID
#     pid=$(cat /etc/sillyplus/sillyGirl.pid)

#     # 发送 TERM 信号给指定的进程，让它优雅地终止
#     kill -s TERM $pid
# }

# 主函数
main() {
    prepare_target_paths
    start_and_monitor_sillyGirl
}

main "$@"