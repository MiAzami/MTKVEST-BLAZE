#!/system/bin/sh
MODPATH=/data/adb/modules/MTK_VEST

# AGPU Function
agpu() {
	echo ""
	echo "	$agpu_render_settings" # Use the shared variable here
	echo ""
	echo "[1] Back to Menu"
	echo "[2] 100% GPU/0% CPU Render"
	echo "[3] 75% GPU/25% CPU Render"
	echo "[4] 50% GPU/50% CPU Render"
	echo "[5] 25% GPU/75% CPU Render"
	echo "[6] 0% GPU/100% CPU Render"
	echo ""
	printf "Select: "
	read -r agpu_option

	case "$agpu_option" in
	1)
		echo "Default"
		echo "Done!"
		;;
	2)
		echo "Setting 100% GPU/0% CPU Render..."
		sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' "$MODPATH"/system.prop
		sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' "$MODPATH"/system.prop
		sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.profile/s/.*/debug.hwui.profile=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' "$MODPATH"/system.prop
		sed -i '/renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=0/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' "$MODPATH"/system.prop
		echo " "
		echo "Done!"
		;;
	3)
		echo "Setting 75% GPU/25% CPU Render..."
		sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' "$MODPATH"/system.prop
		sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' "$MODPATH"/system.prop
		sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.profile/s/.*/debug.hwui.profile=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' "$MODPATH"/system.prop
		sed -i '/renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=25/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' "$MODPATH"/system.prop
		echo " "
		echo "Done!"
		;;
	4)
		echo "Setting 50% GPU/50% CPU Render..."
		sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' "$MODPATH"/system.prop
		sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' "$MODPATH"/system.prop
		sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.profile/s/.*/debug.hwui.profile=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' "$MODPATH"/system.prop
		sed -i '/renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=50/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' "$MODPATH"/system.prop
		echo " "
		echo "Done!"
		;;
	5)
		echo "Setting 25% GPU/75% CPU Render..."
		sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' "$MODPATH"/system.prop
		sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' "$MODPATH"/system.prop
		sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.profile/s/.*/debug.hwui.profile=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' "$MODPATH"/system.prop
		sed -i '/renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=75/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' "$MODPATH"/system.prop
		echo " "
		echo "Done!"
		;;
	6)
		echo "Setting 0% GPU/100% CPU Render..."
		sed -i '/persist.sys.perf.topAppRenderThreadBoost.enable/s/.*/persist.sys.perf.topAppRenderThreadBoost.enable=true/' "$MODPATH"/system.prop
		sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread/s/.*/debug.hwui.render_thread=true/' "$MODPATH"/system.prop
		sed -i '/debug.skia.threaded_mode/s/.*/debug.skia.threaded_mode=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.render_thread_count/s/.*/debug.hwui.render_thread_count=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.num_render_threads/s/.*/debug.skia.num_render_threads=1/' "$MODPATH"/system.prop
		sed -i '/debug.skia.render_thread_priority/s/.*/debug.skia.render_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/persist.sys.gpu.working_thread_priority/s/.*/persist.sys.gpu.working_thread_priority=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.profile/s/.*/debug.hwui.profile=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_dirty_regions/s/.*/debug.hwui.show_dirty_regions=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.fps_divisor/s/.*/debug.hwui.fps_divisor=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_non_rect_clip/s/.*/debug.hwui.show_non_rect_clip=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.webview_overlays_enabled/s/.*/debug.hwui.webview_overlays_enabled=true/' "$MODPATH"/system.prop
		sed -i '/renderthread.skia.reduceopstasksplitting/s/.*/renderthread.skia.reduceopstasksplitting=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_hint_manager/s/.*/debug.hwui.use_hint_manager=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.target_cpu_time_percent/s/.*/debug.hwui.target_cpu_time_percent=100/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_tracing_enabled/s/.*/debug.hwui.skia_tracing_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.capture_skp_enabled/s/.*/debug.hwui.capture_skp_enabled=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skia_use_perfetto_track_events/s/.*/debug.hwui.skia_use_perfetto_track_events=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.trace_gpu_resources/s/.*/debug.hwui.trace_gpu_resources=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.show_layers_updates/s/.*/debug.hwui.show_layers_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.skip_empty_damage/s/.*/debug.hwui.skip_empty_damage=true/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_partial_updates/s/.*/debug.hwui.use_partial_updates=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_gpu_pixel_buffers/s/.*/debug.hwui.use_gpu_pixel_buffers=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.filter_test_overhead/s/.*/debug.hwui.filter_test_overhead=false/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.overdraw/s/.*/debug.hwui.overdraw=false/' "$MODPATH"/system.prop
		echo " "
		echo "Done!"
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$agpu_render_settings Updated."
	sleep 2
}

