#!/system/bin/sh
ui_print ""
ui_print "█▀▄▀█ ▀█▀ █▄▀   █▄▄ █░░ ▄▀█ ▀█ █▀▀   ▀▄▀"
ui_print "█░▀░█ ░█░ █░█   █▄█ █▄▄ █▀█ █▄ ██▄   █░█"
ui_print ""
ui_print "       [         MODULE INFO         ]"
sleep 0.5
ui_print "Name           : mtk.VEST- ver.暗い炎 "
ui_print "Version        : 1.1.4 (100) GORE "
ui_print "Support Device : Helio G99 / Ultimate / Ultra "
ui_print "Support Root   : Magisk / KernelSU / APatch"
ui_print "Release Date   : 10/08/2024 "
ui_print "Mod           : @MiAzami"
ui_print "Thanks to     : who86, NotZeeta (App), Rem01gaming (code),Azazil (code), Riprog (support),Fastbooeteraselk (busybox), All Tester"
ui_print ""
sleep 1
# Install MTKVEST app
ui_print " 📲 Install MTKVEST Blaze app"
pm install $MODPATH/vest.apk
pm install $MODPATH/Toast.apk
ui_print " "

on_install() {
  ui_print "- Extracting module files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

# Run addons
if [ "$(ls -A $MODPATH/addon/*/install.sh 2>/dev/null)" ]; then
  ui_print "- Running Addons"
  for i in $MODPATH/addon/*/install.sh; do
    ui_print "  Running $(echo $i | sed -r "s|$MODPATH/addon/(.*)/install.sh|\1|")..."
    . $i
  done
fi

ui_print "" 
ui_print "  Volume Key Selector to select options:"
ui_print "  1) Install Busybox"
ui_print "  2) ZRAM"
ui_print "  3) Disable Thermal"
ui_print "  4) Render Settings"
ui_print "  5) Disable V-Sync"
ui_print ""
ui_print "  Button Function:"
ui_print "  • Volume + (Next)"
ui_print "  • Volume - (Select)"
ui_print ""
sleep 3

# Define external variables
BPATH="$TMPDIR/system/xbin"
a="$MODPATH/system/xbin"
MODVER="$(grep_prop version ${TMPDIR}/module.prop)"

deploy() {
    unzip -qo "$ZIPFILE" 'system/*' -d $TMPDIR

    # Check if busybox is already installed
    if [ -f "$a/busybox" ]; then
        ui_print "BusyBox is already installed. Skipping installation..."
        return
    fi

    # Init
    set_perm "$BPATH/busybox*" 0 0 777

    # Detect Architecture
    case "$ARCH" in
        "arm64")
            mv -f $BPATH/busybox-arm64 $a/busybox
            ;;
    esac
}

# If there's no existing module, clean up any other busybox modules
if ! [ -d "/data/adb/modules/${MODID}" ]; then
    find /data/adb/modules -maxdepth 1 -name -type d | while read -r another_bb; do
        wleowleo="$(echo "$another_bb" | grep -i 'busybox')"
        if [ -n "$wleowleo" ] && [ -d "$wleowleo" ] && [ -f "$wleowleo/module.prop" ]; then
            touch "$wleowleo"/remove
        fi
    done            
fi

# If the module is already installed, remove the installed flag
if [ -d "/data/adb/modules/${MODID}" ] && [ -f "/data/adb/modules/${MODID}/installed" ]; then
    rm -f /data/adb/modules/${MODID}/installed
fi

# Extract and deploy binaries
deploy

# Built-in busybox
ui_print "  📦 Install busybox..."
ui_print "    1. Yes"
ui_print "    2. Uninstall Busybox"
ui_print "    3. No"
ui_print ""
ui_print "    Select:"
A=1
while true; do
    ui_print "    $A"
    if $VKSEL; then
        A=$((A + 1))
    else
        break
    fi
    if [ $A -gt 3 ]; then
        A=1
    fi
done
ui_print "    Selected: $A"
case $A in
    1 ) TEXT1="Install Busybox"; sed -i '/#install_busybox/s/.*/install_busybox/' $MODPATH/post-fs-data.sh;;
    2 ) TEXT1="Uninstall Busybox"; sed -i '/#uninstall_busybox/s/.*/uninstall_busybox/' $MODPATH/post-fs-data.sh;;
    3 ) TEXT1="Skip Install Busybox";;
esac
ui_print "    $TEXT1"
ui_print ""

# Zram
ui_print "  ➡️ ZRAM size..."
ui_print "    1. Default(using default zram from device)"
ui_print "    2. Disable"
ui_print "    3. 1024MB"
ui_print "    4. 1536MB"
ui_print "    5. 2048MB"
ui_print "    6. 2560MB"
ui_print "    7. 3072MB"
ui_print "    8. 4096MB"
ui_print "    9. 5120MB"
ui_print "    10. 6144MB"
ui_print ""
ui_print "    Select:"
B=1
while true; do
    ui_print "    $B"
    if $VKSEL; then
        B=$((B + 1))
    else
        break
    fi
    if [ $B -gt 10 ]; then
        B=1
    fi
