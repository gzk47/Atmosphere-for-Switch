#!/bin/sh
set -e

### Credit to the Authors at https://rentry.org/CFWGuides
### Script created by Fraxalotl
### Mod by huangqian8
### Mod by gzk_47

# -------------------------------------------

### GitHub API Headers
API_AUTH="Authorization: Bearer $GITHUB_TOKEN"
API_VER="X-GitHub-Api-Version: 2022-11-28"

# -------------------------------------------

### Create a new folder for storing files
if [ -d EOS-OC-Suite ]; then
  rm -rf EOS-OC-Suite
fi
if [ -e description.txt ]; then
  rm -rf description.txt
fi
mkdir -p ./EOS-OC-Suite
#mkdir -p ./EOS-OC-Suite/atmosphere/config
#mkdir -p ./EOS-OC-Suite/atmosphere/hosts
#mkdir -p ./EOS-OC-Suite/bootloader/ini
#mkdir -p ./EOS-OC-Suite/emuiibo/overlay
cd EOS-OC-Suite

# -------------------------------------------

cat >> ../description.txt << ENDOFFILE
大气层核心套件：
 
ENDOFFILE

### Fetch latest atmosphere from https://github.com/Atmosphere-NX/Atmosphere/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt


### Fetch Hekate + Nyx CHS from https://github.com/easyworld/hekate/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/easyworld/hekate/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt

### Fetch Sigpatches 
### from https://gbatemp.net/threads/sigpatches-for-atmosphere-hekate-fss0-fusee-package3.571543/
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/sigpatches.zip -o sigpatches.zip
#if [ $? -ne 0 ]; then
#    echo "sigpatches download\033[31m failed\033[0m."
#else
#    echo "sigpatches download\033[32m success\033[0m."
#    echo sigpatches >> ../description.txt
#    unzip -oq sigpatches.zip
#    rm sigpatches.zip
#fi

###
cat >> ../description.txt << ENDOFFILE
sigpatches
ENDOFFILE
###

### Fetch sys-patch from https://github.com/impeeza/sys-patch/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/impeeza/sys-patch/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
#curl -H "$API_AUTH" -sL https://api.github.com/repos/impeeza/sys-patch/releases/latest \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-patch.zip"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o sys-patch.zip
#if [ $? -ne 0 ]; then
#    echo "sys-patch download\033[31m failed\033[0m."
#else
#    echo "sys-patch download\033[32m success\033[0m."
#    unzip -oq sys-patch.zip
#    rm sys-patch.zip
#fi


# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
Hekate payloads 二次引导软件：
 
ENDOFFILE
###

#### Fetch latest Lockpick_RCM.bin from https://github.com/Decscots/Lockpick_RCM/releases/latest
#curl -H "$API_AUTH" -sL https://api.github.com/repos/Decscots/Lockpick_RCM/releases/latest \
#  | jq '.tag_name' \
#  | xargs -I {} echo Lockpick_RCM {} >> ../description.txt
#curl -H "$API_AUTH" -sL https://api.github.com/repos/Decscots/Lockpick_RCM/releases/latest \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*Lockpick_RCM.bin"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o Lockpick_RCM.bin
#if [ $? -ne 0 ]; then
#    echo "Lockpick_RCM download\033[31m failed\033[0m."
#else
#    echo "Lockpick_RCM download\033[32m success\033[0m."
#    mv Lockpick_RCM.bin ./bootloader/payloads
#fi

### Fetch lastest Lockpick_RCMDecScots from https://github.com/zdm65477730/Lockpick_RCMDecScots/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/Lockpick_RCMDecScots/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Lockpick_RCM {} >> ../description.txt

### Fetch latest TegraExplorer.bin form https://github.com/zdm65477730/TegraExplorer/releases
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/TegraExplorer/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo TegraExplorer {} >> ../description.txt


### Fetch latest CommonProblemResolver.bin form https://github.com/zdm65477730/CommonProblemResolver/releases
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/CommonProblemResolver/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo CommonProblemResolver {} >> ../description.txt

# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
相册nro软件：
 
ENDOFFILE
###

### Fetch lastest Switch_90DNS_tester from https://github.com/meganukebmp/Switch_90DNS_tester/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/meganukebmp/Switch_90DNS_tester/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Switch_90DNS_tester {} >> ../description.txt

### Fetch lastest DBI from https://github.com/rashevskyv/dbi/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/rashevskyv/dbi/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt

