#!/bin/bash

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
./PhoenixMiner -pool $POOL -wal $WALLET.$PASSWORD -tt $TT -tstop $TSTOP -tstart $TSTART -cdm 1 -cdmport 5450 $ADDITIONAL
