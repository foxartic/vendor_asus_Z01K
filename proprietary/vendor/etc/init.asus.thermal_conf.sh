#!/vendor/bin/sh
# Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

# No path is set up at this point so we have to do it here.
#PATH=/sbin:/system/sbin:/system/bin:/system/xbin
#export PATH
export PATH=/vendor/bin

THERMAL_LINK=`getprop sys.create.thermal_link`

if [ "$THERMAL_LINK" == "1" ]; then
	#ASUS_BSP +++ Show_Cai create symbolic link to vadc                                                                                                    
	SOC_PATH="/sys/devices/soc/"
	SEARCH_ASUS_SKIN_THERM="asus_skin_therm"                             
	SEARCH_TOP_CENTER="asus_top_center_therm"
	SEARCH_BOT_CENTER="asus_bot_center_therm"
	SEARCH_PA_THERM="asus_pa_therm"
	SEARCH_DIE_TEMP="asus_die_temp"
	SEARCH_SKIN_TEMP="in_temp_skin_temp_input" 

	therm_check(){
		THERM_FILE=`find $SOC_PATH -name $1`
		if [ -f "$THERM_FILE" ]; then
			ln -s $THERM_FILE $2
			echo "[Thermal] link '$1' to '$2'"
		else
			echo "[Thermal] '$1' not found!!"
		fi
	}

	mkdir -p "/dev/therm/"                                                     
	chmod 755 "/dev/therm/"                                                   
	mkdir -p "/dev/therm/vadc"                                                
	chmod 755 "/dev/therm/vadc"
	therm_check $SEARCH_ASUS_SKIN_THERM "/dev/therm/vadc/asus_skin_temp"
	therm_check $SEARCH_TOP_CENTER "/dev/therm/vadc/asus_top_center_temp"
	therm_check $SEARCH_BOT_CENTER "/dev/therm/vadc/asus_bot_center_temp"
	therm_check $SEARCH_PA_THERM "/dev/therm/vadc/asus_pa_temp"
	therm_check $SEARCH_DIE_TEMP "/dev/therm/vadc/asus_die_temp"
	therm_check $SEARCH_SKIN_TEMP "/dev/therm/vadc/skin_temp"                   

	ln -s /sys/class/thermal/thermal_zone4/mtemp /dev/therm/vadc/msm_therm                                                                         
	#ASUS_BSP --- Show_Cai create symbolic link to vadc  

	#ASUS_BSP +++ Show_Cai create symbolic link for run-in test
	ln -s /system/vendor/bin/thermalAtdTool /data/data/Thermal
	sleep 10
	#ASUS_BSP --- Show_Cai creat symbolic link for run-in test
	setprop sys.create.thermal_link 0
fi

THERMAL_RESET=`getprop sys.thermal_engine.reset`
if [ "$THERMAL_RESET" == "1" ]; then
	stop thermal-engine
	start thermal-engine
	setprop sys.thermal_engine.reset 0
fi

########################################################################
THERMAL_DUMPSYS=`getprop sys.thermal.dumpsys`
if [ "$THERMAL_DUMPSYS" == "1" ]; then
    dumpsys sensorservice | grep -A50 'active connection' >> /data/logcat_log/logcat.txt
    #dumpsys sensorservice | grep -A50 'active connection' >> /proc/kmsg
    sns_dump_pm
    setprop sys.thermal.dumpsys 0
fi

THERMAL_ADSP_RESET_COUNT=`getprop sys.adsp.reset_count`
if [ "$THERMAL_ADSP_RESET_COUNT" == "1" ]; then
    echo 0 > /sys/module/rpm_master_stat/parameters/adsp_sleep_count
    echo 0 > /sys/module/irq_gic_v3/parameters/adsp_irq_continuous_count
    setprop sys.adsp.reset_count 0
fi

THERMAL_ADSP_RESET_SLEEP_COUNT=`getprop sys.adsp.reset.sleep_count`
if [ "$THERMAL_ADSP_RESET_SLEEP_COUNT" == "1" ]; then
    echo 0 > /sys/module/rpm_master_stat/parameters/adsp_sleep_count
    setprop sys.adsp.reset.sleep_count 0
fi

THERMAL_ADSP_AUDIO_LOCK=`getprop sys.adsp.audio_lock`
if [ "$THERMAL_ADSP_AUDIO_LOCK" == "1" ]; then
    echo 1 > /proc/audio_lock
    setprop sys.adsp.audio_lock off
elif [ "$THERMAL_ADSP_AUDIO_LOCK" == "0" ]; then
    echo 0 > /proc/audio_lock
    setprop sys.adsp.audio_lock off
fi