# AGPUB Function
agpub() {
	echo ""
	echo "	$agpub_render_settings" # Use the shared variable here
	echo "	CAUTION!! MAYBE NOT COMPITABLE WITH YOUR DEVICE"
	echo ""
	echo "[1] Back to Menu"
	echo "[2] Active Advanced Render"
	echo ""
	printf "Select: "
	read -r agpub_option

	case "$agpub_option" in
	1)
		echo "Default"
		echo "Done!"
		;;
	2)
		echo "Setting Active Advanced Render..."
		sed -i '/debug.enabletr/s/.*/debug.enabletr=false/' "$MODPATH"/system.prop
		sed -i '/debug.performance.tuning/s/.*/debug.performance.tuning=1/' "$MODPATH"/system.prop
		sed -i '/hwui.render_dirty_regions/s/.*/hwui.render_dirty_regions=true/' "$MODPATH"/system.prop
		sed -i '/vendor.gralloc.disable_ubwc/s/.*/vendor.gralloc.disable_ubwc=0/' "$MODPATH"/system.prop
		sed -i '/debug.sf.hw/s/.*/debug.sf.hw=1/' "$MODPATH"/system.prop
		sed -i '/debug.egl.hw/s/.*/debug.egl.hw=1/' "$MODPATH"/system.prop
		sed -i '/debug.egl.profiler/s/.*/debug.egl.profiler=1/' "$MODPATH"/system.prop
		sed -i '/debug.overlayui.enable/s/.*/debug.overlayui.enable=1/' "$MODPATH"/system.prop
		sed -i '/persist.sys.ui.hw/s/.*/persist.sys.ui.hw=1/' "$MODPATH"/system.prop
		sed -i '/persist.sys.ui.rendering/s/.*/persist.sys.ui.rendering=1/' "$MODPATH"/system.prop
		sed -i '/debug.gralloc.gfx_ubwc_disable/s/.*/debug.gralloc.gfx_ubwc_disable=0/' "$MODPATH"/system.prop
		sed -i '/persist.sys.gpu.rendering/s/.*/persist.sys.gpu.rendering=1/' "$MODPATH"/system.prop
		sed -i '/video.accelerate.hw/s/.*/video.accelerate.hw=1/' "$MODPATH"/system.prop
		sed -i '/debug.hwui.use_buffer_age/s/.*/debug.hwui.use_buffer_age=false/' "$MODPATH"/system.prop
		sed -i '/ro.config.enable.hw_accel/s/.*/ro.config.enable.hw_accel=true/' "$MODPATH"/system.prop
		sed -i '/ro.vendor.gpu.optimize.level/s/.*/ro.vendor.gpu.optimize.level=3/' "$MODPATH"/system.prop
		sed -i '/ro.vendor.gpu.optimize.preload/s/.*/ro.vendor.gpu.optimize.preload=1/' "$MODPATH"/system.prop
		sed -i '/ro.vendor.gpu.optimize.texture_control/s/.*/ro.vendor.gpu.optimize.texture_control=true/' "$MODPATH"/system.prop
		sed -i '/ro.vendor.gpu.optimize.memory_compaction/s/.*/ro.vendor.gpu.optimize.memory_compaction=true/' "$MODPATH"/system.prop
		sed -i '/ro.vendor.gpu.optimize.fork_detector/s/.*/ro.vendor.gpu.optimize.fork_detector=true/' "$MODPATH"/system.prop
		echo ""
		echo "Done!"
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$agpub_render_settings Updated."
	sleep 2
}