done
ui_print "    Selected: $B"
case $B in
    1 ) TEXT2="Default";;
    2 ) TEXT2="Disable"; sed -i '/#change_zram/s/.*/disable_zram/' $MODPATH/service.sh;;
    3 ) TEXT2="1024MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=1025M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    4 ) TEXT2="1536MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=1537M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    5 ) TEXT2="2048MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=2049M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    6 ) TEXT2="2560MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=2561M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    7 ) TEXT2="3072MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=3073M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    8 ) TEXT2="4096MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=4097M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    9 ) TEXT2="5120MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=5121M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    10 ) TEXT2="6144MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=6145M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
esac
ui_print "    $TEXT2"
ui_print ""

# Built-in busybox
ui_print "  🌡️Disable Thermal..."
ui_print "    1. Yes"
ui_print "    2. No"
ui_print ""
ui_print "    Select:"
C=1
while true; do
    ui_print "    $C"
    if $VKSEL; then
        C=$((C + 1))
    else
        break
    fi
    if [ $C -gt 2 ]; then
        C=1
    fi
done
ui_print "    Selected: $C"
case $C in
    1 ) TEXT3="Yes"; sed -i '/#disable_thermal/s/.*/disable_thermal/' $MODPATH/service.sh;;
    3 ) TEXT3="No";;
esac
ui_print "    $TEXT3"
ui_print ""

# Built-in busybox
ui_print "  ⚙️ Render Settings.."
ui_print "    1. SkiaVKThreaded"
ui_print "    2. SkiaGLThreaded"
ui_print "    3. Skip Install"
ui_print ""
ui_print "    Select:"
D=1
while true; do
    ui_print "    $D"
    if $VKSEL; then
        D=$((D + 1))
    else
        break
    fi
    if [ $D -gt 3 ]; then
        D=1
    fi
done
ui_print "    Selected: $D"
case $D in
    1 ) TEXT4="SkiaVKThreaded"; sed -i '/#skiavk/s/.*/skiavk/' $MODPATH/service.sh;;
    2 ) TEXT4="SkiaGLThreaded"; sed -i '/#skiagl/s/.*/skiagl/' $MODPATH/service.sh.sh;;
    3 ) TEXT4="Skip Install";;
esac
ui_print "    $TEXT4"
ui_print ""

# Built-in busybox
ui_print "  ⚙️ Disable V-Sync..."
ui_print "    1. Yes"
ui_print "    2. No"
ui_print ""
ui_print "    Select:"
E=1
while true; do
    ui_print "    $E"
    if $VKSEL; then
        E=$((E + 1))
    else
        break
    fi
    if [ $E -gt 2 ]; then
        E=1
    fi
done
ui_print "    Selected: $E"
case $E in
    1 ) TEXT5="Yes"; sed -i '/#dvsync/s/.*/dvsync/' $MODPATH/service.sh;;
    2 ) TEXT5="No"; sed -i '/#evsync/s/.*/evsync/' $MODPATH/service.sh;;
esac
ui_print "    $TEXT5"
ui_print ""


sleep 2
ui_print "  Your settings:"
ui_print "  1) Install Busybox.       : $TEXT1"
ui_print "  2) ZRAM                   : $TEXT2"
ui_print "  3) Disable Thermal        : $TEXT3"
ui_print "  4) Render Settings        : $TEXT4"
ui_print "  5) Disable VSYNC         : $TEXT5"
ui_print " "
ui_print "- Apply options"
sleep 0.5
ui_print " "
ui_print "- Settings Mode Profile"
sleep 1
ui_print "==============================="
ui_print "✅ セッティング Battery Mode 🔋"
sleep 2
ui_print "✅ セッティング Balance Mode 📱"
sleep 2
ui_print "✅ セッティング Gaming Mode 🎮"
sleep 2

set_perm_recursive "$MODPATH/system/bin/game" root root 0755 0755
set_perm_recursive "$MODPATH/system/bin/balance" root root 0755 0755
set_perm_recursive "$MODPATH/system/bin/battery" root root 0755 0755

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/vendor 0 0 0755 0755
set_perm_recursive $MODPATH/system 0 0 0755 0755
set_perm_recursive "$MODPATH/system/bin" root root 0755 0755

# Check rewrite directory
if [ ! -e /storage/emulated/0/MTK_VEST ]; then
  mkdir /storage/emulated/0/MTK_VEST
fi

# Check applist file
if [ ! -e /storage/emulated/0/MTK_VEST/applist_perf.txt ]; then
  cp -f $MODPATH/auto/applist_perf.txt /storage/emulated/0/MTK_VEST
fi

nohup am start -a android.intent.action.VIEW -d https://t.me/mtkvestg99 >/dev/null 2>&1

ui_print "==============================="
ui_print "  Reboot System Now"