### Fetch lastest Awoo Installer from https://github.com/dragonflylee/Awoo-Installer/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/dragonflylee/Awoo-Installer/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt

### Fetch lastest HekateToolbox from https://github.com/gzk47/Hekate-Toolbox/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Hekate-Toolbox/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo HekateToolbox中文 {} >> ../description.txt

### Fetch lastest NX-Activity-Log from https://github.com/zdm65477730/NX-Activity-Log/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/NX-Activity-Log/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo NX-Activity-Log {} >> ../description.txt


### Fetch lastest NXThemesInstaller from https://github.com/exelix11/SwitchThemeInjector/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/exelix11/SwitchThemeInjector/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo NXThemesInstaller {} >> ../description.txt

### Fetch lastest JKSV from https://github.com/J-D-K/JKSV/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/J-D-K/JKSV/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo JKSV {} >> ../description.txt

### Fetch lastest tencent-switcher-gui from https://github.com/CaiMiao/Tencent-switcher-GUI/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/CaiMiao/Tencent-switcher-GUI/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo tencent-switcher-gui {} >> ../description.txt

### Fetch lastest aio-switch-updater from https://github.com/HamletDuFromage/aio-switch-updater/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/HamletDuFromage/aio-switch-updater/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo aio-switch-updater {} >> ../description.txt

### Fetch lastest wiliwili from https://github.com/xfangfang/wiliwili/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/xfangfang/wiliwili/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo wiliwili {} >> ../description.txt

### Fetch lastest SimpleModDownloader from https://github.com/PoloNX/SimpleModDownloader/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/PoloNX/SimpleModDownloader/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo SimpleModDownloader {} >> ../description.txt

### Fetch lastest SimpleModManager from https://github.com/nadrino/SimpleModManager/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/nadrino/SimpleModManager/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo SimpleModManager {} >> ../description.txt

### Fetch lastest Switchfin from https://github.com/dragonflylee/switchfin/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/dragonflylee/switchfin/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Switchfin {} >> ../description.txt

### Fetch lastest Moonlight from https://github.com/XITRIX/Moonlight-Switch/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/XITRIX/Moonlight-Switch/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Moonlight {} >> ../description.txt

### Fetch NX-Shell from https://github.com/zdm65477730/NX-Shell/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/NX-Shell/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo NX-Shell {} >> ../description.txt

### Fetch lastest hb-appstore from https://github.com/fortheusers/hb-appstore/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/fortheusers/hb-appstore/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo hb-appstore {} >> ../description.txt

### Fetch lastest ReverseNX-Tool from https://github.com/masagrator/ReverseNX-Tool/releases
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/ReverseNX-Tool/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ReverseNX-Tool中文 {} >> ../description.txt

### Fetch lastest Goldleaf from https://github.com/XorTroll/Goldleaf/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/XorTroll/Goldleaf/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Goldleaf {} >> ../description.txt

### Fetch lastest Safe_Reboot_Shutdown from https://github.com/dezem/Safe_Reboot_Shutdown/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/dezem/Safe_Reboot_Shutdown/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Safe_Reboot_Shutdown {} >> ../description.txt

### Fetch lastest Firmware-Dumper from https://github.com/mrdude2478/Switch-Firmware-Dumper/releases
#curl -H "$API_AUTH" -sL https://api.github.com/repos/mrdude2478/Switch-Firmware-Dumper/releases/latest \
#  | jq '.tag_name' \
#  | xargs -I {} echo Firmware-Dumper {} >> ../description.txt
#curl -H "$API_AUTH" -sL https://api.github.com/repos/mrdude2478/Switch-Firmware-Dumper/releases/latest \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*Firmware-Dumper.nro"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o Firmware-Dumper.nro
#if [ $? -ne 0 ]; then
#    echo "Firmware-Dumper download\033[31m failed\033[0m."
#else
#    echo "Firmware-Dumper download\033[32m success\033[0m."
#    mkdir -p ./switch/Firmware-Dumper
#    mv Firmware-Dumper.nro ./switch/Firmware-Dumper
#fi

### Fetch lastest Firmware-Dumper【Chinese lang】 from https://github.com/zdm65477730/Switch-Firmware-Dumper/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/Switch-Firmware-Dumper/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Firmware-Dumper {} >> ../description.txt

