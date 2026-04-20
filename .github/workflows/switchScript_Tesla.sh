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

WORK_DIR="AMS-Tesla"

if [ -d "${WORK_DIR}" ]; then
  rm -rf "${WORK_DIR}"
fi
if [ -e description.txt ]; then
  rm -rf description.txt
fi
mkdir -p "${WORK_DIR}"
mkdir -p "${WORK_DIR}/atmosphere/config"
mkdir -p "${WORK_DIR}/atmosphere/hosts"
mkdir -p "${WORK_DIR}/bootloader/ini"
mkdir -p "${WORK_DIR}/emuiibo/overlay"

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
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="fusee"
REPO="gzk47/Atmosphere" MATCH_KEY="fusee" END_KEY="bin"
# ==================================================================
fetch_api; # get_version
download_file; check_result; move_to_payloads_dir

# ==================================================================
APP_NAME="Hekate"
REPO="easyworld/hekate" MATCH_KEY="_sc" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Sys-patch"
REPO="gzk47/sys-patch" MATCH_KEY="sys-patch" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="theme-patches"
REPO="exelix11/theme-patches" MATCH_KEY="theme-patches" END_KEY="git"
# ==================================================================
API_URL="https://github.com/${REPO}"
git clone ${API_URL}
if [ $? -ne 0 ]; then
    echo "${APP_NAME} \033[31m❌\033[0m"
else
    echo "${APP_NAME} \033[32m✅\033[0m"
fi

mkdir themes
mv -f ${APP_NAME}/systemPatches ./themes/
rm -rf ${APP_NAME}

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
download_file; check_result; move_to_payloads_dir

# ==================================================================
APP_NAME="TegraExplorer"
REPO="zdm65477730/TegraExplorer" MATCH_KEY="TegraExplorer" END_KEY="bin"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_payloads_dir

# ==================================================================
APP_NAME="CommonProblemResolver"
REPO="zdm65477730/CommonProblemResolver" MATCH_KEY="CommonProblemResolver" END_KEY="bin"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_payloads_dir

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
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="DBI"
REPO="gzk47/DBI" MATCH_KEY="DBI" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="dbi"
REPO="rashevskyv/DBI" MATCH_KEY="dbi" END_KEY="config"
# ==================================================================
fetch_api; # get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Awoo-Installer"
REPO="Huntereb/Awoo-Installer" MATCH_KEY="Awoo-Installer" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="HekateToolbox"
REPO="gzk47/Hekate-Toolbox" MATCH_KEY="HekateToolbox" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="NX-Activity-Log"
REPO="zdm65477730/NX-Activity-Log" MATCH_KEY="NX-Activity-Log" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="NXThemesInstaller"
REPO="exelix11/SwitchThemeInjector" MATCH_KEY="NXThemesInstaller" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="JKSV"
REPO="J-D-K/JKSV" MATCH_KEY="JKSV" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ------------------------------------------------------------------
# Write webdav.json in /config/JKSV
# ------------------------------------------------------------------
mkdir -p ./config/JKSV
cat > ./config/JKSV/webdav.json << ENDOFFILE
{
  "origin": "示例：https://dav.jianguoyun.com",
  "basepath": "示例：dav/switch",
  "username": "示例：gzk_47@qq.com",
  "password": "示例：agc6yix8mvvjs8xz47"
}
ENDOFFILE

if [ $? -ne 0 ]; then
    echo "Writing webdav.json in ./config/JKSV \033[31m❌\033[0m"
else
    echo "Writing webdav.json in ./config/JKSV \033[32m✅\033[0m"
fi