# FPSGO Function
fpsgo() {
	echo ""
	echo "	$fpsgo_enable_settings" # Use the shared variable here
	echo ""
	echo "	The FPSGO mechanism optimizes frame delivery by controlling how the CPU and GPU work together"
	echo "	allowing smoother frame rates in demanding applications while also ensuring that power consumption"
	echo "	is minimized when full performance isn't required."
	echo ""
	echo "[1] Back to Menu"
	echo "[2] Active FPSGO"
	echo ""
	printf "Select: "
	read -r fpsgo_option

	case "$fpsgo_option" in
	1)
		echo "Default"
		echo "Done!"
		;;
	2)
		echo "Setting Active FPSGO..."
		echo 1 >/sys/kernel/fpsgo/fstb/boost_ta
		echo 0 >/sys/kernel/fpsgo/fstb/enable_switch_sync_flag
		echo 100 >/sys/kernel/ged/hal/gpu_boost_level
		echo 100 >/sys/module/ged/parameters/gpu_idle
		echo 0 >/sys/module/ged/parameters/is_GED_KPI_enabled
		echo 1 >/sys/module/ged/parameters/gx_frc_mode
		echo 1 >/sys/module/ged/parameters/cpu_boost_policy
		echo 1 >/sys/module/ged/parameters/boost_extra
		echo 1 >/sys/pnpmgr/fpsgo_boost/boost_mode
		echo 1 >/sys/pnpmgr/install
		echo 1 >/sys/module/mtk_fpsgo/parameters/boost_affinity
		echo 1 >/sys/module/mtk_fpsgo/parameters/boost_LR
		echo 1 >/sys/module/mtk_fpsgo/parameters/xgf_uboost
		echo ""
		echo "Done!"
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$fpsgo_enable_settings Updated."
	sleep 2
}

# FPSGO Adv Function
fpsgoa() {
	echo ""
	echo "	$fpsgo_advanced_settings" # Use the shared variable here
	echo ""
	echo "[1] Back to Menu"
	echo "[2] Active Advanced FPSGO"
	echo ""
	printf "Select: "
	read -r fpsgos_option

	case "$fpsgos_option" in
	1)
		echo "Default"
		echo "Done!"
		;;
	2)
		echo "Setting Active Advanced FPSGO..."
		echo "5" >/sys/module/mtk_fpsgo/parameters/bhr_opp
		echo "1" >/sys/module/mtk_fpsgo/parameters/bhr_opp_l
		echo "5" >/sys/module/mtk_fpsgo/parameters/uboost_enhance_f
		echo "1" >/sys/module/mtk_fpsgo/parameters/gcc_fps_margin
		echo "5" >/sys/module/mtk_fpsgo/parameters/rescue_enhance_f
		echo "1" >/sys/module/mtk_fpsgo/parameters/qr_mod_frame
		echo "1" >/sys/module/mtk_fpsgo/parameters/fstb_separate_runtime_enable
		echo "1" >/sys/module/mtk_fpsgo/parameters/fstb_consider_deq
		echo "5" >/sys/pnpmgr/fpsgo_boost/fstb/fstb_tune_quantile
		echo "0" >/sys/pnpmgr/fpsgo_boost/fstb/fstb_tune_error_threshold
		echo "1" >/sys/pnpmgr/fpsgo_boost/fstb/margin_mode
		echo "10" >/sys/pnpmgr/fpsgo_boost/fbt/bhr_opp
		echo "1" >/sys/pnpmgr/fpsgo_boost/fbt/adjust_loading
		echo "1" >/sys/pnpmgr/fpsgo_boost/fbt/dyn_tgt_time_en
		echo "0" >/sys/pnpmgr/fpsgo_boost/fbt/floor_opp
		echo "5" >/sys/pnpmgr/fpsgo_boost/fbt/rescue_enhance_f
		echo "100" >/sys/module/mtk_fpsgo/parameters/run_time_percent
		echo "1" >/sys/module/mtk_fpsgo/parameters/loading_ignore_enable
		echo "1" >/sys/module/mtk_fpsgo/parameters/kmin
		echo "00" >/sys/pnpmgr/fpsgo_boost/fbt/rescue_opp_c
		echo "00" >/sys/pnpmgr/fpsgo_boost/fbt/rescue_opp_f
		echo "5" >/sys/pnpmgr/fpsgo_boost/fbt/rescue_percent
		echo 00 >/sys/module/ged/parameters/gpu_cust_upbound_freq
		echo 00 >/sys/module/ged/parameters/gpu_cust_boost_freq
		echo " "
		echo "Done!"
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$fpsgo_advanced_settings Updated."
	sleep 2
}

# Disable HW Function
overlays() {
	echo ""
	echo "	$overlays_settings" # Use the shared variable here
	echo ""
	echo "	CAUTION!! WILL DRAIN YOUR BATTERY, WILL USED YOUR GPU"
	echo ""
	echo "[1] Back to Menu"
	echo "[2] Turn ON Disable HW Overlays"
	echo "[3] Turn OFF Disable HW Overlays"
	echo ""
	printf "Select: "
	read -r overlays_option

	case "$overlays_option" in
	1)
		echo "Default"
		echo "Done!"
		;;
	2)
		echo "Setting Turn ON Disable HW Overlays..."
		service call SurfaceFlinger 1008 i32 1
		echo ""
		echo "Done!"
		;;
	3)
		echo "Setting Turn OFF Disable HW Overlays..."
		service call SurfaceFlinger 1008 i32 0
		echo ""
		echo "Done!"
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$overlays_settings Updated."
	sleep 2
}

