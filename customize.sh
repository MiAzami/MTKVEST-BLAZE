#!/system/bin/sh

ui_print ""
ui_print "       [         MODULE INFO         ]"
sleep 0.5
ui_print "Name           : mtk.VEST- ver.暗い炎 "
ui_print "Version        : 1.1.4 (120) GORE "
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
ui_print "  1) ZRAM"
ui_print "  2) Install Busybox"
ui_print "  3) Render Settings"
ui_print "  4) Disable HW Overlays"
ui_print "  5) Advanced FPSGO"
ui_print "  6) Advanced GPU Setting"
ui_print "  7) Advanced GPU Boost"
ui_print "  8) Spoofing"
ui_print ""
ui_print "  Button Function:"
ui_print "  • Volume + (Next)"
ui_print "  • Volume - (Select)"
ui_print ""
sleep 2

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
A=1
while true; do
    ui_print "    $A"
    if $VKSEL; then
        A=$((A + 1))
    else
        break
    fi
    if [ $A -gt 10 ]; then
        A=1
    fi
done
ui_print "    Selected: $A"
case $A in
    1 ) TEXT1="Default";;
    2 ) TEXT1="Disable"; sed -i '/#change_zram/s/.*/disable_zram/' $MODPATH/service.sh;;
    3 ) TEXT1="1024MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=1025M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    4 ) TEXT1="1536MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=1537M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    5 ) TEXT1="2048MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=2049M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    6 ) TEXT1="2560MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=2561M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    7 ) TEXT1="3072MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=3073M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    8 ) TEXT1="4096MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=4097M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    9 ) TEXT1="5120MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=5121M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
    10 ) TEXT1="6144MB"; sed -i '/ZRAMSIZE=0/s/.*/ZRAMSIZE=6145M/' $MODPATH/service.sh; sed -i '/#change_zram/s/.*/change_zram/' $MODPATH/service.sh;;
esac
ui_print "    $TEXT1"
ui_print ""

# Built-in busybox
ui_print "  📦 Install busybox..."
ui_print "    1. Yes"
ui_print "    2. Uninstall Busybox"
ui_print "    3. No/Skip"
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
    if [ $B -gt 3 ]; then
        B=1
    fi
done
ui_print "    Selected: $B"
case $B in
    1 ) TEXT2="Install Busybox"; sed -i '/#install_busybox/s/.*/install_busybox/' $MODPATH/post-fs-data.sh;;
    2 ) TEXT2="Uninstall Busybox"; sed -i '/#uninstall_busybox/s/.*/uninstall_busybox/' $MODPATH/post-fs-data.sh;;
    3 ) TEXT2="Skip Install Busybox";;
esac
ui_print "    $TEXT2"
ui_print ""

# Built-in busybox
ui_print "  ⚙️ Render Settings.."
ui_print "    1. SkiaVKThreadedV5"
ui_print "    2. SkiaGLThreadedV4"
ui_print "    3. Skip Install"
ui_print "	CAUTION!! NOT ALL DEVICES SUPPORT WITH SKIAVK"
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
    if [ $C -gt 3 ]; then
        C=1
    fi
done
ui_print "    Selected: $C"
case $C in
    1 ) TEXT3="SkiaVKThreaded"; sed -i '/#skiavk/s/.*/skiavk/' $MODPATH/service.sh;;
    2 ) TEXT3="SkiaGLThreaded"; sed -i '/#skiagl/s/.*/skiagl/' $MODPATH/service.sh;;
    3 ) TEXT3="Skip Install";;
esac
ui_print "    $TEXT3"
ui_print ""

# DISABLE HW OVERLAYS
ui_print "  ⚙️ Disable HW Overlays..."
ui_print "    1. Yes"
ui_print "    2. No"
ui_print "    CAUTION!! WILL DRAIN YOUR BATTERY, WILL USED YOUR GPU"
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
    if [ $D -gt 2 ]; then
        D=1
    fi
done
ui_print "    Selected: $D"
case $D in
    1 ) TEXT4="Yes"; sed -i '/#doverlay/s/.*/doverlay/' $MODPATH/service.sh;;
    2 ) TEXT4="No";;
esac
ui_print "    $TEXT4"
ui_print ""

# FPSGO
ui_print "  ⚡️ Enable Advanced FPSGO Settings..."
ui_print "    1. Yes"
ui_print "    2. No / Skip Install"
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
    1 ) TEXT5="Yes"; sed -i '/#fpsgo/s/.*/fpsgo/' $MODPATH/service.sh;;
    2 ) TEXT5="No";;
