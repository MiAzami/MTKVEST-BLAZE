#!/system/bin/sh
#/magisk/modname/をハードコーディングしないでください...;代わりに $MODDIR ＃これにより、Magiskが将来マウントポイントを変更した場合でも、スクリプトに互換性があります。

# Waiting for boot completed
while [ "$(getprop sys.boot_completed | tr -d '\r')" != "1" ]; do sleep 5; done

# Path
MODDIR=${0%/*}

# Function to send Toast notifications
send_notification() {
    am broadcast -a android.intent.action.SENDTO -d "toast:$1" --es "toast_message" "$2" --es "package" "bellavita.toast" >/dev/null 2>&1
}

# Function to launch vest.apk
launch_vest() {
    am start -n com.zeetaa.zeetaatweaks/.MainActivity >/dev/null 2>&1
}

# Notify when selecting the mode and launch vest.apk
case $mode in
    1 )
        SC="Balance Mode"
        send_notification "bellavita.toast" "Balance Mode Activated"
        launch_vest  # Launch the VEST APK
        ;;
    2 )
        SC="Gaming Mode"
        send_notification "bellavita.toast" "Gaming Mode Activated"
        launch_vest  # Launch the VEST APK
        ;;
    3 )
        SC="Battery Mode"
        send_notification "bellavita.toast" "Battery Mode Activated"
        launch_vest  # Launch the VEST APK
        ;;
esac
ui_print "Selected: $SC"


# Variables
ZRAMSIZE=0
SWAPSIZE=0

# Zram functions
disable_zram()
{
    swapoff /dev/block/zram0
    echo "0" > /sys/class/zram-control/hot_remove
}

change_zram()
{
    sleep 5
    swapoff /dev/block/zram0
    echo "1" > /sys/block/zram0/reset
    echo "$ZRAMSIZE" > /sys/block/zram0/disksize
    mkswap /dev/block/zram0
    swapon /dev/block/zram0
}

# skiavk
skiavk()
{
    resetprop -n debug.hwui.renderer skiavk
    resetprop -n debug.renderengine.backend skiavkthreaded
    resetprop -n ro.hwui.use_vulkan 1
    resetprop -n ro.hwui.hardware.vulkan true
    resetprop -n ro.hwui.use_vulkan true
    resetprop -n ro.hwui.skia.show_vulkan_pipeline true
    resetprop -n persist.sys.disable_skia_path_ops false
    resetprop -n ro.config.hw_high_perf true
    resetprop -n debug.hwui.disable_scissor_opt true
    resetprop -n debug.vulkan.layers.enable 1
    resetprop -n debug.hwui.render_thread true
}

# skiagl
skiagl()
{
    resetprop -n debug.hwui.renderer skiagl
    resetprop -n vendor.debug.renderengine.backend skiaglthreaded
    resetprop -n debug.renderengine.backend skiaglthreaded
    resetprop -n debug.hwui.render_thread true
    resetprop -n debug.skia.threaded_mode true
    resetprop -n debug.hwui.render_thread_count 1
    resetprop -n debug.skia.num_render_threads 1
    resetprop -n debug.skia.render_thread_priority 1
    resetprop -n debug.skia.max_memory_usage_mb 512
    resetprop -n persist.sys.gpu.working_thread_priority 1
}

# Disable Thermal
disable_thermal()
{
    stop thermald
    stop thermal_core
    stop vendor.thermal-hal-2-0.mtk
    resetprop -n ro.boottime.thermald 0
    resetprop -n ro.boottime.vendor.thermal-hal-2-0.mtk 0
    resetprop -n ro.vendor.mtk_thermal_2_0 0
    resetprop -n ro.boottime.thermal_core 0
    resetprop -n ro.esports.thermal_config.support 0
    resetprop -n dalvik.vm.dexopt.thermal-cutoff 0
    resetprop -n init.svc.vendor.thermal-hal-2-0.mtk 0
    for a in $(getprop|grep thermal|cut -f1 -d]|cut -f2 -d[|grep -F init.svc.|sed 's/init.svc.//');do stop $a;done;for b in $(getprop|grep thermal|cut -f1 -d]|cut -f2 -d[|grep -F init.svc.);do setprop $b stopped;done;for c in $(getprop|grep thermal|cut -f1 -d]|cut -f2 -d[|grep -F init.svc_);do setprop $c "";done;for e in $(find /sys/ -name throttling);do echo 0>"$e";done;for d in $(getprop|grep init.svc|grep -E "logd|thermal"|cut -d[ -f2|cut -d] -f1);do stop "$(echo $d|cut -d. -f3)";resetprop -n "$d" stopped;done
}

# disable vsync
vsync()
{
    service call SurfaceFlinger 1036 i32 0
}

su -lp 2000 -c "cmd notification post -S bigtext -t 'MTKVEST Blaze' tag 'Apply Tweak, Waiting for some minutes...'" >/dev/null 2>&1

# Change zram
#change_zram

# Disable Thermal
#disable_thermal

# skiavk
#skiavk

# disabke vsync
#vsync

echo N > /sys/module/sync/parameters/fsync_enabled

# Scheduler I/O
echo "deadline" > /sys/block/sda/queue/scheduler
echo "deadline" > /sys/block/sdb/queue/scheduler
echo "deadline" > /sys/block/sdc/queue/scheduler

#printk
echo "0 0 0 0" > /proc/sys/kernel/printk
echo "1" > /sys/module/printk/parameters/console_suspend
echo "1" > /sys/module/printk/parameters/ignore_loglevel
echo "0" > /sys/module/printk/parameters/time
echo "off" > /proc/sys/kernel/printk_devkmsg

# Networking tweaks
echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
echo "1" > /proc/sys/net/ipv4/tcp_low_latency
echo "1" > /proc/sys/net/ipv4/tcp_ecn
echo "1" > /proc/sys/net/ipv4/tcp_sack
echo "1" > /proc/sys/net/ipv4/tcp_timestamps

resetprop -n debug.sf.disable_client_composition_cache 1
resetprop -n debug.sf.latch_unsignaled 1
resetprop -n debug.sf.disable_backpressure 1
resetprop -n debug.sf.enable_gl_backpressure 0
resetprop -n debug.sf.enable_hwc_vds 1
resetprop -n persist.sys.sf.native_mode 1
resetprop -n debug.sf.hw 1
resetprop -n debug.sf.enable_layer_caching 0

sleep 5
su -lp 2000 -c "cmd notification post -S bigtext -t 'MTKVEST Blaze' tag 'Tweak Applied'" >/dev/null 2>&1

am start -a android.intent.action.MAIN -e toasttext "Tweak Applied" -n bellavita.toast/.MainActivity

# このスクリプトはlate_startサービスモードで実行されます ＃メインのMagiskスレッドの詳細
