#!/system/bin/sh
# 通用模块安装脚本，兼容Magisk和KernelSU

ui_print "******************************"
ui_print "SOTER Key修复模块 - 通用版"
ui_print "版本: 1.0 正式版"
ui_print "作者: 酷安福瑞@小黄泊 ต (=ω=)ต" 
ui_print "支持: Magisk & KernelSU"
ui_print "******************************"

# 设置权限
if [ -n "$MODPATH" ]; then
    # Magisk环境
    set_perm_recursive $MODPATH 0 0 0755 0644
    set_perm $MODPATH/service.sh 0 0 0755
    set_perm $MODPATH/fix_soter_key.sh 0 0 0755
else
    # KernelSU环境
    MODDIR=${0%/*}
    chmod 0755 $MODDIR/service.sh
    chmod 0755 $MODDIR/fix_soter_key.sh
fi