#!/bin/bash

# 检查并创建目标路径
prepare_target_paths() {
    prepare_directory "/etc/sillyplus/language"
    prepare_directory "/etc/sillyplus/plugins"

    create_symbolic_link "/etc/sillyplus/*" "/usr/local/sillyGirl/"
    # create_symbolic_link "/etc/sillyplus/plugins" "/usr/local/sillyGirl/"
}

# 检查并创建目录
prepare_directory() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "初次使用，开始初始化目录 $dir"
    fi
    chmod 755 "$dir" # 赋予必要的权限
}

# 创建符号链接
create_symbolic_link() {
    local source="$1"
    local target="$2"
    if [ ! -L "$target" ]; then
        ln -s "$source" "$target"
        echo "初次使用，开始初始化软链接"
    fi
}

# 启动sillyGirl程序并监控输出
start_and_monitor_sillyGirl() {
    /usr/local/sillyGirl/sillyGirl -t | while IFS= read -r line; do
        echo "$line"
        if echo "$line" | grep -q "程序以静默模式运行"; then
            restart_container
        fi
    done
}

# 重启当前容器
restart_container() {
    # 从 /etc/sillyplus/sillyGirl.pid 文件中读取进程 ID
    pid=$(cat /etc/sillyplus/sillyGirl.pid)

    # 发送 TERM 信号给指定的进程，让它优雅地终止
    kill -s TERM $pid
}


# 主函数
main() {
    prepare_target_paths
    start_and_monitor_sillyGirl
}

main "$@"
