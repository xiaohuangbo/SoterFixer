#!/system/bin/sh
echo "开始修复SOTER Key问题"
stop vendor.soter
sleep 3
pm clear com.tencent.soter.soterserver
start vendor.soter
sleep 5
getprop init.svc.vendor.soter
echo "修复完成，请开机后在拨号输入*#899＃选手动测试查看SOTER Key，若失败则多刷新几次"