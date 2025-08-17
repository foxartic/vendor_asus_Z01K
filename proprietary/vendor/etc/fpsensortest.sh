#!/system/bin/sh
FP_module=`getprop ro.hardware.fingerprint`
rm /data/data/FingerPrintTest
if [ "$FP_module" == 'snfp' ]; then
    cp /system/bin/synatest /data/data/FingerPrintTest
    chmod 0777 /data/data/FingerPrintTest
elif [ "$FP_module" == 'gxfp3' ]; then
    cp /system/bin/gx_fpcmd /data/data/FingerPrintTest
    chmod 0777 /data/data/FingerPrintTest
elif [ "$FP_module" == 'gxfp5' ]; then
    cp /system/bin/gx_fpcmd /data/data/FingerPrintTest
    chmod 0777 /data/data/FingerPrintTest
fi