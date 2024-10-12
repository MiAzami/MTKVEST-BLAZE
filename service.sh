#!/system/bin/sh
#By MiAzami
#!/bin/sh
# Waiting for boot completed
while [ "$(getprop sys.boot_completed | tr -d '\r')" != "1" ]; do sleep 5; done

MODDIR=${0%/*}

# Device online functions
wait_until_login()
{
    while [ "$(dumpsys window policy | grep mInputRestricted=true)" != "" ]; do
        sleep 4
    done
    while [ ! -d "/sdcard/Android" ]; do
        sleep 2
    done
}

su -lp 2000 -c "cmd notification post -S bigtext -t 'MTKVEST BLAZE' tag 'Waiting to Apply'" >/dev/null 2>&1

# Set kernel scheduler parameters for specific apps/libraries
echo "com.miHoYo.,com.HoYoverse.,UnityMain,libunity.so" > /proc/sys/kernel/sched_lib_name
echo 255 > /proc/sys/kernel/sched_lib_mask_force

# Set the I/O scheduler to "deadline" for all block devices
for device in /sys/block/*; do
    queue="$device/queue"
    if [ -f "$queue/scheduler" ]; then
        echo "deadline" > "$queue/scheduler"
    fi
done

# Disable fsync
echo N > /sys/module/sync/parameters/fsync_enabled

# Kernel performance configuration
echo "0 0 0 0" > /proc/sys/kernel/printk
echo "off" > /proc/sys/kernel/printk_devkmsg
echo "Y" > /sys/module/printk/parameters/console_suspend
echo "N" > /sys/module/printk/parameters/cpu
echo "0" > /sys/kernel/printk_mode/printk_mode
echo "Y" > /sys/module/printk/parameters/ignore_loglevel
echo "N" > /sys/module/printk/parameters/pid
echo "N" > /sys/module/printk/parameters/time
echo "1" > /proc/sys/kernel/sched_child_runs_first
echo "0" > /sys/kernel/ccci/debug

# Networking tweaks for low latency
echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
echo 1 > /proc/sys/net/ipv4/tcp_low_latency
echo 1 > /proc/sys/net/ipv4/tcp_ecn
echo 1 > /proc/sys/net/ipv4/tcp_sack
echo 1 > /proc/sys/net/ipv4/tcp_timestamps
echo 3 > /proc/sys/net/ipv4/tcp_fastopen

#additional
echo "0-7" > /proc/irq/240/smp_affinity_list

#Auto Preload
while true
do a="$(dumpsys window|grep mCurrentFocus|cut -f2 -d=|cut -f3 -d\ |cut -f1 -d/)"
if [ ! "$a" = "$(cat "$(dirname $0)/.log")" ];then
pkill -f vmtouch
echo "$a">"$(dirname $0)/.log"
vmtouch -dL "$(cmd package path "$a"|grep base|cut -f2 -d:)">/dev/null 2>&1&
fi
sleep 15
done>/dev/null 2>&1&

su -lp 2000 -c "cmd notification post -S bigtext -t 'MTKVEST BLAZE' tag 'Tweak Applied'" >/dev/null 2>&1
