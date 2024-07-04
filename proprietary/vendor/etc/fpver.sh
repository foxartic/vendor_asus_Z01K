#!/system/bin/sh
FPver_Alg=`getprop goodix.version.alg`
FPver_Cfg=`getprop goodix.version.cfg`
FPver_fw=`getprop goodix.version.fw`
FPver_hal=`getprop goodix.version.hal`
FPver_serv=`getprop goodix.version.serv`
FPver_ta=`getprop goodix.version.ta`

final_ver="$FPver_Alg"__"$FPver_serv"__"$FPver_fw"__"$FPver_hal"__"$FPver_ta"

setprop fp.version.driver "$final_ver"