# Disable HW Function
renderp() {
	echo ""
	echo "	$render_profile_settings" # Use the shared variable here
	echo ""
	echo "[1] Back to Menu"
	echo "[2] SkiaVK / Skia Vulkan"
	echo "[3] SkiaGL"
	echo "[4] Advanced SkiaVK (Backend with Threaded)"
	echo "[5] Advanced SkiaGL (Backend with Threaded)"
	echo ""
	printf "Select: "
	read -r renderp_option

	case "$renderp_option" in
	1)
		echo "Default"
		echo "Done!"
		;;
	2)
		echo "Setting SkiaVK / Skia Vulkan..."
		resetprop -n debug.hwui.renderer skiavk
		echo ""
		echo "Done!"
		;;
	3)
		echo "Setting SkiaGL..."
		resetprop -n debug.hwui.renderer skiagl
		echo ""
		echo "Done!"
		;;
	4)
		echo "Setting Advanced SkiaVK (Backend with Threaded)..."
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
		echo ""
		echo "Done!"
		;;
	5)
		echo "Setting Advanced SkiaGL (Backend with Threaded)..."
		resetprop -n debug.hwui.renderer skiagl
		resetprop -n vendor.debug.renderengine.backend skiaglthreaded
		resetprop -n debug.renderengine.backend skiaglthreaded
		resetprop -n debug.hwui.render_thread true
		resetprop -n debug.skia.threaded_mode true
		resetprop -n debug.hwui.render_thread_count 1
		resetprop -n debug.skia.num_render_threads 1
		resetprop -n debug.skia.render_thread_priority 1
		resetprop -n persist.sys.gpu.working_thread_priority 1
		echo ""
		echo "Done!"
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$render_profile_settings Updated."
	sleep 2
}

# Disable HW Function
renderc() {
	echo ""
	echo "	$render_comp_settings" # Use the shared variable here
	echo ""
	echo "[1] Back to Menu"
	echo "[2] GPU"
	echo "[3] CPU"
	echo "[4] C2D"
	echo "[5] DYN"
	echo "[6] MDP"
	echo ""
	printf "Select: "
	read -r renderc_option

	case "$renderc_option" in
	1)
		echo "Default"
		echo "Done!"
		;;
	2)
		echo "Setting gpu Renderer"
		sed -i '/debug.composition.type/s/.*/debug.composition.type=gpu/' "$MODPATH"/system.prop && resetprop -n debug.composition.type gpu
		echo ""
		echo "Done!"
		;;
	3)
		echo "Setting cpu Renderer"
		sed -i '/debug.composition.type/s/.*/debug.composition.type=cpu/' "$MODPATH"/system.prop && resetprop -n debug.composition.type cpu
		echo ""
		echo "Done!"
		;;
	4)
		echo "Setting c2d Renderer"
		sed -i '/debug.composition.type/s/.*/debug.composition.type=c2d/' "$MODPATH"/system.prop && resetprop -n debug.composition.type c2d
		echo ""
		echo "Done!"
		;;
	5)
		echo "Setting dyn Renderer"
		sed -i '/debug.composition.type/s/.*/debug.composition.type=dyn/' "$MODPATH"/system.prop && resetprop -n debug.composition.type dyn
		echo ""
		echo "Done!"
		;;
	6)
		echo "Setting MDP Renderer"
		sed -i '/debug.composition.type/s/.*/debug.composition.type=mdp/' "$MODPATH"/system.prop && resetprop -n debug.composition.type mdp
		echo ""
		echo "Done!"
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$render_comp_settings Updated."
	sleep 2
}

