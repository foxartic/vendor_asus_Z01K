#!/system/bin/sh


SpeakerCalibrationTest 1> /dev/null 2>&1
if [ "$?" == "0" ]; then
	result=`cat /factory/cal_s_speaker0_log.txt`
	if [ "$result" != "0" ] && [ "$result" != "" ]; then
		echo "PASS"
	else
		echo "FAIL:: no calibration log txt after calibration"
	fi
else
    echo "FAIL"
fi
