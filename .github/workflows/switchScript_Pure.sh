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
if [ -d AMS-Pure ]; then
  rm -rf AMS-Pure
fi
if [ -e description.txt ]; then
  rm -rf description.txt
fi
mkdir -p ./AMS-Pure
mkdir -p ./AMS-Pure/atmosphere/config
mkdir -p ./AMS-Pure/atmosphere/hosts
mkdir -p ./AMS-Pure/bootloader/ini
# mkdir -p ./AMS-Pure/emuiibo/overlay
cd AMS-Pure

# -------------------------------------------

cat >> ../description.txt << ENDOFFILE
大气层核心套件：
 
ENDOFFILE

### Fetch latest atmosphere from https://github.com/Atmosphere-NX/Atmosphere/releases/latest
#curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest
#cat latest.json \
#  | jq '.name' \
#  | xargs -I {} echo {} >> ../description.txt
#cat latest.json \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*atmosphere[^"]*.zip' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o atmosphere.zip
#if [ $? -ne 0 ]; then
#    echo "atmosphere download\033[31m failed\033[0m."
#else
#    echo "atmosphere download\033[32m success\033[0m."
#    unzip -oq atmosphere.zip
#    rm atmosphere.zip
#fi

### Fetch latest atmosphere from https://github.com/Atmosphere-NX/Atmosphere/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Atmosphere/releases
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^atmosphere.*\\.zip$")))).name' \
  | xargs -I {} echo {} >> ../description.txt
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^atmosphere.*\\.zip$"))))' \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*atmosphere[^"]*.zip"' \
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
#cat latest.json \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*fusee.bin"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o fusee.bin
#if [ $? -ne 0 ]; then
#    echo "fusee download\033[31m failed\033[0m."
#else
#    echo "fusee download\033[32m success\033[0m."
#    mkdir -p ./bootloader/payloads
#    mv fusee.bin ./bootloader/payloads
#fi

### Fetch latest fusee.bin from https://github.com/gzk47/Atmosphere/releases/latest
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^fusee.*\\.bin$"))))' \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*fusee[^"]*.bin"' \
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

### Fetch sys-patch from https://github.com/impeeza/sys-patch/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/sys-patch/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo sys-patch {} >> ../description.txt
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
    rm -rf switch/.overlays
fi

### Fetch lastest theme-patches from https://github.com/exelix11/theme-patches
#git clone https://github.com/exelix11/theme-patches
#if [ $? -ne 0 ]; then
#    echo "theme-patches download\033[31m failed\033[0m."
#else
#    echo "theme-patches download\033[32m success\033[0m."
#    mkdir themes
#    mv -f theme-patches/systemPatches ./themes/
#    rm -rf theme-patches
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

### Fetch lastest Lockpick_RCMDecScots from https://github.com/impeeza/Lockpick_RCMDecScots/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/impeeza/Lockpick_RCMDecScots/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Lockpick_RCM {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Lockpick_RCM[^"]*.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Lockpick_RCM.bin
if [ $? -ne 0 ]; then
    echo "Lockpick_RCM download\033[31m failed\033[0m."