# ==================================================================
APP_NAME="Tencent-switcher-gui"
REPO="gzk47/Tencent-switcher-GUI" MATCH_KEY="tencent-switcher-gui" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Aio-switch-updater"
REPO="HamletDuFromage/aio-switch-updater" MATCH_KEY="aio-switch-updater" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Wiliwili"
REPO="gzk47/wiliwili" MATCH_KEY="wiliwili" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="SimpleModDownloader"
REPO="PoloNX/SimpleModDownloader" MATCH_KEY="SimpleModDownloader" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="SimpleModManager"
REPO="gzk47/SimpleModManager" MATCH_KEY="SimpleModManager" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Switchfin"
REPO="dragonflylee/Switchfin" MATCH_KEY="Switchfin" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Moonlight"
REPO="XITRIX/Moonlight-Switch" MATCH_KEY="Moonlight" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Appstore"
REPO="gzk47/hb-appstore" MATCH_KEY="appstore" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="ReverseNX-Tool"
REPO="gzk47/ReverseNX-Tool" MATCH_KEY="ReverseNX-Tool" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Goldleaf"
REPO="gzk47/Goldleaf" MATCH_KEY="Goldleaf" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Safe_Reboot_Shutdown"
REPO="gzk47/Safe_Reboot_Shutdown" MATCH_KEY="Safe_Reboot_Shutdown" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Haku33"
REPO="StarDustCFW/Haku33" MATCH_KEY="Haku33" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Linkalho"
REPO="gzk47/linkalho" MATCH_KEY="linkalho" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Checkpoint"
REPO="BernardoGiordano/Checkpoint" MATCH_KEY="Checkpoint" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Switch-time"
REPO="gzk47/switch-time" MATCH_KEY="switch-time" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="Ftpd"
REPO="gzk47/ftpd" MATCH_KEY="ftpd" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ==================================================================
APP_NAME="nxdumptool"
REPO="DarkMatterCore/nxdumptool" MATCH_KEY="nxdt_rw_poc" END_KEY="nro"
# ==================================================================
API_URL="https://github.com/${REPO}/releases/download/rewrite-prerelease/${MATCH_KEY}.${END_KEY}"
curl -sL "${API_URL}" -o "${APP_NAME}.${END_KEY}"
echo "nxdumptool-rewrite latest" >> ../description.txt

if [ $? -ne 0 ]; then
    echo "${APP_NAME} \033[31m❌\033[0m"
else
    echo "${APP_NAME} \033[32m✅\033[0m"
fi

mkdir -p ./switch/${APP_NAME}
mv "${APP_NAME}.${END_KEY}" ./switch/${APP_NAME}

# ==================================================================
APP_NAME="daybreak"
REPO="gzk47/Atmosphere" MATCH_KEY="daybreak" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result

mkdir -p ./switch
mv "${APP_NAME}.${END_KEY}" ./switch

# ==================================================================
APP_NAME="sphaira"
REPO="gzk47/sphaira" MATCH_KEY="sphaira" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result; move_to_switch_dir

# ------------------------------------------------------------------
# Writie config.ini in ./config/sphaira
# ------------------------------------------------------------------
mkdir -p ./config/sphaira
cat > ./config/sphaira/config.ini << ENDOFFILE 
[paths]
last_path=/
[config]
theme=romfs:/themes/white_theme.ini
language=7
replace_hbmenu=0
install_emummc=1
ENDOFFILE

if [ $? -ne 0 ]; then
    echo "Writing config.ini in ./config/sphaira \033[31m❌\033[0m"
else
    echo "Writing config.ini in ./config/sphaira \033[32m✅\033[0m"
fi

# ==================================================================
APP_NAME="hbmenu"
REPO="gzk47/nx-hbmenu" MATCH_KEY="hbmenu" END_KEY="nro"
# ==================================================================
fetch_api; get_version
download_file; check_result

# ==================================================================
APP_NAME="hbl"
REPO="gzk47/nx-hbloader" MATCH_KEY="hbl" END_KEY="nsp"
# ==================================================================
fetch_api; get_version
download_file; check_result

mv "${APP_NAME}.${END_KEY}" ./atmosphere

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
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="ovlmenu"
REPO="gzk47/Ultrahand-Overlay" MATCH_KEY="ovlmenu" END_KEY="ovl"
# ==================================================================
fetch_api; get_version
download_file; check_result

mkdir -p ./switch/.overlays
mv "${APP_NAME}.${END_KEY}" ./switch/.overlays

