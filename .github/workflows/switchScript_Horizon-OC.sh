#!/bin/sh

set -e

# ------------------------------------------------------------------
# GitHub API Helpers & Common Functions
# Author: gzk_47
# ------------------------------------------------------------------

# GitHub API Headers (to avoid rate limiting)
API_AUTH="Authorization: Bearer ${GITHUB_TOKEN}"
API_VER="X-GitHub-Api-Version: 2026-03-10"

# Fetch latest releases JSON from GitHub API
fetch_api() {
    API_URL="https://api.github.com/repos/${REPO}/releases"
    curl -H "${API_AUTH}" -H "${API_VER}" -o latest.json -sL "${API_URL}"
}
fetch_api_latest() {
    API_URL="https://api.github.com/repos/${REPO}/releases/latest"
    curl -H "${API_AUTH}" -H "${API_VER}" -o latest.json -sL "${API_URL}"
}

# Parse version tag from JSON and write to description
get_version() {
    VERSION=$(jq -r 'first(.[]|select(.assets|any(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")))).tag_name' latest.json | sed 's/^v//')
    echo "${APP_NAME} ${VERSION}" >> ../description.txt
}
get_version_latest() {
    VERSION=$(jq -r '.tag_name' latest.json | sed 's/^v//')
    echo "${APP_NAME} ${VERSION}" >> ../description.txt
}

# Download matched asset from GitHub release
download_file() {
    DL_URL=$(jq -r 'first(.[]|select(.assets|any(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")))).assets[] | select(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")) | .browser_download_url' latest.json)
    curl -sL "${DL_URL}" -o "${APP_NAME}.${END_KEY}"
}
download_file_latest() {
    DL_URL=$(jq -r '.assets[] | select(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")) | .browser_download_url' latest.json)
    curl -sL "${DL_URL}" -o "${APP_NAME}.${END_KEY}"
}

# Check last command result and print status
check_result() {
    if [ $? -ne 0 ]; then
        echo "${APP_NAME} \033[31m❌\033[0m"
    else
        echo "${APP_NAME} \033[32m✅\033[0m"
    fi
}

# Unzip package and remove archive
unzip_and_clean() {
    unzip -oq "${APP_NAME}.${END_KEY}"
    rm -f "${APP_NAME}.${END_KEY}"
}

# Create directory and move file to /switch/[app]
move_to_switch_dir() {
    mkdir -p ./switch/"${APP_NAME}"
    mv "${APP_NAME}.${END_KEY}" ./switch/"${APP_NAME}"
}

# Create directory and move file to /bootloader/payloads
move_to_payloads_dir() {
    mkdir -p ./bootloader/payloads
    mv "${APP_NAME}.${END_KEY}" ./bootloader/payloads
}

# ------------------------------------------------------------------
# Working Directory Initialization
# ------------------------------------------------------------------

WORK_DIR="Horizon-OC"

if [ -d "${WORK_DIR}" ]; then
  rm -rf "${WORK_DIR}"
fi
if [ -e description.txt ]; then
  rm -rf description.txt
fi
mkdir -p "${WORK_DIR}"
# mkdir -p "${WORK_DIR}/atmosphere/config"
# mkdir -p "${WORK_DIR}/atmosphere/hosts"
# mkdir -p "${WORK_DIR}/bootloader/ini"
# mkdir -p "${WORK_DIR}/emuiibo/overlay"

cd "${WORK_DIR}"

# ------------------------------------------------------------------


cat >> ../description.txt << ENDOFFILE
大气层核心套件：
 
ENDOFFILE

# ==================================================================
APP_NAME="Atmosphere"
REPO="gzk47/Atmosphere" MATCH_KEY="atmosphere" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Hekate"
REPO="easyworld/hekate" MATCH_KEY="_sc" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Sys-patch"
REPO="gzk47/sys-patch" MATCH_KEY="sys-patch" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# rm -rf switch/.overlays

# ------------------------------------------------------------------

cat >> ../description.txt << ENDOFFILE
 
------------------------------------------------------------------
 
Hekate payloads 二次引导软件：
 
ENDOFFILE

