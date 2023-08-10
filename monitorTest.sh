#!/bin/sh

# 检查并创建目标路径
prepare_target_paths() {
    prepare_directory "/etc/sillyplus/language"
    prepare_directory "/etc/sillyplus/plugins"

    create_symbolic_link "/etc/sillyplus/language" "/usr/local/sillyGirl/language"
    create_symbolic_link "/etc/sillyplus/plugins" "/usr/local/sillyGirl/plugins"
}

# 检查并创建目录
prepare_directory() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        # echo "初次使用，开始初始化目录"
    fi
    chmod 755 "$dir" # 赋予必要的权限
}

# 创建符号链接
create_symbolic_link() {
    local source="$1"
    local target="$2"
    if [ ! -L "$target" ]; then
        ln -s "$source" "$target"
        echo "初次使用，开始初始化依赖目录"
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
    kill -s TERM 1
}

# 主函数
main() {
    prepare_target_paths
    start_and_monitor_sillyGirl
}

main "$@"