esac
ui_print "    $TEXT5"
ui_print ""

# FPSGO
ui_print "  ⚡️ Enable Advanced GPU Priority Settings..."
ui_print "    1. Full GPU"
ui_print "    2. 75% GPU"
ui_print "    3. 50% GPU"
ui_print "    4. Full CPU"
ui_print "    5. Skip"
ui_print ""
ui_print "    Select:"
F=1
while true; do
    ui_print "    $F"
    if $VKSEL; then
        F=$((F + 1))
    else
        break
    fi
    if [ $F -gt 5 ]; then
        F=1
    fi
done
ui_print "    Selected: $F"
case $F in
    1 ) TEXT6="Full GPU"; sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' $MODPATH/system.prop; sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' $MODPATH/system.prop; sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' $MODPATH/system.prop; sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' $MODPATH/system.prop; sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' $MODPATH/system.prop; sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' $MODPATH/system.prop; sed -i 'debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' $MODPATH/system.prop; sed -i 'persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' $MODPATH/system.prop; sed -i 'debug.hwui.profile/s/.*/debug.hwui.profile=true/' $MODPATH/system.prop; sed -i 'debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' $MODPATH/system.prop; sed -i 'debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' $MODPATH/system.prop; sed -i 'debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' $MODPATH/system.prop; sed -i 'debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' $MODPATH/system.prop; sed -i 'renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' $MODPATH/system.prop; sed -i 'debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=false/' $MODPATH/system.prop; sed -i 'debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=0/' $MODPATH/system.prop; sed -i 'debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' $MODPATH/system.prop; sed -i 'debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' $MODPATH/system.prop; sed -i 'debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' $MODPATH/system.prop; sed -i 'debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=true/' $MODPATH/system.prop; sed -i 'debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' $MODPATH/system.prop; sed -i 'debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' $MODPATH/system.prop; sed -i 'debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' $MODPATH/system.prop; sed -i 'debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' $MODPATH/system.prop; sed -i 'debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' $MODPATH/system.prop; sed -i 'debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' $MODPATH/system.prop; sed -i 'debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' $MODPATH/system.prop; sed -i 'debug.hwui.level/s/.*/debug.hwui.level=2/' $MODPATH/system.prop;;
	2 ) TEXT6="75% GPU"; sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' $MODPATH/system.prop; sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' $MODPATH/system.prop; sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' $MODPATH/system.prop; sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' $MODPATH/system.prop; sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' $MODPATH/system.prop; sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' $MODPATH/system.prop; sed -i 'debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' $MODPATH/system.prop; sed -i 'persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' $MODPATH/system.prop; sed -i 'debug.hwui.profile/s/.*/debug.hwui.profile=true/' $MODPATH/system.prop; sed -i 'debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' $MODPATH/system.prop; sed -i 'debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' $MODPATH/system.prop; sed -i 'debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' $MODPATH/system.prop; sed -i 'debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' $MODPATH/system.prop; sed -i 'renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' $MODPATH/system.prop; sed -i 'debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=true/' $MODPATH/system.prop; sed -i 'debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=25/' $MODPATH/system.prop; sed -i 'debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' $MODPATH/system.prop; sed -i 'debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' $MODPATH/system.prop; sed -i 'debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' $MODPATH/system.prop; sed -i 'debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=true/' $MODPATH/system.prop; sed -i 'debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' $MODPATH/system.prop; sed -i 'debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' $MODPATH/system.prop; sed -i 'debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' $MODPATH/system.prop; sed -i 'debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' $MODPATH/system.prop; sed -i 'debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' $MODPATH/system.prop; sed -i 'debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' $MODPATH/system.prop; sed -i 'debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' $MODPATH/system.prop; sed -i 'debug.hwui.level/s/.*/debug.hwui.level=2/' $MODPATH/system.prop;;
	3 ) TEXT6="50% GPU"; sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' $MODPATH/system.prop; sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' $MODPATH/system.prop; sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' $MODPATH/system.prop; sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' $MODPATH/system.prop; sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' $MODPATH/system.prop; sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' $MODPATH/system.prop; sed -i 'debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' $MODPATH/system.prop; sed -i 'persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' $MODPATH/system.prop; sed -i 'debug.hwui.profile/s/.*/debug.hwui.profile=true/' $MODPATH/system.prop; sed -i 'debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' $MODPATH/system.prop; sed -i 'debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' $MODPATH/system.prop; sed -i 'debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' $MODPATH/system.prop; sed -i 'debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' $MODPATH/system.prop; sed -i 'renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' $MODPATH/system.prop; sed -i 'debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=true/' $MODPATH/system.prop; sed -i 'debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=50/' $MODPATH/system.prop; sed -i 'debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' $MODPATH/system.prop; sed -i 'debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' $MODPATH/system.prop; sed -i 'debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' $MODPATH/system.prop; sed -i 'debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=true/' $MODPATH/system.prop; sed -i 'debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' $MODPATH/system.prop; sed -i 'debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' $MODPATH/system.prop; sed -i 'debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' $MODPATH/system.prop; sed -i 'debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' $MODPATH/system.prop; sed -i 'debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' $MODPATH/system.prop; sed -i 'debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' $MODPATH/system.prop; sed -i 'debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' $MODPATH/system.prop; sed -i 'debug.hwui.level/s/.*/debug.hwui.level=2/' $MODPATH/system.prop;;
    4 ) TEXT6="Full CPU"; sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' $MODPATH/system.prop; sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' $MODPATH/system.prop; sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' $MODPATH/system.prop; sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' $MODPATH/system.prop; sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' $MODPATH/system.prop; sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' $MODPATH/system.prop; sed -i 'debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' $MODPATH/system.prop; sed -i 'persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' $MODPATH/system.prop; sed -i 'debug.hwui.profile/s/.*/debug.hwui.profile=true/' $MODPATH/system.prop; sed -i 'debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' $MODPATH/system.prop; sed -i 'debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' $MODPATH/system.prop; sed -i 'debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' $MODPATH/system.prop; sed -i 'debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' $MODPATH/system.prop; sed -i 'renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' $MODPATH/system.prop; sed -i 'debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=true/' $MODPATH/system.prop; sed -i 'debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=100/' $MODPATH/system.prop; sed -i 'debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' $MODPATH/system.prop; sed -i 'debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' $MODPATH/system.prop; sed -i 'debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' $MODPATH/system.prop; sed -i 'debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=true/' $MODPATH/system.prop; sed -i 'debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' $MODPATH/system.prop; sed -i 'debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' $MODPATH/system.prop; sed -i 'debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' $MODPATH/system.prop; sed -i 'debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' $MODPATH/system.prop; sed -i 'debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' $MODPATH/system.prop; sed -i 'debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' $MODPATH/system.prop; sed -i 'debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' $MODPATH/system.prop; sed -i 'debug.hwui.level/s/.*/debug.hwui.level=2/' $MODPATH/system.prop;;
	5 ) TEXT6="Skip";;
