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

# 如何过春秋检测“TEE环境不可信”和duckdetector的sotercheck
春秋和duckdetector最近更新了soterkey检测，一加系解锁就会爆“TEE环境不可信”和“sotercheck”问题，可以通过降级攻击解决
需要用到的模块：

TEESimulator-RS：https://github.com/Enginex0/TEESimulator-RS

爱玩机工具箱（或者雹也可以）: https://github.com/aistra0528/Hail

SoterkeyFixer（本项目）

将soterkeyfixer和TEESimulator-RS模块安装好后，打开雹或者爱玩机工具箱-应用相关-应用管理-搜索“SoterService”[com.tencent.soter.soterserver]-冻结/解冻-直接冻结
无需重启，即可发现soterkey检测过了（图四）（图五），原理是就是降级攻击+服务屏蔽
```
原本：
App → Soterkey → TEE → 严格验证 ❌

现在：
App → Soterkey ❌（被冻）
↓ fallback
软件校验 / 默认值 → ✅
```
**这是“降级攻击 + 服务屏蔽”组合拳能绕过春秋/DuckDetector新版SoterKey检测的根本原因**（针对一加系解锁机，尤其是Android 16的OnePlus PJZ110等机型）。

### 1. 问题根源：为什么一加解锁就会爆“TEE环境不可信”+ Soter check失败？
- **Soter** 是腾讯自研的一套**基于TEE（Trusted Execution Environment）**的安全密钥框架（keystore + 生物识别），微信支付/银行类App大量依赖它做硬件级安全。
- 一加（OxygenOS/ColorOS）在**Bootloader解锁**后，硬件TEE的**attestation证书链**会被系统/谷歌/腾讯的**在线吊销列表（revocation list）**标记为**已吊销/不可信**。  
  → 图一 Network 部分明确显示：“This certificate chain matched 1 revoked/suspended entry.”  
  → 图一 Soter check 就会出现 `finalErr=4`、`signing=skipped`、`removeAskSkipped=false` 等错误。
- 春秋 Native check-Eros 3.1 和 DuckDetector **最近更新**专门加强了 **SoterKey 检测**，不再只是简单看 root/hook，还会主动调用 SoterService 做完整性校验 → 直接红字“System compromised” + “TEE 环境不可信”（图二）。

### 2. 模块+冻结为什么能瞬间通过？（核心原理）
你用的三板斧正好把 Soter 的检测路径**全部掐死或伪造**：

| 步骤 | 原来（失败） | 现在（成功） | 原理 |
|------|-------------|-------------|------|
| **TEESimulator-RS** | 真实 TEE 被吊销 | 模块在 **keystore2 ioctl** 层完全模拟 TEE，生成**假的正常证书链** | 让上层以为 TEE 还是“干净”的 |
| **SoterkeyFixer** | Soter key 损坏 | 专为一加 Snapdragon 写的修复模块（停止 vendor.soter 服务 + 补丁密钥） | 专门处理 OnePlus 解锁后 SoterKey 的兼容性问题 |
| **冻结 SoterService**<br>(com.tencent.soter.soterserver) | 服务正常运行 → 检测通过 | **直接冻结**（图三红圈位置） | 让检测工具**无法连接 Treble 服务** → 强制走**降级路径** |

- **“降级攻击”** 的本质就是：**让 Soter 服务不可达** → 检测逻辑直接**跳过**所有严格检查（图六）：
  1. 初始化与服务 → 跳过（coreType=0, trebleConnected=false）
  2. 生物能力 → 跳过（硬件无/未录入）
  3. 密钥准备 → 跳过（设备不支持 SOTER）
  4. 签名会话 → 跳过
  5. 清理 → 已执行（removeAskSkipped=true）

- 图四显示 **Soter check skipped because the Treble service was not reachable**，正是冻结生效后的标志。
- 图五显示“Normal” + “未发现高风险”，就是因为所有 Soter 步骤都变成了“跳过”，新版检测把这种状态判定为**安全**（设计上为了兼容老设备）。

### 3. 为什么无需重启就能生效？
- 冻结操作是**即时生效**的（LSPosed/KernelSU 层直接 kill + deny 服务）。
- TEESimulator-RS 和 SoterkeyFixer 是 **LSPosed/KernelSU 模块**，在 Zygote 注入，运行时就已经接管了 keystore/TEE 调用。

**总结一句话**：  
这不是在“修复”TEE，而是**用模块伪造一个干净的 TEE + 把真·SoterService 彻底屏蔽**，让春秋的检测工具**压根拿不到失败数据**，只能看到一堆“跳过”，于是判定为 Normal。

这就是典型的**服务降级 + 环境模拟**绕过方式，一加系目前最稳的解法（其他品牌可能不需要 SoterkeyFixer）。  
以后春秋再更新，只要冻结 + 这两个模块还在，基本就不会翻车了。

https://www.coolapk.com/feed/71065685
