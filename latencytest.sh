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

echo ""
echo "Ethereum Results: "
POOL=Ethermine
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${ER1%?}" "${EC1}" "${EA1}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${ER2%?}" "${EC2}" "${EA2}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${ER3%?}" "${EC3}" "${EA3}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${ER4%?}" "${EC4}" "${EA4}"
POOL=Nanopool
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${NR1%?}" "${NC1}" "${NA1}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${NR2%?}" "${NC2}" "${NA2}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${NR3%?}" "${NC3}" "${NA3}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${NR4%?}" "${NC4}" "${NA4}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${NR5%?}" "${NC5}" "${NA5}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${NR6%?}" "${NC6}" "${NA6}"
printf "%-30s | %-30s | %-30s | %-30s\n" "${POOL}" "${NR7%?}" "${NC7}" "${NA7}"
