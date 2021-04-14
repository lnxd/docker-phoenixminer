#!/bin/bash
echo "Running tests, this will take around 2 minutes to complete"
echo ""

EA1=us1.ethermine.org
EA2=us2.ethermine.org
EA3=asia1.ethermine.org
EA4=eu1.ethermine.org
NA1=eth-us-east1.nanopool.org
NA2=eth-us-west1.nanopool.org
NA3=eth-eu1.nanopool.org
NA4=eth-eu2.nanopool.org
NA5=eth-asia1.nanopool.org
NA6=eth-jp1.nanopool.org
NA7=eth-au1.nanopool.org

ER1=$(./stratum-ping -c 10 ${EA1}:4444 | tail -1 | awk '{print $4}')
ER2=$(./stratum-ping -c 10 ${EA2}:4444 | tail -1 | awk '{print $4}')
ER3=$(./stratum-ping -c 10 ${EA3}:4444 | tail -1 | awk '{print $4}')
ER4=$(./stratum-ping -c 10 ${EA4}:4444 | tail -1 | awk '{print $4}')
NR1=$(./stratum-ping -c 10 ${NA1}:9999 | tail -1 | awk '{print $4}')
NR2=$(./stratum-ping -c 10 ${NA2}:9999 | tail -1 | awk '{print $4}')
NR3=$(./stratum-ping -c 10 ${NA3}:9999 | tail -1 | awk '{print $4}')
NR4=$(./stratum-ping -c 10 ${NA4}:9999 | tail -1 | awk '{print $4}')
NR5=$(./stratum-ping -c 10 ${NA5}:9999 | tail -1 | awk '{print $4}')
NR6=$(./stratum-ping -c 10 ${NA6}:9999 | tail -1 | awk '{print $4}')
NR7=$(./stratum-ping -c 10 ${NA7}:9999 | tail -1 | awk '{print $4}')

echo "Ethereum Results: "
echo "Ethermine US East     ${ER1%?}  ${EA1}"
echo "Ethermine US West     ${ER2%?}  ${EA2}"
echo "Ethermine Singapore   ${ER3%?}  ${EA3}"
echo "Ethermine Europe      ${ER4%?}  ${EA4}"
echo "Nanopool Canada       ${NR1%?}  ${NA1}"
echo "Nanopool California   ${NR2%?}  ${NA2}"
echo "Nanopool Netherlands  ${NR3%?}  ${NA3}"
echo "Nanopool France       ${NR4%?}  ${NA4}"
echo "Nanopool Canada       ${NR5%?}  ${NA5}"
echo "Nanopool Japan        ${NR6%?}  ${NA6}"
echo "Nanopool Sydney       ${NR7%?}  ${NA7}"
