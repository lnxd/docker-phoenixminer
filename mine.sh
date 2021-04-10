#!/bin/bash

DRIVERV=20.20
INSTALLED_DRIVERV=$(apt show amdgpu-pro 2>/dev/null | grep Version | sed 's/Version: //g')
#if [[ $INSTALLED_DRIVERV == "${DRIVERV}"* ]]; then
echo "Installing AMD drivers v${DRIVERV}:"
echo ""

#Force yes apt
echo 'APT::Get::Assume-Yes "true";
APT::Get::force-yes "true";'>> /etc/apt/apt.conf.d/90forceyes

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

  20.20)
    AMD_DRIVER=amdgpu-pro-20.45-1188099-ubuntu-20.04.tar.xz
    AMD_DRIVER_URL=https://drivers.amd.com/drivers/linux
    ;;
esac

if [ $DRIVERV != 0 ]; then
	mkdir -p /tmp/opencl-driver-amd
	cd /tmp/opencl-driver-amd
	echo AMD_DRIVER is $AMD_DRIVER
	curl --referer $AMD_DRIVER_URL -O $AMD_DRIVER_URL/$AMD_DRIVER
	tar -Jxvf $AMD_DRIVER
	ls -lh
	rm $AMD_DRIVER
	cd amdgpu-pro-*
	#if driver installed; then
	./amdgpu-install --uninstall
	#fi
	./amdgpu-install --opencl=legacy,pal --headless
	apt-get install opencl-amdgpu-pro -y
	rm -rf /tmp/opencl-driver-amd
	echo ""
	echo "Driver installation finished."
	INSTALLED_DRIVERV=$(apt show amdgpu-pro 2>/dev/null | grep Version | sed 's/Version: //g')
else
  echo ""
fi
#fi

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