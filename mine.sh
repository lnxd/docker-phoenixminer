#!/bin/bash

DRIVERV=20.20
INSTALLED_DRIVERV=20.19 #$(apt show amdgpu 2>/dev/null | grep Version | sed 's/Version: //g')
if [[ $INSTALLED_DRIVERV != "${DRIVERV}"* ]]; then
	echo "Installed driver version (${INSTALLED_DRIVERV}) does not match wanted driver version (${DRIVERV})"
	echo "Installing AMD drivers v${DRIVERV}:"
	echo ""

	#Assume yes apt
	echo 'APT::Get::Assume-Yes "true";'>> /etc/apt/apt.conf.d/90assumeyes

	case $DRIVERV in

	  0)
	    echo "Skipping installation!"
	    ;;

	  18.20)
	    AMD_DRIVER=amdgpu-pro-18.20-621984.tar.xz
	    AMD_DRIVER_URL=https://drivers.amd.com/drivers/linux/ubuntu-18-04
	    ;;

	  20.20)
	    AMD_DRIVER=amdgpu-pro-20.20-1098277-ubuntu-20.04.tar.xz
	    AMD_DRIVER_URL=https://drivers.amd.com/drivers/linux
	    ;;

	  20.45)
	    AMD_DRIVER=amdgpu-pro-20.45-1188099-ubuntu-20.04.tar.xz
	    AMD_DRIVER_URL=https://drivers.amd.com/drivers/linux
	    ;;
	esac

	if [ $DRIVERV != 0 ]; then
		APT=apt-get
		mkdir -p /tmp/opencl-driver-amd
		cd /tmp/opencl-driver-amd
		echo AMD_DRIVER is $AMD_DRIVER
		curl --referer $AMD_DRIVER_URL -O $AMD_DRIVER_URL/$AMD_DRIVER
		tar -Jxvf $AMD_DRIVER
		rm $AMD_DRIVER
		cd amdgpu-pro-*
		#if driver installed; then
		./amdgpu-install --uninstall
		#fi
		./amdgpu-install --opencl=legacy,pal --headless --no-dkms
		rm -rf /tmp/opencl-driver-amd
		echo ""
		echo "Driver installation finished."
		INSTALLED_DRIVERV=$(apt show amdgpu 2>/dev/null | grep Version | sed 's/Version: //g')
	else
	  echo ""
	fi

	rm /etc/apt/apt.conf.d/90assumeyes
fi

echo ""
cd /home/docker/phoenixminer && ./PhoenixMiner -list | grep "OpenCL driver version" | sed 's/OpenCL driver version: //g'
echo ""

echo "Project: PhoenixMiner $MINERV"
echo "Author:  lnxd"
echo "Base:    $BASE"
echo "Driver:  $INSTALLED_DRIVERV"
echo "Target:  Unraid 6.9.0 - 6.9.2"
echo ""
echo "Wallet:  $WALLET"
echo "Pool:    $POOL"
echo ""
echo "Starting PhoenixMiner $MINERV as $(id) with the following arguments:"
echo "-pool $POOL -wal $WALLET.$PASSWORD -tt $TT  -tstop $TSTOP -tstart $TSTART -cdm 1 -cdmport 5450 $ADDITIONAL"
echo ""
cd /home/docker/phoenixminer
./PhoenixMiner -pool $POOL -wal $WALLET.$PASSWORD -tt $TT  -tstop $TSTOP -tstart $TSTART -cdm 1 -cdmport 5450 $ADDITIONAL