esac
ui_print "    $TEXT6"
ui_print ""

# FPSGO
ui_print "  ⚡️ Enable Advanced GPU Boost Settings..."
ui_print "    1. Yes"
ui_print "    2. No / Skip Install"
ui_print ""
ui_print "    Select:"
G=1
while true; do
    ui_print "    $G"
    if $VKSEL; then
        G=$((G + 1))
    else
        break
    fi
    if [ $G -gt 2 ]; then
        G=1
    fi
done
ui_print "    Selected: $G"
case $G in
    1 ) TEXT7="Yes"; sed -i '/debug.enabletr/s/.*/debug.enabletr=true/' $MODPATH/system.prop; sed -i '/debug.performance.tuning/s/.*/debug.performance.tuning=1/' $MODPATH/system.prop; sed -i '/hwui.render_dirty_regions/s/.*/hwui.render_dirty_regions=true/' $MODPATH/system.prop; sed -i '/vendor.gralloc.disable_ubwc/s/.*/vendor.gralloc.disable_ubwc=0/' $MODPATH/system.prop; sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' $MODPATH/system.prop; sed -i '/persist.service.lgospd.enable/s/.*/persist.service.lgospd.enable=0/' $MODPATH/system.prop; sed -i '/debug.egl.hw/s/.*/debug.egl.hw=1/' $MODPATH/system.prop; sed -i '/debug.egl.profiler/s/.*/debug.egl.profiler=1/' $MODPATH/system.prop; sed -i '/ro.sf.compbypass.enable/s/.*/ro.sf.compbypass.enable=0/' $MODPATH/system.prop; sed -i '/ro.sf.compbypass.count/s/.*/ro.sf.compbypass.count=0/' $MODPATH/system.prop; sed -i '/debug.overlayui.enable/s/.*/debug.overlayui.enable=1' $MODPATH/system.prop; sed -i '/persist.sys.ui.hw/s/.*/persist.sys.ui.hw=1' $MODPATH/system.prop; sed -i '/persist.sys.ui.rendering/s/.*/persist.sys.ui.rendering=1' $MODPATH/system.prop; sed -i '/debug.gralloc.gfx_ubwc_disable/s/.*/debug.gralloc.gfx_ubwc_disable=1' $MODPATH/system.prop; sed -i '/persist.sys.gpu.rendering/s/.*/persist.sys.gpu.rendering=1' $MODPATH/system.prop; sed -i '/video.accelerate.hw/s/.*/video.accelerate.hw=1' $MODPATH/system.prop; sed -i '/debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false' $MODPATH/system.prop; sed -i '/ro.config.enable.hw_accel/s/.*/ro.config.enable.hw_accel=true' $MODPATH/system.prop;;
    2 ) TEXT7="No";;
