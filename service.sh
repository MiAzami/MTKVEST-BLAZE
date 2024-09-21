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
dvsync()
{
    service call SurfaceFlinger 1035 i32 0
}

# disable vsync
evsync()
{
    service call SurfaceFlinger 1035 i32 1
}

# disable overlay HW
doverlay()
{
    service call SurfaceFlinger 1008 i32 1
}

# enable overlay HW
eoverlay()
{
    service call SurfaceFlinger 1008 i32 0
}

# Advanced FPSGO Settings
fpsgo()
{
    echo "15" > /sys/module/mtk_fpsgo/parameters/bhr_opp
    echo "0" > /sys/module/mtk_fpsgo/parameters/bhr_opp_l
    echo "1" > /sys/module/mtk_fpsgo/parameters/boost_affinity
    echo "1" > /sys/module/mtk_fpsgo/parameters/xgf_uboost
    echo "90" > /sys/module/mtk_fpsgo/parameters/uboost_enhance_f
    echo "1" > /sys/module/mtk_fpsgo/parameters/gcc_fps_margin
    echo "90" > /sys/module/mtk_fpsgo/parameters/rescue_enhance_f
    echo "1" > /sys/module/mtk_fpsgo/parameters/qr_mod_frame
    echo "1" > /sys/module/mtk_fpsgo/parameters/fstb_separate_runtime_enable
    echo "1" > /sys/module/mtk_fpsgo/parameters/fstb_consider_deq
    echo "5" > /sys/pnpmgr/fpsgo_boost/fstb/fstb_tune_quantile
    echo "0" > /sys/pnpmgr/fpsgo_boost/fstb/fstb_tune_error_threshold
    echo "1" > /sys/pnpmgr/fpsgo_boost/fstb/margin_mode
    echo "15" > /sys/pnpmgr/fpsgo_boost/fbt/bhr_opp
    echo "1" > /sys/pnpmgr/fpsgo_boost/fbt/adjust_loading
    echo "1" > /sys/pnpmgr/fpsgo_boost/fbt/dyn_tgt_time_en
    echo "0" > /sys/pnpmgr/fpsgo_boost/fbt/floor_opp
    echo "90" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_enhance_f
    echo "90" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_opp_c
    echo "90" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_opp_f
    echo "90" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_percent
    echo "1" > /sys/pnpmgr/fpsgo_boost/fbt/ultra_rescue
}

su -lp 2000 -c "cmd notification post -S bigtext -t 'MTKVEST Blaze' tag 'Apply Tweak, Waiting for some minutes...'" >/dev/null 2>&1

# Change zram
#change_zram

# Disable Thermal
#disable_thermal

# skiavk
#skiavk

# disable vsync
#dvsync

# enable vsync
#evsync

# enable overlay HW
#eoverlay

# disable overlay HW
#doverlay

# fpsgo
#fpsgo

echo N > /sys/module/sync/parameters/fsync_enabled

# GED Hal ( Kernel) 
chmod 644 /sys/kernel/fpsgo/fstb/*
for fbt in /sys/kernel/fpsgo/fstb
    do
        echo 95 > "$fbt/boost_ta"
        echo 0 > "$fbt/enable_switch_sync_flag"
    done
    chmod 444 /sys/kernel/fpsgo/fstb/*
    
# GED Hal ( Kernel) 
for gedh in /sys/kernel/ged/hal
    do
        echo 95 > "$gedh/gpu_boost_level"
    done

# GED Parameter (Module) 
for gedp in /sys/module/ged/parameters
    do
        echo 95 > "$gedp/ged_smart_boost"
        echo 1 > "$gedp/enable_gpu_boost"
        echo 1 > "$gedp/ged_boost_enable"
        echo 1 > "$gedp/boost_gpu_enable"
        echo 1 > "$gedp/gpu_dvfs_enable"
        echo 95 > "$gedp/gx_fb_dvfs_margin"
        echo 10 > "$gedp/gpu_idle"
        echo 0 > "$gedp/is_GED_KPI_enabled"
	done

# FPSGo (PNPMGR) 
for pnp in /sys/pnpmgr
    do
        echo 1 > "$pnp/fpsgo_boost/boost_mode"
        echo 1 > "$pnp/install"
        echo 1 > "$pnp/mwn"
    done
    
# MTKFPS GO Parameter
for fpsp in /sys/module/mtk_fpsgo/parameters
    do
        echo 95 > "$fpsp/boost_affinity"
        echo 95 > "$fpsp/boost_LR"
        echo 95 > "$fpsp/xgf_uboost"
    done


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
echo "3" > /proc/sys/net/ipv4/tcp_fastopen

sleep 5
su -lp 2000 -c "cmd notification post -S bigtext -t 'MTKVEST Blaze' tag 'Tweak Applied'" >/dev/null 2>&1

am start -a android.intent.action.MAIN -e toasttext "Tweak Applied" -n bellavita.toast/.MainActivity

# このスクリプトはlate_startサービスモードで実行されます ＃メインのMagiskスレッドの詳細
