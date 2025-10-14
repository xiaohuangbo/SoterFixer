#!/system/bin/sh
# Magisk模块安装脚本

ui_print "******************************"
ui_print "SOTER Key修复模块"
ui_print "版本: 1.0"
ui_print "作者: 小黄泊"
ui_print "******************************"

# 设置权限
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/service.sh 0 0 0755
set_perm $MODPATH/fix_soter_key.sh 0 0 0755