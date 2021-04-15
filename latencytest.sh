#!/bin/bash
echo "Running tests, this will take around 2 minutes to complete"

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
TA1=eth.2miners.com
TA2=us-eth.2miners.com
TA3=asia-eth.2miners.com

EI1=$(./stratum-ping -c 1 ${EA1}:4444 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
EI2=$(./stratum-ping -c 1 ${EA2}:4444 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
EI3=$(./stratum-ping -c 1 ${EA3}:4444 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
EI4=$(./stratum-ping -c 1 ${EA4}:4444 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
NI1=$(./stratum-ping -c 1 ${NA1}:9999 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
NI2=$(./stratum-ping -c 1 ${NA2}:9999 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
NI3=$(./stratum-ping -c 1 ${NA3}:9999 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
NI4=$(./stratum-ping -c 1 ${NA4}:9999 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
NI5=$(./stratum-ping -c 1 ${NA5}:9999 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
NI6=$(./stratum-ping -c 1 ${NA6}:9999 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
NI7=$(./stratum-ping -c 1 ${NA7}:9999 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
TI1=$(./stratum-ping -c 1 ${TA1}:4444 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
TI2=$(./stratum-ping -c 1 ${TA2}:4444 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")
TI3=$(./stratum-ping -c 1 ${TA3}:4444 | grep PING | sed -e "s/).*//" | sed -e "s/.*(//")

EC1=$(curl -s http://ip-api.com/json/${EI1}?fields=country | jq -r '.country')
EC2=$(curl -s http://ip-api.com/json/${EI2}?fields=country | jq -r '.country')
EC3=$(curl -s http://ip-api.com/json/${EI3}?fields=country | jq -r '.country')
EC4=$(curl -s http://ip-api.com/json/${EI4}?fields=country | jq -r '.country')
NC1=$(curl -s http://ip-api.com/json/${NI1}?fields=country | jq -r '.country')
NC2=$(curl -s http://ip-api.com/json/${NI2}?fields=country | jq -r '.country')
NC3=$(curl -s http://ip-api.com/json/${NI3}?fields=country | jq -r '.country')
NC4=$(curl -s http://ip-api.com/json/${NI4}?fields=country | jq -r '.country')
NC5=$(curl -s http://ip-api.com/json/${NI5}?fields=country | jq -r '.country')
NC6=$(curl -s http://ip-api.com/json/${NI6}?fields=country | jq -r '.country')
NC7=$(curl -s http://ip-api.com/json/${NI7}?fields=country | jq -r '.country')
TC1=$(curl -s http://ip-api.com/json/${TI1}?fields=country | jq -r '.country')
TC2=$(curl -s http://ip-api.com/json/${TI2}?fields=country | jq -r '.country')
TC3=$(curl -s http://ip-api.com/json/${TI3}?fields=country | jq -r '.country')

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
TR1=$(./stratum-ping -c 10 ${TA1}:2020 | tail -1 | awk '{print $4}')
TR2=$(./stratum-ping -c 10 ${TA2}:2020 | tail -1 | awk '{print $4}')
TR3=$(./stratum-ping -c 10 ${TA3}:2020 | tail -1 | awk '{print $4}')

echo ""
printf "%-12s %-15s %-15s %-18s %-30s\n" "Pool" "Geo" "Latency" "IP" "Address"
POOL=Ethermine
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${EC1}" "${ER1%?}" "${EI1}" "${EA1}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${EC2}" "${ER2%?}" "${EI2}" "${EA2}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${EC3}" "${ER3%?}" "${EI3}" "${EA3}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${EC4}" "${ER4%?}" "${EI4}" "${EA4}"
POOL=Nanopool
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${NC1}" "${NR1%?}" "${NI1}" "${NA1}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${NC2}" "${NR2%?}" "${NI2}" "${NA2}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${NC3}" "${NR3%?}" "${NI3}" "${NA3}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${NC4}" "${NR4%?}" "${NI4}" "${NA4}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${NC5}" "${NR5%?}" "${NI5}" "${NA5}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${NC6}" "${NR6%?}" "${NI6}" "${NA6}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${NC7}" "${NR7%?}" "${NI7}" "${NA7}"
POOL=2Miners
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${TC1}" "${TR1%?}" "${TI1}" "${TA1}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${TC2}" "${TR2%?}" "${TI2}" "${TA2}"
printf "%-12s %-15s %-15s %-18s %-30s\n" "${POOL}" "${TC3}" "${TR3%?}" "${TI3}" "${TA3}"
