# SoterFixer
修复一加骁龙系解锁bl导致Soter key失败的问题
SOTER Key修复模块 - 一加通用版 酷安@小黄泊
本模块完全免费，倒卖可耻！！！！
本压缩包包含两个模块：
1.	Magisk/ - Magisk模块
2.	KernelSU/ - KernelSU模块
   
请根据您使用的root方案选择对应的模块安装：
Magisk用户：

⦁	在Magisk App中安装 Magisk/module.prop 目录或直接输入.zip文件

KernelSU用户：

⦁	在KernelSU App中安装 KernelSU/module.prop 目录或直接刷入.zip文件

模块功能：
⦁	开机后自动执行SOTER Key修复脚本

⦁	每次执行间隔5秒

⦁	无日志输出，静默运行

修复内容：

⦁	停止vendor.soter服务

⦁	清理com.tencent.soter.soterserver应用数据

⦁	重新启动vendor.soter服务

⦁	修复解锁bl导致SOTER Key假死的问题（可逆，卸载模块后无任何影响）
# 常见问题
注意⚠️⚠️，本模块需要配合模块烧录TEE（教程 [https://www.coolapk.com/feed/60393556 ]）才有效，注意烧录过程不可逆，烧录后再来刷这个模块就可以获得几乎完美的TEE，实现key状态全绿！😋

对于模块不生效的问题，这模块其实是概率有效，你手动执行一下模块.zip内的fix_soter_key.sh 脚本再试试，别重启，再看看成不成功，如果还不成功就再执行多试几次。
如果实在不成功问题就在于你没有按照这个教程 https://www.coolapk.com/feed/60393556 烧录TEE，先去烧录之后再来（注意烧录操作不可逆）
![Screenshot_2025-10-13-23-28-53-91_40dbc481ca5b738a325e5182fc08a331](https://github.com/user-attachments/assets/03d2af91-b4b0-4bbe-a422-363d34af9447)