# ==================================================================
APP_NAME="Lockpick_RCM"
REPO="impeeza/Lockpick_RCMDecScots" MATCH_KEY="Lockpick_RCM" END_KEY="bin"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_payloads_dir

# ==================================================================
APP_NAME="TegraExplorer"
REPO="zdm65477730/TegraExplorer" MATCH_KEY="TegraExplorer" END_KEY="bin"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_payloads_dir

# ==================================================================
APP_NAME="CommonProblemResolver"
REPO="zdm65477730/CommonProblemResolver" MATCH_KEY="CommonProblemResolver" END_KEY="bin"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_payloads_dir

# ------------------------------------------------------------------

cat >> ../description.txt << ENDOFFILE
 
------------------------------------------------------------------
 
相册nro软件：
 
ENDOFFILE

# ==================================================================
APP_NAME="Switch_90DNS_tester"
REPO="gzk47/Switch_90DNS_tester" MATCH_KEY="Switch_90DNS_tester" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="DBI"
REPO="gzk47/DBI" MATCH_KEY="DBI" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Awoo-Installer"
REPO="Huntereb/Awoo-Installer" MATCH_KEY="Awoo-Installer" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="HekateToolbox"
REPO="gzk47/Hekate-Toolbox" MATCH_KEY="HekateToolbox" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="NX-Activity-Log"
REPO="zdm65477730/NX-Activity-Log" MATCH_KEY="NX-Activity-Log" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="NXThemesInstaller"
REPO="exelix11/SwitchThemeInjector" MATCH_KEY="NXThemesInstaller" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="JKSV"
REPO="J-D-K/JKSV" MATCH_KEY="JKSV" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Tencent-switcher-gui"
REPO="gzk47/Tencent-switcher-GUI" MATCH_KEY="tencent-switcher-gui" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Aio-switch-updater"
REPO="HamletDuFromage/aio-switch-updater" MATCH_KEY="aio-switch-updater" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Wiliwili"
REPO="gzk47/wiliwili" MATCH_KEY="wiliwili" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="SimpleModDownloader"
REPO="PoloNX/SimpleModDownloader" MATCH_KEY="SimpleModDownloader" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="SimpleModManager"
REPO="gzk47/SimpleModManager" MATCH_KEY="SimpleModManager" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Switchfin"
REPO="dragonflylee/Switchfin" MATCH_KEY="Switchfin" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Moonlight"
REPO="XITRIX/Moonlight-Switch" MATCH_KEY="Moonlight" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Appstore"
REPO="gzk47/hb-appstore" MATCH_KEY="appstore" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="ReverseNX-Tool"
REPO="gzk47/ReverseNX-Tool" MATCH_KEY="ReverseNX-Tool" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Goldleaf"
REPO="gzk47/Goldleaf" MATCH_KEY="Goldleaf" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Safe_Reboot_Shutdown"
REPO="gzk47/Safe_Reboot_Shutdown" MATCH_KEY="Safe_Reboot_Shutdown" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Haku33"
REPO="StarDustCFW/Haku33" MATCH_KEY="Haku33" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Linkalho"
REPO="gzk47/linkalho" MATCH_KEY="linkalho" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Checkpoint"
REPO="BernardoGiordano/Checkpoint" MATCH_KEY="Checkpoint" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Switch-time"
REPO="gzk47/switch-time" MATCH_KEY="switch-time" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Ftpd"
REPO="gzk47/ftpd" MATCH_KEY="ftpd" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="nxdumptool"
REPO="DarkMatterCore/nxdumptool" MATCH_KEY="nxdt_rw_poc" END_KEY="nro"
# ==================================================================
#API_URL="https://github.com/${REPO}/releases/download/rewrite-prerelease/${MATCH_KEY}.${END_KEY}"
#curl -sL "${API_URL}" -o "${APP_NAME}.${END_KEY}"
echo "nxdumptool-rewrite latest" >> ../description.txt

# ==================================================================
APP_NAME="daybreak"
REPO="gzk47/Atmosphere" MATCH_KEY="daybreak" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result

# mkdir -p ./switch
# mv "${APP_NAME}.${END_KEY}" ./switch

