#!/bin/sh
set -e

### Credit to the Authors at https://rentry.org/CFWGuides
### Script created by Fraxalotl
### Mod by huangqian8
### Mod by gzk_47
### Mod by menshiyun

# -------------------------------------------

### GitHub API Headers
API_AUTH="Authorization: Bearer $GITHUB_TOKEN"
API_VER="X-GitHub-Api-Version: 2022-11-28"

# -------------------------------------------

### Create a new folder for storing files
if [ -d SwitchSD ]; then
  rm -rf SwitchSD
fi
if [ -e description.txt ]; then
  rm -rf description.txt
fi
mkdir -p ./SwitchSD
mkdir -p ./SwitchSD/atmosphere/config
mkdir -p ./SwitchSD/atmosphere/hosts
mkdir -p ./SwitchSD/bootloader/ini
mkdir -p ./SwitchSD/emuiibo/overlay
cd SwitchSD

# -------------------------------------------

cat >> ../description.txt << ENDOFFILE
大气层核心套件：
 
ENDOFFILE

### Fetch latest atmosphere from https://github.com/Atmosphere-NX/Atmosphere/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*atmosphere[^"]*.zip' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o atmosphere.zip
if [ $? -ne 0 ]; then
    echo "atmosphere download\033[31m failed\033[0m."
else
    echo "atmosphere download\033[32m success\033[0m."
    unzip -oq atmosphere.zip
    rm atmosphere.zip
fi

### Fetch latest fusee.bin from https://github.com/Atmosphere-NX/Atmosphere/releases/latest
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*fusee.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o fusee.bin
if [ $? -ne 0 ]; then
    echo "fusee download\033[31m failed\033[0m."
else
    echo "fusee download\033[32m success\033[0m."
    mkdir -p ./bootloader/payloads
    mv fusee.bin ./bootloader/payloads
fi

### Fetch Hekate + Nyx CHS from https://github.com/easyworld/hekate/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/easyworld/hekate/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*hekate_ctcaer[^"]*_sc.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o hekate.zip
if [ $? -ne 0 ]; then
    echo "Hekate + Nyx CHS download\033[31m failed\033[0m."
else
    echo "Hekate + Nyx CHS download\033[32m success\033[0m."
    unzip -oq hekate.zip
    rm hekate.zip