# ------------------------------------------------------------------
# Write config.ini in /config/Ultrahand
# ------------------------------------------------------------------
mkdir -p ./config/ultrahand
cat > ./config/ultrahand/config.ini << ENDOFFILE
[ultrahand]
default_lang=zh-cn
key_combo=L+DDOWN
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing config.ini in ./config/ultrahand \033[31m❌\033[0m"
else
    echo "Writing config.ini in ./config/ultrahand \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Write overlays.ini in /config/ultrahand
# ------------------------------------------------------------------
cat > ./config/ultrahand/overlays.ini << ENDOFFILE
[ovl-sysmodules.ovl]
priority=0
custom_name=系统模块

[StatusMonitor.ovl]
priority=1
custom_name=状态监视

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
    echo "Writing overlays.ini in ./config/ultrahand \033[31m❌\033[0m"
else
    echo "Writing overlays.ini in ./config/ultrahand \033[32m✅\033[0m"
fi

# ==================================================================
APP_NAME="ovl-sysmodules"
REPO="zdm65477730/ovl-sysmodules" MATCH_KEY="ovl-sysmodules" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ------------------------------------------------------------------
# Write config.ini in /config/ovl-sysmodules/config.ini
# ------------------------------------------------------------------
cat > ./config/ovl-sysmodules/config.ini << ENDOFFILE
[ovl-sysmodules]
powerControlEnabled=1
wifiControlEnabled=1
sysmodulesControlEnabled=1
bootFileControlEnabled=1
hekateRestartControlEnabled=0
consoleRegionControlEnabled=1
ENDOFFILE

# ==================================================================
APP_NAME="StatusMonitor"
REPO="zdm65477730/Status-Monitor-Overlay" MATCH_KEY="StatusMonitor" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ------------------------------------------------------------------
# Write config.ini in ./config/status-monitor/
# ------------------------------------------------------------------
mkdir -p ./config/status-monitor
cat > ./config/status-monitor/config.ini << ENDOFFILE
[status-monitor]
key_combo=L+DDOWN
ENDOFFILE

# ==================================================================
APP_NAME="EdiZon"
REPO="zdm65477730/EdiZon-Overlay" MATCH_KEY="EdiZon" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="ReverseNX-RT"
REPO="zdm65477730/ReverseNX-RT" MATCH_KEY="ReverseNX-RT" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

rm -rf SaltySD/patches

# ==================================================================
APP_NAME="FPSLocker-Warehouse"
REPO="masagrator/FPSLocker-Warehouse" MATCH_KEY="FPSLocker-Warehouse" END_KEY="git"
# ==================================================================
API_URL="https://github.com/${REPO}"
git clone ${API_URL}
if [ $? -ne 0 ]; then
    echo "${APP_NAME} \033[31m❌\033[0m"
else
    echo "${APP_NAME} \033[32m✅\033[0m"
fi

rm -rf SaltySD/plugins/FPSLocker/patches
mv -f ${APP_NAME}/SaltySD/plugins/FPSLocker/patches ./SaltySD/plugins/FPSLocker/
rm -rf ${APP_NAME}

# ==================================================================
APP_NAME="Sys-clk"
REPO="gzk47/sys-clk" MATCH_KEY="sys-clk" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Emuiibo"
REPO="gzk47/emuiibo" MATCH_KEY="emuiibo" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Ldn_mitm"
REPO="zdm65477730/ldn_mitm" MATCH_KEY="ldn_mitm" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="QuickNTP"
REPO="zdm65477730/QuickNTP" MATCH_KEY="QuickNTP" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="SysDVR"
REPO="zdm65477730/sysdvr-overlay" MATCH_KEY="SysDVR" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="MissionControl"
REPO="ndeadly/MissionControl" MATCH_KEY="MissionControl" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

# ==================================================================
APP_NAME="Sys-con"
REPO="o0Zz/sys-con" MATCH_KEY="sys-con" END_KEY="zip"
# ==================================================================
fetch_api; get_version
download_file; check_result; unzip_and_clean

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

# ==================================================================
APP_NAME="XY-tools"
REPO="gzk47/XY-tools" MATCH_KEY="XY-tools" END_KEY="git"
# ==================================================================
API_URL="https://github.com/${REPO}"
git clone ${API_URL}
if [ $? -ne 0 ]; then
    echo "${APP_NAME} \033[31m❌\033[0m"
else
    echo "${APP_NAME} \033[32m✅\033[0m"
fi

rm -rf ${APP_NAME}/.git
mkdir -p ./switch/.packages
mv -f ${APP_NAME} ./switch/.packages/${APP_NAME}
rm -rf ${APP_NAME}

# ------------------------------------------------------------------

cat >> ../description.txt << ENDOFFILE
 
------------------------------------------------------------------
 
极限超频替换包：（ 覆盖到【特斯拉版】心悦整合包上替换 ）
 
ENDOFFILE

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

#DL_URL=$(jq -r 'first(.[]|select(.assets|any(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")))).assets[] | select(.name|test(".*'"${MATCH_KEY}"'.*[.]'"${END_KEY}"'$")) | .browser_download_url' latest.json)
#curl -sL "${DL_URL}" -o "${APP_NAME}.${END_KEY}"

#if [ $? -ne 0 ]; then
#    echo "${APP_NAME} \033[31m❌\033[0m"
#else
#    echo "${APP_NAME} \033[32m✅\033[0m"
#fi

#unzip -oq "${APP_NAME}.${END_KEY}"
#rm -f "${APP_NAME}.${END_KEY}"

# ------------------------------------------------------------------
# Rename hekate_ctcaer_*.bin to payload.bin
# ------------------------------------------------------------------
find . -name "*hekate_ctcaer*" -exec mv {} payload.bin \;
if [ $? -ne 0 ]; then
    echo "Rename hekate_ctcaer_*.bin to payload.bin \033[31m❌\033[0m"
else
    echo "Rename hekate_ctcaer_*.bin to payload.bin \033[32m✅\033[0m"
fi
# ------------------------------------------------------------------
# Write hekate_ipl.ini in /bootloader/
# ------------------------------------------------------------------
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
logopath=bootloader/bootlogo.bmp
icon=bootloader/res/sysnand.bmp
id=cfw-sys
{大气层-真实系统}

[CFW-EMUNAND]
emummcforce=1
pkg3=atmosphere/package3
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
# Write more.ini in /bootloader/ini/
# ------------------------------------------------------------------
cat > ./bootloader/ini/more.ini << ENDOFFILE
[SXOS]
payload=bootloader/payloads/sxos.bin
icon=bootloader/res/sxos.bmp
{}

[Lakka]
l4t=1
boot_prefixes=lakka/boot/
logopath=lakka/boot/splash.bmp
id=SWR-LAK
icon=bootloader/res/lakka.bmp
{}

[Ubuntu]
l4t=1
boot_prefixes=/switchroot/ubuntu/
uart_port=0
id=SWR-UBU
r2p_action=self
icon=bootloader/res/ubuntu.bmp
logopath=switchroot/ubuntu/bootlogo_ubuntu.bmp
{}
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing more.ini in ./bootloader/ini/ directory \033[31m❌\033[0m"
else
    echo "Writing more.ini in ./bootloader/ini/ directory \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# write exosphere.ini in root of SD Card
# ------------------------------------------------------------------
cat > ./exosphere.ini << ENDOFFILE
[exosphere]
debugmode=1
debugmode_user=0
disable_user_exception_handlers=0
enable_user_pmu_access=0
enable_mem_mode=0
blank_prodinfo_sysmmc=1
blank_prodinfo_emummc=1
allow_writing_to_cal_sysmmc=0
log_port=0
log_baud_rate=115200
log_inverted=0
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing exosphere.ini in root of SD card \033[31m❌\033[0m"
else
    echo "Writing exosphere.ini in root of SD card \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Write default.txt in /atmosphere/hosts
# ------------------------------------------------------------------
cat > ./atmosphere/hosts/default.txt << ENDOFFILE
# Nintendo telemetry servers
127.0.0.1 receive-%.dg.srv.nintendo.net receive-%.er.srv.nintendo.net
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing default.txt in root of SD card \033[31m❌\033[0m"
else
    echo "Writing default.txt in root of SD card \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Write emummc.txt & sysmmc.txt in /atmosphere/hosts
# ------------------------------------------------------------------
cat > ./atmosphere/hosts/emummc.txt << ENDOFFILE
# 90DNS
127.0.0.1 *nintendo.com
127.0.0.1 *nintendo.net
127.0.0.1 *nintendo.jp
127.0.0.1 *nintendo.co.jp
127.0.0.1 *nintendo.co.uk
127.0.0.1 *nintendo-europe.com
127.0.0.1 *nintendowifi.net
127.0.0.1 *nintendo.es
127.0.0.1 *nintendo.co.kr
127.0.0.1 *nintendo.tw
127.0.0.1 *nintendo.com.hk
127.0.0.1 *nintendo.com.au
127.0.0.1 *nintendo.co.nz
127.0.0.1 *nintendo.at
127.0.0.1 *nintendo.be
127.0.0.1 *nintendods.cz
127.0.0.1 *nintendo.dk
127.0.0.1 *nintendo.de
127.0.0.1 *nintendo.fi
127.0.0.1 *nintendo.fr
127.0.0.1 *nintendo.gr
127.0.0.1 *nintendo.hu
127.0.0.1 *nintendo.it
127.0.0.1 *nintendo.nl
127.0.0.1 *nintendo.no
127.0.0.1 *nintendo.pt
127.0.0.1 *nintendo.ru
127.0.0.1 *nintendo.co.za
127.0.0.1 *nintendo.se
127.0.0.1 *nintendo.ch
127.0.0.1 *nintendo.pl
127.0.0.1 *nintendoswitch.com
127.0.0.1 *nintendoswitch.com.cn
127.0.0.1 *nintendoswitch.cn
207.246.121.77 *conntest.nintendowifi.net
207.246.121.77 *ctest.cdn.nintendo.net
221.230.145.22 *ctest.cdn.n.nintendoswitch.cn
95.216.149.205 *conntest.nintendowifi.net
95.216.149.205 *ctest.cdn.nintendo.net
95.216.149.205 *90dns.test
69.25.139.140 *conntest.nintendowifi.net
69.25.139.140 *ctest.cdn.nintendo.net
69.25.139.140 *ctest.cdn.n.nintendoswitch.cn
ENDOFFILE

cp ./atmosphere/hosts/emummc.txt ./atmosphere/hosts/sysmmc.txt
if [ $? -ne 0 ]; then
    echo "Writing emummc.txt and sysmmc.txt in ./atmosphere/hosts \033[31m❌\033[0m"
else
    echo "Writing emummc.txt and sysmmc.txt in ./atmosphere/hosts \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Write boot.ini in root of SD Card
# ------------------------------------------------------------------
cat > ./boot.ini << ENDOFFILE
[payload]
file=payload.bin
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing boot.ini in root of SD card \033[31m❌\033[0m"
else
    echo "Writing boot.ini in root of SD card \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Write override_config.ini in /atmosphere/config
# ------------------------------------------------------------------
cat > ./atmosphere/config/override_config.ini << ENDOFFILE
[hbl_config]
program_id=010000000000100D
override_any_app=true
path=atmosphere/hbl.nsp
override_key=!R
override_any_app_key=R

[default_config]
override_key=!L
cheat_enable_key=!L
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing override_config.ini in ./atmosphere/config \033[31m❌\033[0m"
else
    echo "Writing override_config.ini in ./atmosphere/config \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Write stratosphere.ini in /atmosphere/config
# ------------------------------------------------------------------
cat > ./atmosphere/config/stratosphere.ini << ENDOFFILE
[stratosphere]
nogc = 1
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing stratosphere.ini in ./atmosphere/config \033[31m❌\033[0m"
else
    echo "Writing stratosphere.ini in ./atmosphere/config \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Write system_settings.ini in /atmosphere/config
# ------------------------------------------------------------------
cat > ./atmosphere/config/system_settings.ini << ENDOFFILE
[eupld]
upload_enabled = u8!0x0

[usb]
usb30_force_enabled = u8!0x1

[ro]
ease_nro_restriction = u8!0x1

[lm]
enable_sd_card_logging = u8!0x1
sd_card_log_output_directory = str!atmosphere/binlogs

[erpt]
disable_automatic_report_cleanup = u8!0x0

[atmosphere]
fatal_auto_reboot_interval = u64!0x0
power_menu_reboot_function = str!payload
dmnt_cheats_enabled_by_default = u8!0x0
dmnt_always_save_cheat_toggles = u8!0x0
enable_hbl_bis_write = u8!0x0
enable_hbl_cal_read = u8!0x0
fsmitm_redirect_saves_to_sd = u8!0x0
enable_deprecated_hid_mitm = u8!0x0
enable_am_debug_mode = u8!0x0
enable_dns_mitm = u8!0x1
add_defaults_to_dns_hosts = u8!0x1
enable_dns_mitm_debug_log = u8!0x0
enable_htc = u8!0x0
enable_log_manager = u8!0x0
enable_external_bluetooth_db = u8!0x1

[ns.notification]
enable_download_task_list = u8!0x0
enable_download_ticket = u8!0x0
enable_network_update = u8!0x0
enable_random_wait = u8!0x0
enable_request_on_cold_boot = u8!0x0
enable_send_rights_usage_status_request = u8!0x0
enable_sync_elicense_request = u8!0x0
enable_version_list = u8!0x0
retry_interval_min = u32!0x7FFFFFFF
retry_interval_max = u32!0x7FFFFFFF
version_list_waiting_limit_bias = u32!0x7FFFFFFF
version_list_waiting_limit_min = u32!0x7FFFFFFF

[hbloader]
applet_heap_size = u64!0x0
applet_heap_reservation_size = u64!0x8600000
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing system_settings.ini in ./atmosphere/config \033[31m❌\033[0m"
else
    echo "Writing system_settings.ini in ./atmosphere/config \033[32m✅\033[0m"
fi

# ------------------------------------------------------------------
# Delete unneeded files
# ------------------------------------------------------------------
rm -f bootloader/res/icon_payload.bmp
rm -f bootloader/res/icon_switch.bmp
# rm -f switch/haze.nro
rm -f switch/reboot_to_hekate.nro
rm -f switch/reboot_to_payload.nro
rm -rf mods
rm -f latest.json
# ------------------------------------------------------------------
# Delete boot2 files
# ------------------------------------------------------------------
rm -f atmosphere/contents/00FF0000A53BB665/flags/*.*
#00FF0000A53BB665--SysDVR
rm -f atmosphere/contents/00FF0000636C6BFF/flags/*.*
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
# Fetch logo
# ------------------------------------------------------------------
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/logo.zip -o logo.zip
if [ $? -ne 0 ]; then
    echo "logo \033[31m❌\033[0m"
else
    echo "logo \033[32m✅\033[0m"
    unzip -oq logo.zip
    rm logo.zip
fi

# ------------------------------------------------------------------
# Fetch boot-dat
# ------------------------------------------------------------------
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/boot-dat.zip -o boot-dat.zip
if [ $? -ne 0 ]; then
    echo "boot-dat \033[31m❌\033[0m"
else
    echo "boot-dat \033[32m✅\033[0m"
    unzip -oq boot-dat.zip
    rm boot-dat.zip
fi

# ------------------------------------------------------------------
# Fetch readme
# ------------------------------------------------------------------
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/readme.txt -o readme.txt
if [ $? -ne 0 ]; then
    echo "readme \033[31m❌\033[0m"
else
    echo "readme \033[32m✅\033[0m"
    mv readme.txt 【特斯拉版】心悦大气层中文整合包v$(date +%Y%m%d).txt
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

cp -a ../description.txt ./软件详情.txt

echo ""
echo "\033[32m ${WORK_DIR} ready ✅ \033[0m"