### Fetch lastest nxdumptool(nxdt_rw_poc) from https://github.com/DarkMatterCore/nxdumptool/releases/download/rewrite-prerelease/nxdt_rw_poc.nro
#curl -sL https://github.com/DarkMatterCore/nxdumptool/releases/download/rewrite-prerelease/nxdt_rw_poc.nro -o nxdt_rw_poc.nro
#if [ $? -ne 0 ]; then
#    echo "nxdt_rw_poc download\033[31m failed\033[0m."
#else
#    echo "nxdt_rw_poc download\033[32m success\033[0m."
#    echo nxdumptool-rewrite latest >> ../description.txt
#    mkdir -p ./switch/nxdumptool
#    mv nxdt_rw_poc.nro ./switch/nxdumptool
#fi

###
cat >> ../description.txt << ENDOFFILE
nxdumptool-rewrite latest
ENDOFFILE
###

### Fetch lastest Haku33 from https://github.com/StarDustCFW/Haku33/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/StarDustCFW/Haku33/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Haku33 {} >> ../description.txt

### Fetch linkalho
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/nro/linkalho.zip -o linkalho.zip
#if [ $? -ne 0 ]; then
#    echo "linkalho download\033[31m failed\033[0m."
#else
#    echo "linkalho download\033[32m success\033[0m."
#    echo linkalho >> ../description.txt
#    unzip -oq linkalho.zip
#    rm linkalho.zip
#fi

###
cat >> ../description.txt << ENDOFFILE
linkalho
ENDOFFILE
###

### Fetch lastest sphaira from https://github.com/ITotalJustice/sphaira/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/ITotalJustice/sphaira/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo sphaira {} >> ../description.txt

### Fetch lastest Checkpoint from https://github.com/BernardoGiordano/Checkpoint/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/BernardoGiordano/Checkpoint/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Checkpoint {} >> ../description.txt

# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
特斯拉中文版插件：（纯净版 没有特斯拉插件）
 
ENDOFFILE
###

### Fetch nx-ovlloader
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/nx-ovlloader.zip -o nx-ovlloader.zip
#if [ $? -ne 0 ]; then
#    echo "nx-ovlloader download\033[31m failed\033[0m."
#else
#    echo "nx-ovlloader download\033[32m success\033[0m."
#    unzip -oq nx-ovlloader.zip
#    rm nx-ovlloader.zip
#fi

## Fetch lastest nx-ovlloader from https://github.com/zdm65477730/nx-ovlloader/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/nx-ovlloader/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo nx-ovlloader {} >> ../description.txt

### Fetch Tesla-Menu
#curl -sL #https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/Tesla-Menu.zip -o Tesla-Menu.zip
#if [ $? -ne 0 ]; then
#    echo "Tesla-Menu download\033[31m failed\033[0m."
#else
#    echo "Tesla-Menu download\033[32m success\033[0m."
#    unzip -oq Tesla-Menu.zip
#    rm Tesla-Menu.zip
#fi

### Fetch lastest Tesla-Menu from https://github.com/zdm65477730/Tesla-Menu/releases/latest
#curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Tesla-Menu/releases/latest \
#  | jq '.tag_name' \
#  | xargs -I {} echo Tesla-Menu {} >> ../description.txt
#curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Tesla-Menu/releases/latest \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*Tesla-Menu[^"]*.zip"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o Tesla-Menu.zip
#if [ $? -ne 0 ]; then
#    echo "Tesla-Menu download\033[31m failed\033[0m."
#else
#    echo "Tesla-Menu download\033[32m success\033[0m."
#    unzip -oq Tesla-Menu.zip
#    rm Tesla-Menu.zip
#fi

### Write sort.cfg in /config/Tesla-Menu/sort.cfg
#cat > ./config/Tesla-Menu/sort.cfg << ENDOFFILE
#ovl-sysmodules
#StatusMonitor
#EdiZon
#ReverseNX-RT
#sys-clk
#emuiibo
#ldn_mitm
#QuickNTP
#SysDVR
#Fizeau
#Zing
#ENDOFFILE

### Fetch Ultrahand-Overlay
## Fetch latest Ultrahand-Overlay from https://github.com/zdm65477730/Ultrahand-Overlay
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/Ultrahand-Overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Ultrahand-Overlay {} >> ../description.txt