# ==================================================================
APP_NAME="sphaira"
REPO="gzk47/sphaira" MATCH_KEY="sphaira" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="hbmenu"
REPO="gzk47/nx-hbmenu" MATCH_KEY="hbmenu" END_KEY="nro"
# ==================================================================
fetch_api; get_version
# download_file; check_result

# ==================================================================
APP_NAME="hbl"
REPO="gzk47/nx-hbloader" MATCH_KEY="hbl" END_KEY="nsp"
# ==================================================================
fetch_api; get_version
# download_file; check_result

# mv "${APP_NAME}.${END_KEY}" ./atmosphere

# ------------------------------------------------------------------

cat >> ../description.txt << ENDOFFILE
 
------------------------------------------------------------------
 
特斯拉中文版插件：（纯净版 没有特斯拉插件）
 
ENDOFFILE

# ==================================================================
APP_NAME="Ultrahand-Overlay"
REPO="ppkantorski/Ultrahand-Overlay" MATCH_KEY="sdout" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="ovlmenu"
REPO="gzk47/Ultrahand-Overlay" MATCH_KEY="ovlmenu" END_KEY="ovl"
# ==================================================================
fetch_api; get_version

# ------------------------------------------------------------------
# Write config.ini in /config/Ultrahand
# ------------------------------------------------------------------
mkdir -p ./config/ultrahand
cat > ./config/ultrahand/config.ini << ENDOFFILE
[ultrahand]
default_lang=zh-cn
key_combo=L+DDOWN
hide_hidden=true
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing config.ini in ./config/ultrahand\033[31m failed\033[0m."
else
    echo "Writing config.ini in ./config/ultrahand\033[32m success\033[0m."
fi

# ------------------------------------------------------------------
# Write overlays.ini in /config/ultrahand
# ------------------------------------------------------------------
mkdir -p ./config/ultrahand
cat > ./config/ultrahand/overlays.ini << ENDOFFILE
[ovl-sysmodules.ovl]
priority=0
custom_name=系统模块

[StatusMonitor.ovl]
priority=1
custom_name=状态监视
hide=true

[Horizon-OC-Monitor.ovl]
priority=1
custom_name=性能监视

[EdiZon.ovl]
priority=2
custom_name=金手指

[ovlEdiZon.ovl]
priority=2
custom_name=金手指-在线下载

[ReverseNX-RT.ovl]
priority=3
custom_name=底座模式

[sys-clk-overlay.ovl]
priority=4
custom_name=系统超频
hide=true

[horizon-oc-overlay.ovl]
priority=4
custom_name=极限超频

[emuiibo.ovl]
priority=5
custom_name=Amiibo模拟

[ldn_mitm.ovl]
priority=6
custom_name=联机插件

[QuickNTP.ovl]
priority=7
custom_name=时间同步

[SysDVR.ovl]
priority=8
custom_name=游戏串流

[FPSLocker.ovl]
priority=9
custom_name=FPS锁定

[sys-patch-overlay.ovl]
priority=10
custom_name=系统补丁
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing overlays.ini in ./config/ultrahand\033[31m failed\033[0m."
else
    echo "Writing overlays.ini in ./config/ultrahand\033[32m success\033[0m."
fi

# ==================================================================
APP_NAME="ovl-sysmodules"
REPO="zdm65477730/ovl-sysmodules" MATCH_KEY="ovl-sysmodules" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="StatusMonitor"
REPO="zdm65477730/Status-Monitor-Overlay" MATCH_KEY="StatusMonitor" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="EdiZon"
REPO="zdm65477730/EdiZon-Overlay" MATCH_KEY="EdiZon" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="ReverseNX-RT"
REPO="zdm65477730/ReverseNX-RT" MATCH_KEY="ReverseNX-RT" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Sys-clk"
REPO="gzk47/sys-clk" MATCH_KEY="sys-clk" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Emuiibo"
REPO="gzk47/emuiibo" MATCH_KEY="emuiibo" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Ldn_mitm"
REPO="zdm65477730/ldn_mitm" MATCH_KEY="ldn_mitm" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="QuickNTP"
REPO="zdm65477730/QuickNTP" MATCH_KEY="QuickNTP" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="SysDVR"
REPO="zdm65477730/sysdvr-overlay" MATCH_KEY="SysDVR" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="MissionControl"
REPO="ndeadly/MissionControl" MATCH_KEY="MissionControl" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Sys-con"
REPO="o0Zz/sys-con" MATCH_KEY="sys-con" END_KEY="zip"
# ==================================================================
fetch_api; get_version
# download_file; check_result; unzip_and_clean

# ------------------------------------------------------------------

cat >> ../description.txt << ENDOFFILE
 
------------------------------------------------------------------
 
心悦工具箱 
 
插件管理 - 便捷管理和切换Switch插件
Hekate启动选项 - 配置Hekate引导加载程序
相册启动 - 设置hbmenu和sphaira等启动器
金手指功能 - 在线下载和管理游戏金手指
录屏设置 - 调整录屏的比特率和帧率
DBI版本切换 - 在版本间切换
联网防护 - 屏蔽任天堂服务器和保护序列号
风扇增强 - 自定义风扇曲线控制温度
游戏模组 - 游戏模组解锁补丁
8G内存切换 - 硬改为8G内存的机器专用
国行自动转区 - 国行机器开机自动转国际版
系统内存设置 - 系统内存大小调整、内存缓冲区配置等
帧率补丁 - 应用游戏帧率解锁补丁
极限超频 - 优化CPU/GPU/内存性能
工具箱更新 - 一键更新至最新版本
 
ENDOFFILE

# ------------------------------------------------------------------

cat >> ../description.txt << ENDOFFILE
 
------------------------------------------------------------------
 
极限超频替换包：（ 覆盖到【特斯拉版】心悦整合包上替换 ）
 
ENDOFFILE

## ==================================================================
#APP_NAME="Horizon-OC"
#API_URL="https://api.github.com/repos/Horizon-OC/Horizon-OC/releases/latest"
## ==================================================================

#curl -H "${API_AUTH}" -o latest.json -sL "${API_URL}"
#HOC_VER=$(jq -r '.tag_name' latest.json | sed 's/^v//')

#RAW_URL="https://raw.githubusercontent.com/Horizon-OC/Horizon-OC/main/ams_ver.txt"
#AMS_VER=$(curl -sL "${RAW_URL}")

#echo "${APP_NAME} ${HOC_VER} ( for AMS ${AMS_VER} )" >> ../description.txt

#DL_URL=$(jq -r '.assets[] | select(.name|test("^dist.*\\.zip$")) | .browser_download_url' latest.json)
#curl -sL "${DL_URL}" -o ${APP_NAME}.zip

#if [ $? -ne 0 ]; then
#    echo "${APP_NAME} download\033[31m failed\033[0m."
#else
#    echo "${APP_NAME} download\033[32m success\033[0m."
#fi

#unzip -oq ${APP_NAME}.zip
#rm -f ${APP_NAME}.zip

# ==================================================================
APP_NAME="Horizon-OC"
REPO="Horizon-OC/Horizon-OC" MATCH_KEY="dist" END_KEY="zip"
# ==================================================================
API_URL="https://api.github.com/repos/${REPO}/releases"
curl -H "${API_AUTH}" -H "${API_VER}" -o latest.json -sL "${API_URL}"
HOC_VER=$(jq -r 'first(.[]|select(.assets|any(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")))).tag_name' latest.json | sed 's/^v//')

RAW_URL="https://raw.githubusercontent.com/${REPO}/main/ams_ver.txt"
AMS_VER=$(curl -sL "${RAW_URL}")

echo "${APP_NAME} ${HOC_VER} ( for AMS ${AMS_VER} )" >> ../description.txt

DL_URL=$(jq -r 'first(.[]|select(.assets|any(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")))).assets[] | select(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")) | .browser_download_url' latest.json)
curl -sL "${DL_URL}" -o "${APP_NAME}.${END_KEY}"

if [ $? -ne 0 ]; then
    echo "${APP_NAME} \033[31m❌\033[0m"
else
    echo "${APP_NAME} \033[32m✅\033[0m"
fi

unzip -oq "${APP_NAME}.${END_KEY}"
rm -f "${APP_NAME}.${END_KEY}"

# ------------------------------------------------------------------
# Write hekate_ipl.ini in /bootloader/
# ------------------------------------------------------------------
mkdir -p ./bootloader
cat > ./bootloader/hekate_ipl.ini << ENDOFFILE
[config]
autoboot=0
autoboot_list=0
bootwait=3
backlight=100
autohosoff=1
autonogc=1
updater2p=1

{心悦}

[CFW-SYSNAND]
emummc_force_disable=1
pkg3=atmosphere/package3
kip1=atmosphere/kips/hoc.kip
logopath=bootloader/bootlogo.bmp
icon=bootloader/res/sysnand.bmp
id=cfw-sys
{大气层-真实系统}

[CFW-EMUNAND]
emummcforce=1
pkg3=atmosphere/package3
kip1=atmosphere/kips/hoc.kip
logopath=bootloader/bootlogo.bmp
icon=bootloader/res/emunand.bmp
id=cfw-emu
{大气层-虚拟系统}

[OFW-SYSNAND]
emummc_force_disable=1
pkg3=atmosphere/package3
stock=1
icon=bootloader/res/switch.bmp
id=ofw-sys
{机身正版系统}

[CFW-AUTO]
payload=bootloader/payloads/fusee.bin
icon=bootloader/res/auto.bmp
{大气层-自动识别}
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing hekate_ipl.ini in ./bootloader/ directory \033[31m❌\033[0m"
else
    echo "Writing hekate_ipl.ini in ./bootloader/ directory \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Delete unneeded files
# ------------------------------------------------------------------
rm -f bootloader/res/icon_payload.bmp
rm -f bootloader/res/icon_switch.bmp
rm -f switch/haze.nro
rm -f switch/reboot_to_hekate.nro
rm -f switch/reboot_to_payload.nro
rm -rf mods
rm -f latest.json
# ------------------------------------------------------------------
# Delete boot2 files
# ------------------------------------------------------------------
rm -f atmosphere/contents/00FF0000A53BB665/flags/*.*
#00FF0000A53BB665--SysDVR
#rm -f atmosphere/contents/00FF0000636C6BFF/flags/*.*
#00FF0000636C6BFF--sys-clk
rm -f atmosphere/contents/0000000000534C56/flags/*.*
#0000000000534C56--SaltyNX
rm -f atmosphere/contents/010000000000bd00/flags/*.*
#010000000000bd00--MissionControl
rm -f atmosphere/contents/0100000000000F12/flags/*.*
#0100000000000f12--Fizeau
rm -f atmosphere/contents/0100000000000352/flags/*.*
#0100000000000352--emuiibo
rm -f atmosphere/contents/690000000000000D/flags/*.*
#690000000000000D--sys-con
rm -f atmosphere/contents/4200000000000010/flags/*.*
#4200000000000010--ldn_mitm

# ------------------------------------------------------------------
# Fetch readme
# ------------------------------------------------------------------
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/readme.txt -o readme.txt
if [ $? -ne 0 ]; then
    echo "readme \033[31m❌\033[0m"
else
    echo "readme \033[32m✅\033[0m"
    mv readme.txt "Horizon-OC ${HOC_VER} ( for AMS${AMS_VER} )极限超频替换包v$(date +%Y%m%d).txt"
fi

# ------------------------------------------------------------------

cat >> ../description.txt << ENDOFFILE
 
------------------------------------------------------------------
 
AMS-Pure       为：纯净版
AMS-Tesla      为：特斯拉版
Horizon-OC     为：极限超频替换包
 
ENDOFFILE

# ------------------------------------------------------------------

cat >> ../description.txt << ENDOFFILE

------------------------------------------------------------------

构建时间：$(date '+%Y%m%d %H:%M:%S')

ENDOFFILE

# ------------------------------------------------------------------

#cp -a ../description.txt ./软件详情.txt

echo ""
echo "\033[32m ${WORK_DIR} ready ✅ \033[0m"
