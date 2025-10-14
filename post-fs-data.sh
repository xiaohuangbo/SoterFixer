#!/system/bin/sh

# 兼容Magisk和KernelSU的模块路径
if [ -n "$MODPATH" ]; then
    # Magisk环境
    MODDIR="$MODPATH"
else
    # KernelSU环境
    MODDIR=${0%/*}
fi

# 设置权限
chmod 0755 "$MODDIR/service.sh"
chmod 0755 "$MODDIR/fix_soter_key.sh"