
if [ "$1" == "" ]; then
	echo "No mode specified, determining from /proc/cmdline"
	cmdline=$(cat /proc/cmdline)
else
	cmdline=$1
fi

if [[ ${cmdline} == *"nvidia"* ]]; then
	echo "Starting NVIDIA gpu!"
	cp /opt/scripts/optimus_configs/optimus-manager.conf.nvidia /usr/share/optimus-manager.conf
else
	echo "Disabling NVIDIA gpu and using integrated!"
	cp /opt/scripts/optimus_configs/optimus-manager.conf.integrated /usr/share/optimus-manager.conf
fi
