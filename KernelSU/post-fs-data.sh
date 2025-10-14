#!/system/bin/sh
# KernelSU模块安装脚本

MODDIR=${0%/*}

# 设置权限
chmod 0755 $MODDIR/service.sh
chmod 0755 $MODDIR/fix_soter_key.sh