### Fetch ovl-sysmodules
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/ovl-sysmodules.zip -o ovl-sysmodules.zip
#if [ $? -ne 0 ]; then
#    echo "ovl-sysmodules download\033[31m failed\033[0m."
#else
#    echo "ovl-sysmodules download\033[32m success\033[0m."
#    unzip -oq ovl-sysmodules.zip
#    rm ovl-sysmodules.zip
#fi

## Fetch lastest ovl-sysmodules from https://github.com/zdm65477730/ovl-sysmodules/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/ovl-sysmodules/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ovl-sysmodules {} >> ../description.txt

### Fetch StatusMonitor
#curl -sL #https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/StatusMonitor.zip -o StatusMonitor.zip
#if [ $? -ne 0 ]; then
#    echo "StatusMonitor download\033[31m failed\033[0m."
#else
#    echo "StatusMonitor download\033[32m success\033[0m."
#    unzip -oq StatusMonitor.zip
#    rm StatusMonitor.zip
#fi

## Fetch lastest Status-Monitor-Overlay from https://github.com/zdm65477730/Status-Monitor-Overlay/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/Status-Monitor-Overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo StatusMonitor {} >> ../description.txt

### Fetch EdiZon
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/EdiZon.zip -o EdiZon.zip
#if [ $? -ne 0 ]; then
#    echo "EdiZon download\033[31m failed\033[0m."
#else
#    echo "EdiZon download\033[32m success\033[0m."
#    unzip -oq EdiZon.zip
#    rm EdiZon.zip
#fi

## Fetch lastest EdiZon-Overlay from https://github.com/zdm65477730/EdiZon-Overlay/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/EdiZon-Overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo EdiZon {} >> ../description.txt

### Fetch ReverseNX-RT
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/ReverseNX-RT.zip -o ReverseNX-RT.zip
#if [ $? -ne 0 ]; then
#    echo "ReverseNX-RT download\033[31m failed\033[0m."
#else
#    echo "ReverseNX-RT download\033[32m success\033[0m."
#    unzip -oq ReverseNX-RT.zip
#    rm ReverseNX-RT.zip
#    rm -rf SaltySD/patches
#fi

## Fetch lastest ReverseNX-RT from https://github.com/zdm65477730/ReverseNX-RT/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/ReverseNX-RT/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ReverseNX-RT {} >> ../description.txt

### Fetch sys-clk
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/sys-clk.zip -o sys-clk.zip
#if [ $? -ne 0 ]; then
#    echo "sys-clk download\033[31m failed\033[0m."
#else
#    echo "sys-clk download\033[32m success\033[0m."
#    unzip -oq sys-clk.zip
#    rm sys-clk.zip
#fi

## Fetch lastest sys-clk from https://github.com/zdm65477730/sys-clk/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/sys-clk/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo sys-clk {} >> ../description.txt

### Fetch emuiibo
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/emuiibo.zip -o emuiibo.zip
#if [ $? -ne 0 ]; then
#    echo "emuiibo download\033[31m failed\033[0m."
#else
#    echo "emuiibo download\033[32m success\033[0m."
#    unzip -oq emuiibo.zip
#    rm emuiibo.zip
#fi

## Fetch lastest emuiibo from https://github.com/zdm65477730/emuiibo/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/emuiibo/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo emuiibo {} >> ../description.txt

### Fetch ldn_mitm
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/ldn_mitm.zip -o ldn_mitm.zip
#if [ $? -ne 0 ]; then
#    echo "ldn_mitm download\033[31m failed\033[0m."
#else
#    echo "ldn_mitm download\033[32m success\033[0m."
#    unzip -oq ldn_mitm.zip
#    rm ldn_mitm.zip
#fi

## Fetch lastest ldn_mitm from https://github.com/zdm65477730/ldn_mitm/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/ldn_mitm/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ldn_mitm {} >> ../description.txt

### Fetch QuickNTP
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/QuickNTP.zip -o QuickNTP.zip
#if [ $? -ne 0 ]; then
#    echo "QuickNTP download\033[31m failed\033[0m."
#else
#    echo "QuickNTP download\033[32m success\033[0m."
#    unzip -oq QuickNTP.zip
#    rm QuickNTP.zip
#fi

## Fetch lastest QuickNTP from https://github.com/zdm65477730/QuickNTP/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/QuickNTP/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo QuickNTP {} >> ../description.txt

