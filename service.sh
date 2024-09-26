#!/system/bin/sh
#By MiAzami

sync

# Waiting for boot completed
while [ "$(getprop sys.boot_completed | tr -d '\r')" != "1" ]; do sleep 5; done

# Path
MODDIR=${0%/*}

# Device online functions
wait_until_login()
{
    # whether in lock screen, tested on Android 7.1 & 10.0
    # in case of other magisk module remounting /data as RW
    while [ "$(dumpsys window policy | grep mInputRestricted=true)" != "" ]; do
        sleep 4
    done
    # we doesn't have the permission to rw "/sdcard" before the user unlocks the screen
    while [ ! -d "/sdcard/Android" ]; do
        sleep 2
    done
}

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

# disable overlay HW
doverlay()
{
    service call SurfaceFlinger 1008 i32 1
}

# Advanced FPSGO Settings
fpsgo()
{
    echo "15" > /sys/module/mtk_fpsgo/parameters/bhr_opp
    echo "1" > /sys/module/mtk_fpsgo/parameters/bhr_opp_l
    echo "90" > /sys/module/mtk_fpsgo/parameters/uboost_enhance_f
    echo "1" > /sys/module/mtk_fpsgo/parameters/gcc_fps_margin
    echo "90" > /sys/module/mtk_fpsgo/parameters/rescue_enhance_f
    echo "1" > /sys/module/mtk_fpsgo/parameters/qr_mod_frame
    echo "1" > /sys/module/mtk_fpsgo/parameters/fstb_separate_runtime_enable
    echo "1" > /sys/module/mtk_fpsgo/parameters/fstb_consider_deq
    echo "5" > /sys/pnpmgr/fpsgo_boost/fstb/fstb_tune_quantile
    echo "0" > /sys/pnpmgr/fpsgo_boost/fstb/fstb_tune_error_threshold
    echo "1" > /sys/pnpmgr/fpsgo_boost/fstb/margin_mode
    echo "10" > /sys/pnpmgr/fpsgo_boost/fbt/bhr_opp
    echo "1" > /sys/pnpmgr/fpsgo_boost/fbt/adjust_loading
    echo "1" > /sys/pnpmgr/fpsgo_boost/fbt/dyn_tgt_time_en
    echo "0" > /sys/pnpmgr/fpsgo_boost/fbt/floor_opp
    echo "90" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_enhance_f
    echo "80" > /sys/module/mtk_fpsgo/parameters/run_time_percent
    echo "1" > /sys/module/mtk_fpsgo/parameters/loading_ignore_enable
    echo "80" > /sys/module/mtk_fpsgo/parameters/kmin
    echo "90" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_opp_c
    echo "90" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_opp_f
    echo "90" > /sys/pnpmgr/fpsgo_boost/fbt/rescue_percent
    echo "1" > /sys/pnpmgr/fpsgo_boost/fbt/ultra_rescue
}


# Enable all tweak

su -lp 2000 -c "cmd notification post -S bigtext -t 'MTKVEST BLAZE' tag 'Waiting to Apply'" >/dev/null 2>&1

# Sync to data in the rare case a device crashes
sync

# Change zram
#change_zram

mali_dir=$(find /sys/devices/platform/soc/ -name "*mali*" -type d)
if [ -n "$mali_dir" ]; then
    echo 1 > "$mali_dir/js_ctx_scheduling_mode"
    echo 25 > "$mali_dir/js_scheduling_period"
    echo 100 > "$mali_dir/dvfs_period"
else
    echo "Mali directory not found"
fi

write /proc/sys/kernel/sched_lib_name "com.miHoYo.,com.HoYoverse.,UnityMain,libunity.so"
write /proc/sys/kernel/sched_lib_mask_force 255

for device in /sys/block/*; do
    if [ "$queue/scheduler" ]; then
        echo "deadline" > "$queue/scheduler"
    fi
done

# Set permissions for FPSGO FSTB parameters
chmod 644 /sys/kernel/fpsgo/fstb/*
fstb_params=(
    "boost_ta"
    "enable_switch_sync_flag"
)

for param in "${fstb_params[@]}"
do
    if [[ "$param" == "enable_switch_sync_flag" ]]; then
        echo 0 > "/sys/kernel/fpsgo/fstb/$param"
    else
        echo 1 > "/sys/kernel/fpsgo/fstb/$param"
    fi
done
chmod 444 /sys/kernel/fpsgo/fstb/*

# Set GPU boost level in GED HAL
echo 101 > /sys/kernel/ged/hal/gpu_boost_level
ged_params=(
    "ged_smart_boost"
    "enable_gpu_boost"
    "ged_boost_enable"
    "boost_gpu_enable"
    "gpu_dvfs_enable"
    "gpu_idle"
    "is_GED_KPI_enabled"
)

for param in "${ged_params[@]}"
do
    if [[ "$param" == "is_GED_KPI_enabled" ]]; then
        echo 0 > "/sys/module/ged/parameters/$param"
    else
        echo 1 > "/sys/module/ged/parameters/$param"
    fi
done

# Apply additional settings for GPU boost
additional_params=(
    "gx_frc_mode"
    "gx_boost_on"
    "gx_game_mode"
    "gx_3D_benchmark_on"
    "cpu_boost_policy"
    "boost_extra"
)

for param in "${additional_params[@]}"
do
    echo 1 > "/sys/module/ged/parameters/$param"
done

# FPSGo (PNPMGR) settings
pnpmgr_params=(
    "fpsgo_boost/boost_mode"
    "install"
    "mwn"
    "fpsgo_boost/fstb/fstb_tune_quantile"
)

for param in "${pnpmgr_params[@]}"
do
    if [[ "$param" == "fpsgo_boost/fstb/fstb_tune_quantile" ]]; then
        echo 100 > "/sys/pnpmgr/$param"
    else
        echo 1 > "/sys/pnpmgr/$param"
    fi
done

# MTK FPSGo parameters
mtk_fpsgo_params=(
    "boost_affinity"
    "boost_LR"
    "xgf_uboost"
)

for param in "${mtk_fpsgo_params[@]}"
do
    echo 1 > "/sys/module/mtk_fpsgo/parameters/$param"
done
    
stune_paths=("background" "foreground" "rt" "top-app" "")
boost_enabled_values=(1 1 0 0 0)

for i in "${!stune_paths[@]}"; do
  path=${stune_paths[$i]}
  boost_enabled=${boost_enabled_values[$i]}
  
  echo "35" > "/dev/stune/$path/schedtune.boost"
  echo "0" > "/dev/stune/$path/schedtune.prefer_idle"
  echo "0" > "/dev/stune/$path/schedtune.colocate"
  echo "$boost_enabled" > "/dev/stune/$path/schedtune.sched_boost_enabled"
done

echo N > /sys/module/sync/parameters/fsync_enabled

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

# Done
sleep 1

su -lp 2000 -c "cmd notification post -S bigtext -t 'MTKVEST BLAZE' tag 'Tweak Applied'" >/dev/null 2>&1
