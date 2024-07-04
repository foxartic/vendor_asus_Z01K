#!/system/bin/sh
FP_module=`getprop ro.hardware.fingerprint`

if [ "$FP_module" == 'snfp' ]; then
	mkdir /sdcard/fingerprint-log
	cp /data/validity/SynSnsrTest_289_NRSC.log /sdcard/fingerprint-log/SynSnsrTest_289_NRSC.log
	cp /data/validity/SynSnsrTest_289_NRSC_0.bmp /sdcard/fingerprint-log/SynSnsrTest_289_NRSC_0.bmp
	cp /data/validity/SynSnsrTest_289_NRSC_1.bmp /sdcard/fingerprint-log/SynSnsrTest_289_NRSC_1.bmp
	cp /data/validity/SynSnsrTest_289_NRSC_2.bmp /sdcard/fingerprint-log/SynSnsrTest_289_NRSC_2.bmp
	cp /data/validity/SynSnsrTest_289_NRSC_3.bmp /sdcard/fingerprint-log/SynSnsrTest_289_NRSC_3.bmp
	cp /data/validity/SynSnsrTest_289_NRSC_4.bmp /sdcard/fingerprint-log/SynSnsrTest_289_NRSC_4.bmp
	cp /data/validity/SynSnsrTest_289_NRSC_5.bmp /sdcard/fingerprint-log/SynSnsrTest_289_NRSC_5.bmp
	cp /data/validity/SynSnsrTest_289_SNR.log /sdcard/fingerprint-log/SynSnsrTest_289_SNR.log
	cp /data/validity/SynSnsrTest_289_SNR_0.bmp /sdcard/fingerprint-log/SynSnsrTest_289_SNR_0.bmp
	cp /data/validity/SynSnsrTest_289_SNR_1.bmp /sdcard/fingerprint-log/SynSnsrTest_289_SNR_1.bmp
	cp /data/validity/SynSnsrTest_289_SNR_2.bmp /sdcard/fingerprint-log/SynSnsrTest_289_SNR_2.bmp
elif [ "$FP_module" == 'elfp' ]; then
	mkdir /sdcard/fingerprint-log
	cp /data/data/ElanFP_DrvEnroll_Image.txt /sdcard/fingerprint-log/
	cp /data/data/ElanFP_DrvEnroll_Image_8.txt /sdcard/fingerprint-log/
	cp /data/data/ElanFP_DrvGetImage_8.txt /sdcard/fingerprint-log/
	cp /data/data/ElanFP_DrvGet_Image.txt /sdcard/fingerprint-log/
	cp /data/data/ElanFP_DrvVerify_Image.txt /sdcard/fingerprint-log/
	cp /data/data/ElanFP_DrvVerify_Image_8.txt /sdcard/fingerprint-log/
	cp /data/data/ElanFP_cal_Image.txt /sdcard/fingerprint-log/
	cp /data/data/ElanFP_cal_Image_8.txt /sdcard/fingerprint-log/
fi