# Disable HW Function
spoofing() {
	echo ""
	echo "	$spoofing_settings" # Use the shared variable here
	echo ""
	echo "[1] Back to Menu"
	echo "[2] Mobile Legends"
	echo "[3] PUBG"
	echo "[4] Call Of Duty Mobile"
	echo ""
	printf "Select: "
	read -r spoofing_option

	case "$spoofing_option" in
	1)
		echo "Default"
		echo "Done!"
		;;
	2)
		echo "Setting PUBG..."
		sed -i '/ro.product.model/s/.*/ro.product.model=Mi 10 Pro/' "$MODPATH"/system.prop
		sed -i '/ro.product.odm.model/s/.*/ro.product.odm.model=Mi 10 Pro/' "$MODPATH"/system.prop
		sed -i '/ro.product.system.model/s/.*/ro.product.system.model=Mi 10 Pro/' "$MODPATH"/system.prop
		sed -i '/ro.product.vendor.model/s/.*/ro.product.vendor.model=Mi 10 Pro/' "$MODPATH"/system.prop
		sed -i '/ro.product.system_ext.model/s/.*/ro.product.system_ext.model=Mi 10 Pro/' "$MODPATH"/system.prop
		echo ""
		echo "Done!"
		;;
	3)
		echo "Setting PUBG..."
		sed -i '/ro.product.model/s/.*/ro.product.model=M2006J10C/' "$MODPATH"/system.prop
		sed -i '/ro.product.odm.model/s/.*/ro.product.odm.model=M2006J10C/' "$MODPATH"/system.prop
		sed -i '/ro.product.system.model/s/.*/ro.product.system.model=M2006J10C/' "$MODPATH"/system.prop
		sed -i '/ro.product.vendor.model/s/.*/ro.product.vendor.model=M2006J10C/' "$MODPATH"/system.prop
		sed -i '/ro.product.system_ext.model/s/.*/ro.product.system_ext.model=M2006J10C/' "$MODPATH"/system.prop echo ""
		echo "Done!"
		;;
	4)
		echo "Setting Call Of Duty Mobile..."
		sed -i '/ro.product.model/s/.*/ro.product.model=SM-G965F/' "$MODPATH"/system.prop
		sed -i '/ro.product.odm.model/s/.*/ro.product.odm.model=SM-G965F/' "$MODPATH"/system.prop
		sed -i '/ro.product.system.model/s/.*/ro.product.system.model=SM-G965F/' "$MODPATH"/system.prop
		sed -i '/ro.product.vendor.model/s/.*/ro.product.vendor.model=SM-G965F/' "$MODPATH"/system.prop
		sed -i '/ro.product.system_ext.model/s/.*/ro.product.system_ext.model=SM-G965F/' "$MODPATH"/system.prop
		echo ""
		echo "Done!"
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$render_comp_settings Updated."
	sleep 2
}

# ZRAM Function
zram() {
	echo ""
	echo "	$zram_size_settings" # Use the shared variable here
	echo ""
	echo "[1] Default ZRAM"
	echo "[2] Disable ZRAM"
	echo "[3] 1 GB ZRAM"
	echo "[4] 2 GB ZRAM"
	echo "[5] 3 GB ZRAM"
	echo "[6] 4 GB ZRAM"
	echo "[7] 5 GB ZRAM"
	echo "[8] 6 GB ZRAM"
	echo "[Enter] Back to Menu"
	echo ""
	printf "Select: "
	read -r zram_option

	case "$zram_option" in
	1)
		echo "Applying default ZRAM..."
		;;
	2)
		echo "Disabling ZRAM..."
		swapoff /dev/block/zram0
		echo "0" >/sys/class/zram-control/hot_remove
		;;
	3)
		echo "Setting 1GB ZRAM..."
		swapoff /dev/block/zram0
		echo "1" >/sys/block/zram0/reset
		echo "1024MB" >/sys/block/zram0/disksize
		mkswap /dev/block/zram0
		swapon /dev/block/zram0
		;;
	4)
		echo "Setting 2GB ZRAM..."
		swapoff /dev/block/zram0
		echo "1" >/sys/block/zram0/reset
		echo "2048MB" >/sys/block/zram0/disksize
		mkswap /dev/block/zram0
		swapon /dev/block/zram0
		;;
	5)
		echo "Setting 3GB ZRAM..."
		swapoff /dev/block/zram0
		echo "1" >/sys/block/zram0/reset
		echo "3072MB" >/sys/block/zram0/disksize
		mkswap /dev/block/zram0
		swapon /dev/block/zram0
		;;
	6)
		echo "Setting 4GB ZRAM..."
		swapoff /dev/block/zram0
		echo "1" >/sys/block/zram0/reset
		echo "4096MB" >/sys/block/zram0/disksize
		mkswap /dev/block/zram0
		swapon /dev/block/zram0
		;;
	7)
		echo "Setting 5GB ZRAM..."
		swapoff /dev/block/zram0
		echo "1" >/sys/block/zram0/reset
		echo "5120MB" >/sys/block/zram0/disksize
		mkswap /dev/block/zram0
		swapon /dev/block/zram0
		;;
	8)
		echo "Setting 6GB ZRAM..."
		swapoff /dev/block/zram0
		echo "1" >/sys/block/zram0/reset
		echo "6144MB" >/sys/block/zram0/disksize
		mkswap /dev/block/zram0
		swapon /dev/block/zram0
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$zram_size_settings Updated."
	sleep 2
}

