#!/system/bin/sh

SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=false
LATESTARTSERVICE=false

ui_print ""
ui_print "    𝐦𝐭𝐤.𝐕𝐄𝐒𝐓- 𝐯𝐞𝐫.暗い炎 // 𝟏.𝟏.𝟒 (𝟏𝟑𝟎) 𝐆𝐎𝐑𝐄 // 𝐄𝐥𝐥𝐞𝐧𝐉𝐨𝐞"
ui_print "    𝟏𝟎/𝟎𝟖/𝟐𝟎𝟐𝟒 // @𝐌𝐢𝐀𝐳𝐚𝐦𝐢 "
ui_print ""
ui_print "    Thanks To :"
ui_print " — Riprog //Support"
ui_print " — Rem01Gaming //Support"
ui_print " — Azazil //Support"
ui_print " — Who86 //MTKVest"
ui_print " — NotZeeta //App"
ui_print " — All Tester"
ui_print ""
sleep 1
# Install MTKVEST app
ui_print " 📲 Install MTKVEST Blaze app"
pm install $MODPATH/vest.apk
pm install $MODPATH/Toast.apk
ui_print " "
ui_print "— Settings Mode Profile"
sleep 1
ui_print "==============================="
ui_print "✅ セッティング Battery Mode 🔋"
sleep 0.5
ui_print "✅ セッティング Balance Mode 📱"
sleep 0.5
ui_print "✅ セッティング Gaming Mode 🎮"
ui_print "==============================="
sleep 0.5
set_perm_recursive "$MODPATH/system/bin/game" root root 0755 0755
set_perm_recursive "$MODPATH/system/bin/balance" root root 0755 0755
set_perm_recursive "$MODPATH/system/bin/battery" root root 0755 0755
set_perm_recursive "$MODPATH/system/bin/vmtouch" root root 0755 0755
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/vendor 0 0 0755 0755
set_perm_recursive $MODPATH/system 0 0 0755 0755
set_perm_recursive "$MODPATH/system/bin" root root 0755 0755
mkdir -p "$MODPATH/system/bin"
unzip -p "$ZIPFILE" 'x.sh' >"$MODPATH/system/bin/MTKV"
chmod +x "$MODPATH/system/bin/MTKV"
ui_print ""
ui_print " [ su -c MTKV | To Configure Advanced Settings ]"
ui_print ""
sleep 1
nohup am start -a android.intent.action.VIEW -d https://t.me/mtkvestg99 >/dev/null 2>&1
ui_print ""
ui_print "  Reboot System Now"