esac
ui_print "    $TEXT9"
ui_print ""

# FPSGO
ui_print "  ⚡️ Spoofing for Gaming..."
ui_print "    1. Mobile Legends"
ui_print "    2. PUBG"
ui_print "    3. CODM"
ui_print "    4. Skip"
ui_print ""
ui_print "    Select:"
H=1
while true; do
    ui_print "    $H"
    if $VKSEL; then
        H=$((H + 1))
    else
        break
    fi
    if [ $H -gt 4 ]; then
        H=1
    fi
done
ui_print "    Selected: $H"
case $H in
    1 ) TEXT8="Mobile Legends"; sed -i '/ro.product.model/s/.*/ro.product.model=Mi 10 Pro/' $MODPATH/system.prop; sed -i '/ro.product.odm.model/s/.*/ro.product.odm.model=Mi 10 Pro/' $MODPATH/system.prop; sed -i '/ro.product.system.model/s/.*/ro.product.system.model=Mi 10 Pro/' $MODPATH/system.prop; sed -i '/ro.product.vendor.model/s/.*/ro.product.vendor.model=Mi 10 Pro/' $MODPATH/system.prop; sed -i '/ro.product.system_ext.model/s/.*/ro.product.system_ext.model=Mi 10 Pro/' $MODPATH/system.prop;;
    2 ) TEXT8="PUBG"; sed -i '/ro.product.model/s/.*/ro.product.model=M2006J10C/' $MODPATH/system.prop; sed -i '/ro.product.odm.model/s/.*/ro.product.odm.model=M2006J10C/' $MODPATH/system.prop; sed -i '/ro.product.system.model/s/.*/ro.product.system.model=M2006J10C/' $MODPATH/system.prop; sed -i '/ro.product.vendor.model/s/.*/ro.product.vendor.model=M2006J10C/' $MODPATH/system.prop; sed -i '/ro.product.system_ext.model/s/.*/ro.product.system_ext.model=M2006J10C/' $MODPATH/system.prop;;
	3 ) TEXT8="CODM"; sed -i '/ro.product.model/s/.*/ro.product.model=SM-G965F/' $MODPATH/system.prop; sed -i '/ro.product.odm.model/s/.*/ro.product.odm.model=SM-G965F/' $MODPATH/system.prop; sed -i '/ro.product.system.model/s/.*/ro.product.system.model=SM-G965F/' $MODPATH/system.prop; sed -i '/ro.product.vendor.model/s/.*/ro.product.vendor.model=SM-G965F/' $MODPATH/system.prop; sed -i '/ro.product.system_ext.model/s/.*/ro.product.system_ext.model=SM-G965F/' $MODPATH/system.prop;;
	4 ) TEXT8="Skip";;
esac
ui_print "    $TEXT8"
ui_print ""

sleep 1
ui_print "  Your settings:"
ui_print "  1) ZRAM Size			  : $TEXT1"
ui_print "  3) Install Busybox 		  : $TEXT2"
ui_print "  5) Render Settings        : $TEXT3"
ui_print "  6) Disable HW Overlays    : $TEXT4"
ui_print "  7) Advanced FPSGO         : $TEXT5"
ui_print "  8) Advanced GPU Settings  : $TEXT6"
ui_print "  9) Advanced GPU Boost 	  : $TEXT7"
ui_print "  10) Spoofing			  : $TEXT8"
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
ui_print ""
ui_print "  JOIN US FOR THE UPDATE"
sleep 2
nohup am start -a android.intent.action.VIEW -d https://t.me/mtkvestg99 >/dev/null 2>&1

ui_print "==============================="
ui_print "  Reboot System Now"