else
    echo "Lockpick_RCM download\033[32m success\033[0m."
	# unzip -oq Lockpick_RCM.zip
	# rm Lockpick_RCM.zip
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
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Switch_90DNS_tester/releases/latest
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
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/DBI/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*DBI[^"]*.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o DBI.nro
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/rashevskyv/DBI/releases/latest
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*dbi[^"]*.config"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o dbi.config
if [ $? -ne 0 ]; then
    echo "DBI download\033[31m failed\033[0m."
else
    echo "DBI download\033[32m success\033[0m."
    mkdir -p ./switch/DBI
    mv DBI.nro ./switch/DBI
    mv -f dbi.config ./switch/DBI/
fi

### Fetch lastest Awoo Installer from https://github.com/Huntereb/Awoo-Installer/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/Huntereb/Awoo-Installer/releases/latest
cat latest.json \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt

### Fetch lastest HekateToolbox from https://github.com/gzk47/Hekate-Toolbox/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Hekate-Toolbox/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo HekateToolbox {} >> ../description.txt
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

### Fetch lastest tencent-switcher-gui from https://github.com/gzk47/Tencent-switcher-GUI/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Tencent-switcher-GUI/releases/latest
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

### Fetch lastest wiliwili from https://github.com/xfangfang/wiliwili/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/wiliwili/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo wiliwili {} >> ../description.txt

### Fetch lastest SimpleModDownloader from https://github.com/PoloNX/SimpleModDownloader/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/PoloNX/SimpleModDownloader/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo SimpleModDownloader {} >> ../description.txt

### Fetch lastest SimpleModManager from https://github.com/nadrino/SimpleModManager/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/SimpleModManager/releases/latest
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

### Fetch lastest hb-appstore from https://github.com/fortheusers/hb-appstore/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/hb-appstore/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo hb-appstore {} >> ../description.txt

### Fetch lastest ReverseNX-Tool from https://github.com/masagrator/ReverseNX-Tool/releases
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/ReverseNX-Tool/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ReverseNX-Tool {} >> ../description.txt

### Fetch lastest Goldleaf from https://github.com/XorTroll/Goldleaf/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Goldleaf/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Goldleaf {} >> ../description.txt

### Fetch lastest Safe_Reboot_Shutdown from https://github.com/dezem/Safe_Reboot_Shutdown/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Safe_Reboot_Shutdown/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Safe_Reboot_Shutdown {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Safe_Reboot_Shutdown.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Safe_Reboot_Shutdown.nro
if [ $? -ne 0 ]; then
    echo "Safe_Reboot_Shutdown download\033[31m failed\033[0m."
else
    echo "Safe_Reboot_Shutdown download\033[32m success\033[0m."
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
#curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/Switch-Firmware-Dumper/releases/latest
#cat latest.json \
#  | jq '.tag_name' \
#  | xargs -I {} echo Firmware-Dumper {} >> ../description.txt
#cat latest.json \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*Firmware-Dumper.zip"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o Firmware-Dumper.zip
#if [ $? -ne 0 ]; then
#    echo "Firmware-Dumper download\033[31m failed\033[0m."
#else
#    echo "Firmware-Dumper download\033[32m success\033[0m."
#    unzip -oq Firmware-Dumper.zip
#    rm Firmware-Dumper.zip
#fi

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

### Fetch lastest linkalho from https://github.com/gzk47/linkalho/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/linkalho/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo linkalho {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*linkalho.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o linkalho.nro
if [ $? -ne 0 ]; then
    echo "linkalho download\033[31m failed\033[0m."
else
    echo "linkalho download\033[32m success\033[0m."
    mkdir -p ./switch/linkalho
    mv linkalho.nro ./switch/linkalho
fi

### Fetch lastest sphaira from https://github.com/ITotalJustice/sphaira/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/sphaira/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo sphaira {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sphaira[^"]*.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sphaira.nro
if [ $? -ne 0 ]; then
    echo "sphaira download\033[31m failed\033[0m."
else
    echo "sphaira download\033[32m success\033[0m."
    #unzip -oq sphaira.zip
    #rm sphaira.zip
	mkdir -p ./switch/sphaira
    mv sphaira.nro ./switch/sphaira
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
  | xargs -I {} echo daybreak {} >> ../description.txt
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

### Fetch lastest switch-time from https://github.com/gzk47/switch-time/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/switch-time/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo switch-time {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*switch-time.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o switch-time.nro
if [ $? -ne 0 ]; then
    echo "switch-time download\033[31m failed\033[0m."
else
    echo "switch-time download\033[32m success\033[0m."
    mkdir -p ./switch/switch-time
    mv switch-time.nro ./switch/switch-time
fi

## Fetch lastest ftpd.nro from https://github.com/gzk47/ftpd/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/ftpd/releases
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^ftpd.*\\.nro$")))).tag_name' \
  | xargs -I {} echo ftpd {} >> ../description.txt

### Fetch lastest nx-hbmenu from https://github.com/gzk47/nx-hbmenu/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/nx-hbmenu/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo hbmenu {} >> ../description.txt
cat latest.json \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*hbmenu.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o hbmenu.nro
if [ $? -ne 0 ]; then
    echo "hbmenu download\033[31m failed\033[0m."
else
    echo "hbmenu download\033[32m success\033[0m."
fi

## Fetch lastest hbl.nsp from https://github.com/gzk47/nx-hbloader/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/nx-hbloader/releases
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^hbl.*\\.nsp$")))).tag_name' \
  | xargs -I {} echo hbl {} >> ../description.txt
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^hbl.*\\.nsp$"))))' \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*hbl[^"]*.nsp"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o hbl.nsp
if [ $? -ne 0 ]; then
    echo "hbl download\033[31m failed\033[0m."
else
    echo "hbl download\033[32m success\033[0m."
    mv hbl.nsp ./atmosphere
fi

# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
特斯拉中文版插件：（纯净版 没有特斯拉插件）
 
ENDOFFILE
###


### Fetch Ultrahand-Overlay
## Fetch latest Ultrahand-Overlay from https://github.com/ppkantorski/Ultrahand-Overlay
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/ppkantorski/Ultrahand-Overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Ultrahand-Overlay {} >> ../description.txt

### Fetch Ultrahand-Overlay 自动转区
## Fetch latest Ultrahand-Overlay from https://github.com/gzk47/Ultrahand-Overlay
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/Ultrahand-Overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ovlmenu.ovl {} 国行自动转国际版 >> ../description.txt
## Fetch lastest ovl-sysmodules from https://github.com/zdm65477730/ovl-sysmodules/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/ovl-sysmodules/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ovl-sysmodules {} >> ../description.txt
## Fetch lastest Status-Monitor-Overlay from https://github.com/zdm65477730/Status-Monitor-Overlay/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/Status-Monitor-Overlay/releases
cat latest.json \
  | jq 'first(.[]|select(.assets|any(.name|test("^StatusMonitor.*\\.zip$")))).tag_name' \
  | xargs -I {} echo StatusMonitor {} >> ../description.txt
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
    rm -rf atmosphere/contents/0100000000000352
    rm -rf switch/.overlays     
fi


## Fetch lastest ReverseNX-RT from https://github.com/zdm65477730/ReverseNX-RT/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/ReverseNX-RT/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ReverseNX-RT {} >> ../description.txt
## Fetch lastest sys-clk from https://github.com/gzk47/sys-clk/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/sys-clk/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo sys-clk {} >> ../description.txt
## Fetch lastest emuiibo from https://github.com/gzk47/emuiibo/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/gzk47/emuiibo/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo emuiibo {} >> ../description.txt
## Fetch lastest ldn_mitm from https://github.com/zdm65477730/ldn_mitm/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/ldn_mitm/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo ldn_mitm {} >> ../description.txt
## Fetch lastest QuickNTP from https://github.com/zdm65477730/QuickNTP/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/QuickNTP/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo QuickNTP {} >> ../description.txt
## Fetch lastest sysdvr-overlay from https://github.com/zdm65477730/sysdvr-overlay/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/zdm65477730/sysdvr-overlay/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo SysDVR {} >> ../description.txt


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
国行自动转区 - 国行机器开机自动转国际版
系统内存设置 - 系统内存大小调整、内存缓冲区配置等
帧率补丁 - 应用游戏帧率解锁补丁
极限超频 - 优化CPU/GPU/内存性能
工具箱更新 - 一键更新至最新版本
 
ENDOFFILE
###

# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
极限超频替换包：（ 覆盖到【特斯拉版】心悦整合包上替换 ）
 
ENDOFFILE
###

### Fetch latest Horizon-OC dist.zip from https://github.com/Horizon-OC/Horizon-OC/releases/latest
curl -H "$API_AUTH" -o latest.json -sL https://api.github.com/repos/Horizon-OC/Horizon-OC/releases/latest
cat latest.json \
  | jq '.tag_name' \
  | xargs -I {} echo Horizon-OC v{}>> ../description.txt

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
#mkdir -p ./AMS-Pure/bootloader/ini
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
enable_mem_mode=1
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
# rm -f switch/haze.nro
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



### Fetch readme
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/readme.txt -o readme.txt
if [ $? -ne 0 ]; then
    echo "readme download\033[31m failed\033[0m."
else
    echo "readme download\033[32m success\033[0m."
    mv readme.txt 【纯净版】心悦大气层中文整合包v$(date +%Y%m%d).txt

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
 
AMS-Pure       为：纯净版
AMS-Tesla      为：特斯拉版
Horizon-OC     为：极限超频替换包
 
ENDOFFILE
###

# -------------------------------------------

cat >> ../description.txt << ENDOFFILE

------------------------------

构建时间：$(date +%Y%m%d)

ENDOFFILE

# -------------------------------------------

cp -a ../description.txt ./软件详情.txt

echo ""
echo "\033[32mYour AMS-Pure card is prepared!\033[0m"
