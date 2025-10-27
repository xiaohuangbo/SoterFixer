#!/system/bin/sh

# 等待系统启动完成
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 5
done
setenforce 0
# 计算开始时间
START_TIME=$(date +%s)
END_TIME=$((START_TIME + 300))  # 5分钟 = 300秒

# 在5分钟内每5秒执行一次修复
while [ $(date +%s) -lt $END_TIME ]; do
    # 执行修复脚本
    stop vendor.soter
    sleep 1
    pm clear com.tencent.soter.soterserver
    start vendor.soter
    sleep 1
    
    # 每5秒执行一次（总共执行约60次）
    sleep 3
setenforce 1
done
