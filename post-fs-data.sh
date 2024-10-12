#!/system/bin/sh
echo 1 >/sys/module/ged/parameters/gx_boost_on
echo 1 >/sys/module/ged/parameters/gx_game_mode
echo 1 >/sys/module/ged/parameters/ged_smart_boost
echo 1 >/sys/module/ged/parameters/enable_gpu_boost
echo 1 >/sys/module/ged/parameters/ged_boost_enable
echo 1 >/sys/module/ged/parameters/boost_gpu_enable