### sysDvr
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/SysDVR.zip -o SysDVR.zip
#if [ $? -ne 0 ]; then
#    echo "SysDVR download\033[31m failed\033[0m."
#else
#    echo "SysDVR download\033[32m success\033[0m."
#    unzip -oq SysDVR.zip
#    rm SysDVR.zip
#fi

## Fetch lastest sysdvr-overlay from https://github.com/zdm65477730/sysdvr-overlay/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/sysdvr-overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo SysDVR {} >> ../description.txt

#### Fetch Fizeau
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/Fizeau.zip -o Fizeau.zip
#if [ $? -ne 0 ]; then
#    echo "Fizeau download\033[31m failed\033[0m."
#else
#    echo "Fizeau download\033[32m success\033[0m."
#    unzip -oq Fizeau.zip
#    rm Fizeau.zip
#fi

#### Fetch Zing
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/Zing.zip -o Zing.zip
#if [ $? -ne 0 ]; then
#    echo "Zing download\033[31m failed\033[0m."
#else
#    echo "Zing download\033[32m success\033[0m."
#    unzip -oq Zing.zip
#    rm Zing.zip
#fi

#### Fetch sys-tune
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/sys-tune.zip -o sys-tune.zip
#if [ $? -ne 0 ]; then
#    echo "sys-tune download\033[31m failed\033[0m."
#else
#    echo "sys-tune download\033[32m success\033[0m."
#    unzip -oq sys-tune.zip
#    rm sys-tune.zip
#fi

###
#cat >> ../description.txt << ENDOFFILE

#nx-ovlloader
#Tesla-Menu
#ovl-sysmodules
#StatusMonitor
#EdiZon
#ReverseNX-RT
#sys-clk
#emuiibo
#ldn_mitm
#QuickNTP
#SysDVR

#ENDOFFILE
###

### Fetch MissionControl from https://github.com//ndeadly/MissionControl/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/ndeadly/MissionControl/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo MissionControl {} >> ../description.txt

## Fetch lastest sys-con from https://github.com/o0Zz/sys-con/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/o0Zz/sys-con/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo sys-con {} >> ../description.txt

# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
极限超频替换包：（ 覆盖到【特斯拉版】心悦整合包上替换 ）
 
ENDOFFILE
###

### Write hekate_ipl.ini in /bootloader/
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
kip1patch=nosigchk
kip1=atmosphere/kips/loader.kip
logopath=bootloader/bootlogo.bmp
icon=bootloader/res/sysnand.bmp
id=cfw-sys
{大气层-真实系统}

[CFW-EMUNAND]
emummcforce=1
pkg3=atmosphere/package3
kip1patch=nosigchk
kip1=atmosphere/kips/loader.kip
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
    echo "Writing hekate_ipl.ini in ./bootloader/ directory\033[31m failed\033[0m."
else
    echo "Writing hekate_ipl.ini in ./bootloader/ directory\033[32m success\033[0m."
fi