fi

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
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/sys-patch/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo sys-patch中文 {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-patch.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-patch.zip
if [ $? -ne 0 ]; then
    echo "sys-patch download\033[31m failed\033[0m."
else
    echo "sys-patch download\033[32m success\033[0m."
    unzip -oq sys-patch.zip
    rm sys-patch.zip
fi

### Fetch lastest theme-patches from https://github.com/exelix11/theme-patches
git clone https://github.com/exelix11/theme-patches
if [ $? -ne 0 ]; then
    echo "theme-patches download\033[31m failed\033[0m."
else
    echo "theme-patches download\033[32m success\033[0m."
    mkdir themes
    mv -f theme-patches/systemPatches ./themes/
    rm -rf theme-patches
fi

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

### Fetch Lockpick_RCM.bin
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/Lockpick_RCM.zip -o Lockpick_RCM.zip
#if [ $? -ne 0 ]; then
#    echo "Lockpick_RCM download\033[31m failed\033[0m."
#else
#    echo "Lockpick_RCM download\033[32m success\033[0m."
#    echo Lockpick_RCM v1.9.12 >> ../description.txt
#    unzip -oq Lockpick_RCM.zip
#    mv Lockpick_RCM.bin ./bootloader/payloads
#    rm Lockpick_RCM.zip
#fi

### Fetch lastest Lockpick_RCMDecScots from https://github.com/zdm65477730/Lockpick_RCMDecScots/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/Lockpick_RCMDecScots/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Lockpick_RCM {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Lockpick_RCM.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Lockpick_RCM.bin
if [ $? -ne 0 ]; then
    echo "Lockpick_RCM download\033[31m failed\033[0m."
else
    echo "Lockpick_RCM download\033[32m success\033[0m."
    mkdir -p ./bootloader/payloads
    mv Lockpick_RCM.bin ./bootloader/payloads
fi

### Fetch latest TegraExplorer.bin form https://github.com/zdm65477730/TegraExplorer/releases
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/TegraExplorer/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo TegraExplorer {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*TegraExplorer.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o TegraExplorer.bin
if [ $? -ne 0 ]; then
    echo "TegraExplorer download\033[31m failed\033[0m."
else
    echo "TegraExplorer download\033[32m success\033[0m."
    mv TegraExplorer.bin ./bootloader/payloads
fi

### Fetch latest TegraExplorer.bin form https://github.com/suchmememanyskill/TegraExplorer/releases/download/4.2.0/TegraExplorer.bin
#curl -sL https://github.com/suchmememanyskill/TegraExplorer/releases/download/4.2.0/TegraExplorer.bin -o TegraExplorer.bin
#if [ $? -ne 0 ]; then
#    echo "TegraExplorer download\033[31m failed\033[0m."
#else
#    echo "TegraExplorer download\033[32m success\033[0m."
#    echo TegraExplorer 4.2.0 >> ../description.txt
#    mv TegraExplorer.bin ./bootloader/payloads
#fi

### Fetch latest CommonProblemResolver.bin form https://github.com/zdm65477730/CommonProblemResolver/releases
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/CommonProblemResolver/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo CommonProblemResolver {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*CommonProblemResolver.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o CommonProblemResolver.bin
if [ $? -ne 0 ]; then
    echo "CommonProblemResolver download\033[31m failed\033[0m."
else
    echo "CommonProblemResolver download\033[32m success\033[0m."
    mv CommonProblemResolver.bin ./bootloader/payloads
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Switch_90DNS_tester.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Switch_90DNS_tester.nro
if [ $? -ne 0 ]; then
    echo "Switch_90DNS_tester download\033[31m failed\033[0m."
else
    echo "Switch_90DNS_tester download\033[32m success\033[0m."
    mkdir -p ./switch/Switch_90DNS_tester
    mv Switch_90DNS_tester.nro ./switch/Switch_90DNS_tester
fi

### Fetch lastest DBI from https://github.com/rashevskyv/dbi/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/DBIPatcher/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*DBI.[^"]*.zhcn.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o DBI.nro
if [ $? -ne 0 ]; then
    echo "DBI download\033[31m failed\033[0m."
else
    echo "DBI download\033[32m success\033[0m."
    mkdir -p ./switch/DBI
    mv DBI.nro ./switch/DBI
fi

### Fetch lastest Awoo Installer from https://github.com/dragonflylee/Awoo-Installer/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/dragonflylee/Awoo-Installer/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Awoo-Installer.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Awoo-Installer.zip
if [ $? -ne 0 ]; then
    echo "Awoo Installer download\033[31m failed\033[0m."
else
    echo "Awoo Installer download\033[32m success\033[0m."
    unzip -oq Awoo-Installer.zip
    rm Awoo-Installer.zip
fi

### Fetch lastest HekateToolbox from https://github.com/gzk47/Hekate-Toolbox/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Hekate-Toolbox/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo HekateToolbox中文 {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*HekateToolbox.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o HekateToolbox.nro
if [ $? -ne 0 ]; then
    echo "HekateToolbox download\033[31m failed\033[0m."
else
    echo "HekateToolbox download\033[32m success\033[0m."
    mkdir -p ./switch/HekateToolbox
    mv HekateToolbox.nro ./switch/HekateToolbox
fi

### Fetch lastest NX-Activity-Log from https://github.com/zdm65477730/NX-Activity-Log/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/NX-Activity-Log/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo NX-Activity-Log {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*NX-Activity-Log.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o NX-Activity-Log.nro
if [ $? -ne 0 ]; then
    echo "NX-Activity-Log download\033[31m failed\033[0m."
else
    echo "NX-Activity-Log download\033[32m success\033[0m."
    mkdir -p ./switch/NX-Activity-Log
    mv NX-Activity-Log.nro ./switch/NX-Activity-Log
fi

### Fetch lastest NXThemesInstaller from https://github.com/exelix11/SwitchThemeInjector/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/exelix11/SwitchThemeInjector/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo NXThemesInstaller {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*NXThemesInstaller.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o NXThemesInstaller.nro
if [ $? -ne 0 ]; then
    echo "NXThemesInstaller download\033[31m failed\033[0m."
else
    echo "NXThemesInstaller download\033[32m success\033[0m."
    mkdir -p ./switch/NXThemesInstaller
    mv NXThemesInstaller.nro ./switch/NXThemesInstaller
fi

### Fetch lastest JKSV from https://github.com/J-D-K/JKSV/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/J-D-K/JKSV/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo JKSV {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*JKSV.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o JKSV.nro
if [ $? -ne 0 ]; then
    echo "JKSV download\033[31m failed\033[0m."
else
    echo "JKSV download\033[32m success\033[0m."
    mkdir -p ./switch/JKSV
    mv JKSV.nro ./switch/JKSV
fi

### Write webdav.json in /config/JKSV/webdav.json
mkdir -p ./config/JKSV
cat > ./config/JKSV/webdav.json << ENDOFFILE
{
  "origin": "示例：https://dav.jianguoyun.com",
  "basepath": "示例：dav/switch",
  "username": "示例：gzk_47@qq.com",
  "password": "示例：agc6yix8mvvjs8xz47"
}
ENDOFFILE

### Fetch lastest tencent-switcher-gui from https://github.com/CaiMiao/Tencent-switcher-GUI/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/CaiMiao/Tencent-switcher-GUI/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo tencent-switcher-gui {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*tencent-switcher-gui.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o tencent-switcher-gui.nro
if [ $? -ne 0 ]; then
    echo "tencent-switcher-gui download\033[31m failed\033[0m."
else
    echo "tencent-switcher-gui download\033[32m success\033[0m."
    mkdir -p ./switch/tencent-switcher-gui
    mv tencent-switcher-gui.nro ./switch/tencent-switcher-gui
fi

### Fetch lastest aio-switch-updater from https://github.com/HamletDuFromage/aio-switch-updater/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/HamletDuFromage/aio-switch-updater/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo aio-switch-updater {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*aio-switch-updater.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o aio-switch-updater.zip
if [ $? -ne 0 ]; then
    echo "aio-switch-updater download\033[31m failed\033[0m."
else
    echo "aio-switch-updater download\033[32m success\033[0m."
    unzip -oq aio-switch-updater.zip
    rm aio-switch-updater.zip
fi

### Fetch lastest wiliwili from https://github.com/xfangfang/wiliwili/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/xfangfang/wiliwili/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo wiliwili {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*wiliwili-NintendoSwitch.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o wiliwili-NintendoSwitch.zip
if [ $? -ne 0 ]; then
    echo "wiliwili download\033[31m failed\033[0m."
else
    echo "wiliwili download\033[32m success\033[0m."
    unzip -oq wiliwili-NintendoSwitch.zip
    mkdir -p ./switch/wiliwili
    mv wiliwili/wiliwili.nro ./switch/wiliwili
    rm -rf wiliwili
    rm wiliwili-NintendoSwitch.zip
fi

### Fetch lastest SimpleModDownloader from https://github.com/PoloNX/SimpleModDownloader/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/PoloNX/SimpleModDownloader/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo SimpleModDownloader {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*SimpleModDownloader.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o SimpleModDownloader.nro
if [ $? -ne 0 ]; then
    echo "SimpleModDownloader download\033[31m failed\033[0m."
else
    echo "SimpleModDownloader download\033[32m success\033[0m."
    mkdir -p ./switch/SimpleModDownloader
    mv SimpleModDownloader.nro ./switch/SimpleModDownloader
fi

### Fetch lastest SimpleModManager from https://github.com/nadrino/SimpleModManager/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/nadrino/SimpleModManager/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo SimpleModManager {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*SimpleModManager.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o SimpleModManager.nro
if [ $? -ne 0 ]; then
    echo "SimpleModManager download\033[31m failed\033[0m."
else
    echo "SimpleModManager download\033[32m success\033[0m."
    mkdir -p ./switch/SimpleModManager
    mkdir -p ./mods
    mv SimpleModManager.nro ./switch/SimpleModManager
fi

### Fetch lastest Switchfin from https://github.com/dragonflylee/switchfin/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/dragonflylee/switchfin/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Switchfin {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Switchfin.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Switchfin.nro
if [ $? -ne 0 ]; then
    echo "Switchfin download\033[31m failed\033[0m."
else
    echo "Switchfin download\033[32m success\033[0m."
    mkdir -p ./switch/Switchfin
    mv Switchfin.nro ./switch/Switchfin
fi

### Fetch lastest Moonlight from https://github.com/XITRIX/Moonlight-Switch/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/XITRIX/Moonlight-Switch/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Moonlight {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Moonlight-Switch.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Moonlight-Switch.nro
if [ $? -ne 0 ]; then
    echo "Moonlight download\033[31m failed\033[0m."
else
    echo "Moonlight download\033[32m success\033[0m."
    mkdir -p ./switch/Moonlight-Switch
    mv Moonlight-Switch.nro ./switch/Moonlight-Switch
fi

### Fetch NX-Shell from https://github.com/zdm65477730/NX-Shell/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/NX-Shell/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo NX-Shell {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*NX-Shell.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o NX-Shell.nro
if [ $? -ne 0 ]; then
    echo "NX-Shell download\033[31m failed\033[0m."
else
    echo "NX-Shell download\033[32m success\033[0m."
    mkdir -p ./switch/NX-Shell
    mv NX-Shell.nro ./switch/NX-Shell
fi

### Fetch lastest hb-appstore from https://github.com/fortheusers/hb-appstore/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/fortheusers/hb-appstore/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo hb-appstore {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*appstore.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o appstore.nro
if [ $? -ne 0 ]; then
    echo "appstore download\033[31m failed\033[0m."
else
    echo "appstore download\033[32m success\033[0m."
    mkdir -p ./switch/appstore
    mv appstore.nro ./switch/appstore
fi

### Fetch lastest ReverseNX-Tool from https://github.com/masagrator/ReverseNX-Tool/releases
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/ReverseNX-Tool/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ReverseNX-Tool中文 {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ReverseNX-Tool.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ReverseNX-Tool.nro
if [ $? -ne 0 ]; then
    echo "ReverseNX-Tool download\033[31m failed\033[0m."
else
    echo "ReverseNX-Tool download\033[32m success\033[0m."
    mkdir -p ./switch/ReverseNX-Tool
    mv ReverseNX-Tool.nro ./switch/ReverseNX-Tool
fi

### Fetch lastest Goldleaf from https://github.com/XorTroll/Goldleaf/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/XorTroll/Goldleaf/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Goldleaf {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Goldleaf.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Goldleaf.nro
if [ $? -ne 0 ]; then
    echo "Goldleaf download\033[31m failed\033[0m."
else
    echo "Goldleaf download\033[32m success\033[0m."
    mkdir -p ./switch/Goldleaf
    mv Goldleaf.nro ./switch/Goldleaf
fi

### Fetch lastest Safe_Reboot_Shutdown from https://github.com/dezem/Safe_Reboot_Shutdown/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/dezem/Safe_Reboot_Shutdown/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Safe_Reboot_Shutdown {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Safe_Reboot_Shutdown.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Safe_Reboot_Shutdown.zip
if [ $? -ne 0 ]; then
    echo "Safe_Reboot_Shutdown download\033[31m failed\033[0m."
else
    echo "Safe_Reboot_Shutdown download\033[32m success\033[0m."
    unzip -oq Safe_Reboot_Shutdown.zip
    rm Safe_Reboot_Shutdown.zip
    mkdir -p ./switch/SafeReboot
    mv Safe_Reboot_Shutdown.nro ./switch/SafeReboot
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Firmware-Dumper.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Firmware-Dumper.zip
if [ $? -ne 0 ]; then
    echo "Firmware-Dumper download\033[31m failed\033[0m."
else
    echo "Firmware-Dumper download\033[32m success\033[0m."
    unzip -oq Firmware-Dumper.zip
    rm Firmware-Dumper.zip
fi

### Fetch lastest nxdumptool(nxdt_rw_poc) from https://github.com/DarkMatterCore/nxdumptool/releases/download/rewrite-prerelease/nxdt_rw_poc.nro
curl -sL https://github.com/DarkMatterCore/nxdumptool/releases/download/rewrite-prerelease/nxdt_rw_poc.nro -o nxdt_rw_poc.nro
if [ $? -ne 0 ]; then
    echo "nxdt_rw_poc download\033[31m failed\033[0m."
else
    echo "nxdt_rw_poc download\033[32m success\033[0m."
    echo nxdumptool-rewrite latest >> ../description.txt
    mkdir -p ./switch/nxdumptool
    mv nxdt_rw_poc.nro ./switch/nxdumptool
fi

### Fetch lastest Haku33 from https://github.com/StarDustCFW/Haku33/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/StarDustCFW/Haku33/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Haku33 {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Haku33.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Haku33.nro
if [ $? -ne 0 ]; then
    echo "Haku33 download\033[31m failed\033[0m."
else
    echo "Haku33 download\033[32m success\033[0m."
    mkdir -p ./switch/Haku33
    mv Haku33.nro ./switch/Haku33
fi

### Fetch linkalho
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/nro/linkalho.zip -o linkalho.zip
if [ $? -ne 0 ]; then
    echo "linkalho download\033[31m failed\033[0m."
else
    echo "linkalho download\033[32m success\033[0m."
    echo linkalho >> ../description.txt
    unzip -oq linkalho.zip
    rm linkalho.zip
fi

### Fetch lastest sphaira from https://github.com/ITotalJustice/sphaira/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/ITotalJustice/sphaira/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo sphaira {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sphaira[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sphaira.zip
if [ $? -ne 0 ]; then
    echo "sphaira download\033[31m failed\033[0m."
else
    echo "sphaira download\033[32m success\033[0m."
    unzip -oq sphaira.zip
    rm sphaira.zip
fi

### Write config.ini in /config/sphaira/config.ini
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

### Fetch lastest Checkpoint from https://github.com/BernardoGiordano/Checkpoint/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/BernardoGiordano/Checkpoint/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Checkpoint {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Checkpoint.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Checkpoint.nro
if [ $? -ne 0 ]; then
    echo "Checkpoint download\033[31m failed\033[0m."
else
    echo "Checkpoint download\033[32m success\033[0m."
    mkdir -p ./switch/Checkpoint
    mv Checkpoint.nro ./switch/Checkpoint
fi

## Fetch lastest Daybreak.nro from https://github.com/gzk47/Atmosphere/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Atmosphere/releases
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^daybreak.*\\.nro$")))).tag_name' \
  | xargs -I {} echo daybreak中文 {} >> ../description.txt
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^daybreak.*\\.nro$"))))' \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*daybreak[^"]*.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o daybreak.nro
if [ $? -ne 0 ]; then
    echo "daybreak download\033[31m failed\033[0m."
else
    echo "daybreak download\033[32m success\033[0m."
    mv daybreak.nro ./switch
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*nx-ovlloader[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o nx-ovlloader.zip
if [ $? -ne 0 ]; then
    echo "nx-ovlloader download\033[31m failed\033[0m."
else
    echo "nx-ovlloader download\033[32m success\033[0m."
    unzip -oq nx-ovlloader.zip
    rm nx-ovlloader.zip
fi

### Write config.ini in /config/tesla
cat > ./config/tesla/config.ini << ENDOFFILE
[tesla]
key_combo=L+DDOWN
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing config.ini in ./config/tesla\033[31m failed\033[0m."
else
    echo "Writing config.ini in ./config/tesla\033[32m success\033[0m."
fi

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
## Fetch latest Ultrahand-Overlay from https://github.com/ppkantorski/Ultrahand-Overlay
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/ppkantorski/Ultrahand-Overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Ultrahand-Overlay {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sdout[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sdout.zip
if [ $? -ne 0 ]; then
    echo "sdout download\033[31m failed\033[0m."
else
    echo "sdout download\033[32m success\033[0m."
    unzip -oq sdout.zip
    rm sdout.zip
fi

### Fetch Ultrahand-Overlay 自动转区
## Fetch latest Ultrahand-Overlay from https://github.com/gzk47/Ultrahand-Overlay
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Ultrahand-Overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Ultrahand-Overlay {} 国行自动转国际版 >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ovlmenu[^"]*.ovl"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ovlmenu.ovl
if [ $? -ne 0 ]; then
    echo "ovlmenu download\033[31m failed\033[0m."
else
    echo "ovlmenu download\033[32m success\033[0m."
    mv ovlmenu.ovl ./switch/.overlays
fi

### Write config.ini in /config/Ultrahand
cat > ./config/ultrahand/config.ini << ENDOFFILE
[ultrahand]
default_lang=zh-cn
key_combo=L+DDOWN
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing config.ini in ./config/ultrahand\033[31m failed\033[0m."
else
    echo "Writing config.ini in ./config/ultrahand\033[32m success\033[0m."
fi

### Write overlays.ini in /config/ultrahand
cat > ./config/ultrahand/overlays.ini << ENDOFFILE
[ovl-sysmodules.ovl]
priority=0
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=系统模块
custom_version=

[StatusMonitor.ovl]
priority=1
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=状态监视
custom_version=

[EdiZon.ovl]
priority=2
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=金手指
custom_version=

[ReverseNX-RT.ovl]
priority=3
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=底座模式
custom_version=

[sys-clk.ovl]
priority=4
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=系统超频
custom_version=

[emuiibo.ovl]
priority=5
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=Amiibo模拟
custom_version=

[ldn_mitm.ovl]
priority=6
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=联机插件
custom_version=

[QuickNTP.ovl]
priority=7
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=时间同步
custom_version=

[SysDVR.ovl]
priority=8
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=游戏串流
custom_version=

[FPSLocker.ovl]
priority=9
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=FPS锁定
custom_version=

[sys-patch-overlay.ovl]
priority=10
star=false
hide=false
use_launch_args=false
launch_args=
custom_name=系统补丁
custom_version=
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing overlays.ini in ./config/ultrahand\033[31m failed\033[0m."
else
    echo "Writing overlays.ini in ./config/ultrahand\033[32m success\033[0m."
fi

### Rename /config/Ultrahand to /config/ultrahand 主题文件夹目前只识别小写
#mv ./config/Ultrahand ./config/ultrahand

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ovl-sysmodules[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ovl-sysmodules.zip
if [ $? -ne 0 ]; then
    echo "ovl-sysmodules download\033[31m failed\033[0m."
else
    echo "ovl-sysmodules download\033[32m success\033[0m."
    unzip -oq ovl-sysmodules.zip
    rm ovl-sysmodules.zip
fi

### Write config.ini in /config/ovl-sysmodules/config.ini
cat > ./config/ovl-sysmodules/config.ini << ENDOFFILE
[ovl-sysmodules]
powerControlEnabled=1
wifiControlEnabled=1
sysmodulesControlEnabled=1
bootFileControlEnabled=1
hekateRestartControlEnabled=0
consoleRegionControlEnabled=1
ENDOFFILE

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
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/Status-Monitor-Overlay/releases
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^StatusMonitor.*\\.zip$")))).tag_name' \
  | xargs -I {} echo StatusMonitor {} >> ../description.txt
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^StatusMonitor.*\\.zip$"))))' \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*StatusMonitor[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o StatusMonitor.zip
if [ $? -ne 0 ]; then
    echo "StatusMonitor download\033[31m failed\033[0m."
else
    echo "StatusMonitor download\033[32m success\033[0m."
    unzip -oq StatusMonitor.zip
    rm StatusMonitor.zip
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*EdiZon[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o EdiZon.zip
if [ $? -ne 0 ]; then
    echo "EdiZon download\033[31m failed\033[0m."
else
    echo "EdiZon download\033[32m success\033[0m."
    unzip -oq EdiZon.zip
    rm EdiZon.zip
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ReverseNX-RT[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ReverseNX-RT.zip
if [ $? -ne 0 ]; then
    echo "ReverseNX-RT download\033[31m failed\033[0m."
else
    echo "ReverseNX-RT download\033[32m success\033[0m."
    unzip -oq ReverseNX-RT.zip
    rm ReverseNX-RT.zip
    rm -rf SaltySD/patches
fi

### Fetch lastest FPSLocker-Warehouse from https://github.com/masagrator/FPSLocker-Warehouse
git clone https://github.com/masagrator/FPSLocker-Warehouse
if [ $? -ne 0 ]; then
    echo "FPSLocker-Warehouse download\033[31m failed\033[0m."
else
    echo "FPSLocker-Warehouse download\033[32m success\033[0m."
    rm -rf SaltySD/plugins/FPSLocker/patches
    mv -f FPSLocker-Warehouse/SaltySD/plugins/FPSLocker/patches ./SaltySD/plugins/FPSLocker/
    rm -rf FPSLocker-Warehouse
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-clk[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-clk.zip
if [ $? -ne 0 ]; then
    echo "sys-clk download\033[31m failed\033[0m."
else
    echo "sys-clk download\033[32m success\033[0m."
    unzip -oq sys-clk.zip
    rm sys-clk.zip
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*emuiibo[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o emuiibo.zip
if [ $? -ne 0 ]; then
    echo "emuiibo download\033[31m failed\033[0m."
else
    echo "emuiibo download\033[32m success\033[0m."
    unzip -oq emuiibo.zip
    rm emuiibo.zip
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ldn_mitm[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ldn_mitm.zip
if [ $? -ne 0 ]; then
    echo "ldn_mitm download\033[31m failed\033[0m."
else
    echo "ldn_mitm download\033[32m success\033[0m."
    unzip -oq ldn_mitm.zip
    rm ldn_mitm.zip
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*QuickNTP[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o QuickNTP.zip
if [ $? -ne 0 ]; then
    echo "QuickNTP download\033[31m failed\033[0m."
else
    echo "QuickNTP download\033[32m success\033[0m."
    unzip -oq QuickNTP.zip
    rm QuickNTP.zip
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*SysDVR[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o SysDVR.zip
if [ $? -ne 0 ]; then
    echo "SysDVR download\033[31m failed\033[0m."
else
    echo "SysDVR download\033[32m success\033[0m."
    unzip -oq SysDVR.zip
    rm SysDVR.zip
fi

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
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*MissionControl[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o MissionControl.zip
if [ $? -ne 0 ]; then
    echo "MissionControl download\033[31m failed\033[0m."
else
    echo "MissionControl download\033[32m success\033[0m."
    unzip -oq MissionControl.zip
    rm MissionControl.zip
fi

## Fetch lastest sys-con from https://github.com/o0Zz/sys-con/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/o0Zz/sys-con/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo sys-con {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-con[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-con.zip
if [ $? -ne 0 ]; then
    echo "sys-con download\033[31m failed\033[0m."
else
    echo "sys-con download\033[32m success\033[0m."
    unzip -oq sys-con.zip
    rm sys-con.zip
fi

### Fetch lastest XY-tools from https://github.com/gzk47/XY-tools
git clone https://github.com/gzk47/XY-tools
if [ $? -ne 0 ]; then
    echo "XY-tools download\033[31m failed\033[0m."
else
    echo "XY-tools download\033[32m success\033[0m."
    echo 心悦工具箱 >> ../description.txt
    rm -rf XY-tools/.git
    mv -f XY-tools ./switch/.packages/XY-tools
    rm -rf XY-tools

fi

# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
极限超频替换包：（ 覆盖到【特斯拉版】心悦整合包上替换 ）
 
ENDOFFILE
###

### Fetch latest EOS-OC-Suite sys-clk.zip from https://github.com/halop/OC_Toolkit_SC_EOS/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo EOS{}-OC-Suite >> ../description.txt

# -------------------------------------------

### Rename hekate_ctcaer_*.bin to payload.bin
find . -name "*hekate_ctcaer*" -exec mv {} payload.bin \;
if [ $? -ne 0 ]; then
    echo "Rename hekate_ctcaer_*.bin to payload.bin\033[31m failed\033[0m."
else
    echo "Rename hekate_ctcaer_*.bin to payload.bin\033[32m success\033[0m."
fi

### Write hekate_ipl.ini in /bootloader/
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
    echo "Writing hekate_ipl.ini in ./bootloader/ directory\033[31m failed\033[0m."
else
    echo "Writing hekate_ipl.ini in ./bootloader/ directory\033[32m success\033[0m."
fi

### Write more.ini in /bootloader/ini/
#mkdir -p ./SwitchSD-Tesla/bootloader/ini
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
    echo "Writing more.ini in ./bootloader/ini/ directory\033[31m failed\033[0m."
else
    echo "Writing more.ini in ./bootloader/ini/ directory\033[32m success\033[0m."
fi

### write exosphere.ini in root of SD Card
cat > ./exosphere.ini << ENDOFFILE
[exosphere]
debugmode=1
debugmode_user=0
disable_user_exception_handlers=0
enable_user_pmu_access=0
blank_prodinfo_sysmmc=1
blank_prodinfo_emummc=1
allow_writing_to_cal_sysmmc=0
log_port=0
log_baud_rate=115200
log_inverted=0
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing exosphere.ini in root of SD card\033[31m failed\033[0m."
else
    echo "Writing exosphere.ini in root of SD card\033[32m success\033[0m."
fi

### Write default.txt in /atmosphere/hosts
cat > ./atmosphere/hosts/default.txt << ENDOFFILE
# Nintendo telemetry servers
127.0.0.1 receive-%.dg.srv.nintendo.net receive-%.er.srv.nintendo.net
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing default.txt in root of SD card\033[31m failed\033[0m."
else
    echo "Writing default.txt in root of SD card\033[32m success\033[0m."
fi

### Write emummc.txt & sysmmc.txt in /atmosphere/hosts
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
    echo "Writing emummc.txt and sysmmc.txt in ./atmosphere/hosts\033[31m failed\033[0m."
else
    echo "Writing emummc.txt and sysmmc.txt in ./atmosphere/hosts\033[32m success\033[0m."
fi

### Write boot.ini in root of SD Card
cat > ./boot.ini << ENDOFFILE
[payload]
file=payload.bin
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing boot.ini in root of SD card\033[31m failed\033[0m."
else
    echo "Writing boot.ini in root of SD card\033[32m success\033[0m."
fi

### Write override_config.ini in /atmosphere/config
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
    echo "Writing override_config.ini in ./atmosphere/config\033[31m failed\033[0m."
else
    echo "Writing override_config.ini in ./atmosphere/config\033[32m success\033[0m."
fi

### Write stratosphere.ini in /atmosphere/config
cat > ./atmosphere/config/stratosphere.ini << ENDOFFILE
[stratosphere]
nogc = 1
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing stratosphere.ini in ./atmosphere/config\033[31m failed\033[0m."
else
    echo "Writing stratosphere.ini in ./atmosphere/config\033[32m success\033[0m."
fi


### Write system_settings.ini in /atmosphere/config
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
    echo "Writing system_settings.ini in ./atmosphere/config\033[31m failed\033[0m."
else
    echo "Writing system_settings.ini in ./atmosphere/config\033[32m success\033[0m."
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

# -------------------------------------------

### Fetch logo
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/logo.zip -o logo.zip
if [ $? -ne 0 ]; then
    echo "logo download\033[31m failed\*3[0m."
else
    echo "logo download\033[32m success\033[0m."
    unzip -oq logo.zip
    rm logo.zip
fi

### Fetch boot-dat
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/boot-dat.zip -o boot-dat.zip
if [ $? -ne 0 ]; then
    echo "boot-dat download\033[31m failed\033[0m."
else
    echo "boot-dat download\033[32m success\033[0m."
    unzip -oq boot-dat.zip
    rm boot-dat.zip
fi

### Fetch lastest nx-hbmenu from https://github.com/gzk47/nx-hbmenu/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/nx-hbmenu/releases/latest
#cat latest.json \
#  | jq '.tag_name' \
#  | xargs -I {} echo nx-hbmenu中文 {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*hbmenu.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o hbmenu.nro
if [ $? -ne 0 ]; then
    echo "hbmenu download\033[31m failed\033[0m."
else
    echo "hbmenu download\033[32m success\033[0m."
    rm -f latest.json
fi

### Fetch readme
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/readme.txt -o readme.txt
if [ $? -ne 0 ]; then
    echo "readme download\033[31m failed\033[0m."
else
    echo "readme download\033[32m success\033[0m."
    mv readme.txt 【特斯拉版+Sys-patch】心悦大气层中文整合包v$(date +%Y%m%d).txt

fi

### Fetch gzk
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/gzk.zip -o gzk.zip
#if [ $? -ne 0 ]; then
#    echo "gzk download\033[31m failed\033[0m."
#else
#    echo "gzk download\033[32m success\033[0m."
##    echo gzk >> ../description.txt
#    unzip -oq gzk.zip
#    rm gzk.zip
#fi

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
echo "\033[32mYour Switch SD card is prepared!\033[0m"
