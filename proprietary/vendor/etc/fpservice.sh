#!/system/bin/sh
FP_module=`getprop ro.hardware.fingerprint`
HW_module=`getprop ro.config.versatility`

if [ "$FP_module" == 'gx5206' ]; then
	start gx_fpd
elif [ "$FP_module" == 'gx5216' ]; then
	start gx_fpd
fi

if [ "$HW_module" == 'CN' ]; then
	start TEEService
fi