# ZRAM Function
reboot() {
	echo ""
	echo "	$reboot" # Use the shared variable here
	echo ""
	echo "[1] Reboot System"
	echo "[Enter] Back to Menu"
	echo ""
	printf "Select: "
	read -r reboot_option

	case "$reboot_option" in
	1)
		echo "Reboot System..."
		su -c reboot system
		;;
	*)
		echo "Invalid option."
		;;
	esac

	echo "$reboot Updated."
	sleep 2
}


# Step 1: Helper function for help menu
show_help() {
	echo "Help: System Configuration Options"
	echo ""
	echo "[1] $agpu_render_settings - Adjust GPU/CPU render workload for performance or battery efficiency."
	echo "[2] $agpub_render_settings - Boosts GPU/CPU for demanding tasks."
	echo "[3] $fpsgo_enable_settings - Enables FPSGO for smoother gaming."
	echo "[4] $fpsgo_advanced_settings - Advanced FPSGO options."
	echo "[5] $overlays_settings - Disables hardware overlays."
	echo "[6] $render_profile_settings - Choose render profile."
	echo "[7] $render_comp_settings - Render compositing profile for diagnostics."
	echo "[8] $spoofing_settings - Unlock or spoof graphics settings."
	echo "[9] $zram_size_settings - Adjust ZRAM size for memory optimization."
	echo ""
	echo ""
	echo "Press Enter to return to the menu..."
	read -r enter
	echo "$enter"
	unset enter
}

# Step 2: Define shared variables at the top of the script
agpu_render_settings="Advanced GPU/CPU Render Settings (Need Restart)"
agpub_render_settings="Boost GPU/CPU Render Settings (Need Restart)"
fpsgo_enable_settings="Enable Settings FPSGO"
fpsgo_advanced_settings="Enable Advanced Settings FPSGO"
overlays_settings="Disable HW Overlay Settings"
render_profile_settings="Set Profile Renderer (Need Restart)"
render_comp_settings="Render Compositing Profile Settings (Need Restart)"
spoofing_settings="Spoofing Setting/Unlocker Graphics (Need Restart)"
zram_size_settings="ZRAM Size Settings"
reboot="reboot system"

# Step 3: Main loop for the menu
while true; do
	clear
	echo "System Configuration Advanced MTK VEST BLAZE"
	echo ""
	echo "[1] $agpu_render_settings"
	echo "[2] $agpub_render_settings"
	echo "[3] $fpsgo_enable_settings"
	echo "[4] $fpsgo_advanced_settings"
	echo "[5] $overlays_settings"
	echo "[6] $render_profile_settings"
	echo "[7] $render_comp_settings"
	echo "[8] $spoofing_settings"
	echo "[9] $zram_size_settings"
	echo "[10] Info"
	echo "[99] $reboot"
	echo "[0] Exit"
	echo ""
	echo "Reset Settings need Re-install the Modules"
	echo ""

	# Prompt for user input
	printf "Select an option: "
	read -r option

	# Handle options based on user input
	case "$option" in
	"1")
		# Call AGPU settings script
		agpu
		;;

	"2")
		# Call AGPUB settings script
		agpub
		;;

	"3")
		# Call FPSGO settings script
		fpsgo
		;;

	"4")
		# Call FPSGO Advanced settings script
		fpsgoa
		;;

	"5")
		# Call Overlay settings script
		overlays
		;;

	"6")
		# Call Render profile settings script
		renderp
		;;

	"7")
		# Call Render Compositing profile script
		renderc
		;;

	"8")
		# Call Spoofing settings script
		spoofing
		;;

	"9")
		# Call ZRAM size settings script
		zram
		;;

	"10")
		# Show help information
		show_help
		;;

	"99")
		# Show help information
		reboot
		;;

	"0")
		echo "Exiting... Goodbye!"
		sleep 2
		exit 0
		;;

	*)
		echo "Invalid option. Try again."
		sleep 2
		;;
	esac
done