### Fetch latest EOS-OC-Suite sys-clk.zip from https://github.com/halop/OC_Toolkit_SC_EOS/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo EOS{}-OC-Suite >> ../description.txt
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-clk[^"]*.zip' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-clk.zip
if [ $? -ne 0 ]; then
    echo "sys-clk download\033[31m failed\033[0m."
else
    echo "sys-clk download\033[32m success\033[0m."
    unzip -oq sys-clk.zip
    rm sys-clk.zip
    mv ./switch/.overlays/sys-clk-overlay.ovl ./switch/.overlays/sys-clk.ovl
    mkdir -p ./switch/sys-clk
    mv ./switch/sys-clk-manager.nro ./switch/sys-clk/sys-clk.nro
fi

### Write toolbox.json in /atmosphere/contents/00FF0000636C6BFF
cat > ./atmosphere/contents/00FF0000636C6BFF/toolbox.json << ENDOFFILE
{
    "name": "EOS-OC-Suite",
    "tid": "00FF0000636C6BFF",
    "requires_reboot": true
}
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing toolbox.json in ./atmosphere/contents/00FF0000636C6BFF/ directory\033[31m failed\033[0m."
else
    echo "Writing toolbox.json in ./atmosphere/contents/00FF0000636C6BFF/ directory\033[32m success\033[0m."
fi

### Write config.ini in /config/sys-clk
cat > ./config/sys-clk/config.ini << ENDOFFILE
[values]
uncapped_clocks=1
; Defines how often sys-clk log temperatures, in milliseconds (set 0 to disable)
temp_log_interval_ms=0
; Defines how often sys-clk writes to the CSV, in milliseconds (set 0 to disable)
csv_write_interval_ms=0

; Example #1: BOTW
; Overclock CPU when docked
; Overclock MEM to docked clocks when handheld
;[01007EF00011E000]
;docked_cpu=1224
;handheld_mem=1600

; Example #2: Picross
; Underclock to save battery
;[0100BA0003EEA000]
;handheld_cpu=816
;handheld_gpu=153
;handheld_mem=800
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing config.ini in ./config/sys-clk/ directory\033[31m failed\033[0m."
else
    echo "Writing config.ini in ./config/sys-clk/ directory\033[32m success\033[0m."
fi

### Fetch latest EOS-OC-Suite kip.zip from https://github.com/halop/OC_Toolkit_SC_EOS/releases/latest
#curl -H "$API_AUTH" -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest \
#  | jq '.name' \
#  | xargs -I {} echo {} >> ../description.txt
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*kip[^"]*.zip' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o kip.zip
if [ $? -ne 0 ]; then
    echo "kip download\033[31m failed\033[0m."
else
    echo "kip download\033[32m success\033[0m."
    unzip -oq kip.zip
    rm kip.zip
    mkdir -p ./atmosphere/kips
    mv loader.kip ./atmosphere/kips
fi

### Fetch latest EOS-OC-Suite OC.Toolkit.zip from https://github.com/halop/OC_Toolkit_SC_EOS/releases/latest
#curl -H "$API_AUTH" -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest \
#  | jq '.name' \
#  | xargs -I {} echo {} >> ../description.txt
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*OC.Toolkit.zip' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o OC.Toolkit.zip
if [ $? -ne 0 ]; then
    echo "OC.Toolkit download\033[31m failed\033[0m."
else
    echo "OC.Toolkit download\033[32m success\033[0m."
    unzip -oq OC.Toolkit.zip
    rm OC.Toolkit.zip
    mkdir -p ./switch/.packages
    mv "OC Toolkit" ./switch/.packages/"OC Toolkit"
fi

### Fetch latest sys-clk中文 from https://github.com/ppkantorski/sys-clk/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/ppkantorski/sys-clk/releases/latest
cat latest.json \
  | jq '.name' \
#  | xargs -I {} echo {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*lang[^"]*.zip' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o lang.zip
if [ $? -ne 0 ]; then
    echo "lang download\033[31m failed\033[0m."
else
    echo "lang download\033[32m success\033[0m."
    unzip -oq lang.zip -d lang
    # mkdir -p ./switch/.overlays/lang/sys-clk
    # mv lang/* ./switch/.overlays/lang/sys-clk
    # rm -rf lang.zip lang
    mkdir -p ./config/sys-clk/lang
    mv lang ./config/sys-clk
    rm -rf lang.zip
fi

### Fetch latest sys-clk中文 from https://github.com/ppkantorski/sys-clk/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/ppkantorski/sys-clk/releases/latest
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-clk-overlay.ovl"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-clk-overlay.ovl
if [ $? -ne 0 ]; then
    echo "sys-clk-overlay download\033[31m failed\033[0m."
else
    echo "sys-clk-overlay download\033[32m success\033[0m."

    mv sys-clk-overlay.ovl  ./switch/.overlays/sys-clk.ovl
fi


# -------------------------------------------

### Delete unneeded files
rm -f bootloader/res/icon_payload.bmp
rm -f bootloader/res/icon_switch.bmp
rm -f switch/haze.nro
rm -f switch/reboot_to_hekate.nro
rm -f switch/reboot_to_payload.nro
rm -rf mods
rm -f latest.json

### Delete boot2 files
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

# -------------------------------------------


### Fetch readme
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/readme.txt -o readme.txt
if [ $? -ne 0 ]; then
    echo "readme download\033[31m failed\033[0m."
else
    echo "readme download\033[32m success\033[0m."
    mv readme.txt EOS-OC-Suite极限超频替换包v$(date +%Y%m%d).txt

fi


# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
SwitchSD-Pure  为：纯净版
SwitchSD-Tesla 为：特斯拉版
SwitchSD       为：特斯拉版+sys-patch
EOS-OC-Suite   为：极限超频替换包
 
ENDOFFILE
###

# -------------------------------------------

echo ""
echo "\033[32mYour EOS-OC-Suite card is prepared!\033[0m"
