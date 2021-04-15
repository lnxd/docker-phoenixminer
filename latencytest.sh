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

EI1=$(dig +short ${EA1} | tail -n1)
EI2=$(dig +short ${EA2} | tail -n1)
EI3=$(dig +short ${EA3} | tail -n1)
EI4=$(dig +short ${EA4} | tail -n1)
NI1=$(dig +short ${NA1} | tail -n1)
NI2=$(dig +short ${NA2} | tail -n1)
NI3=$(dig +short ${NA3} | tail -n1)
NI4=$(dig +short ${NA4} | tail -n1)
NI5=$(dig +short ${NA5} | tail -n1)
NI6=$(dig +short ${NA6} | tail -n1)
NI7=$(dig +short ${NA7} | tail -n1)

EC1=$(curl -s https://ip-api.com/json/${EI1}?fields=country) | jq '.country'
EC2=$(curl -s https://ip-api.com/json/${EI2}?fields=country) | jq '.country'
EC3=$(curl -s https://ip-api.com/json/${EI3}?fields=country) | jq '.country'
EC4=$(curl -s https://ip-api.com/json/${EI4}?fields=country) | jq '.country'
NC1=$(curl -s https://ip-api.com/json/${NI1}?fields=country) | jq '.country'
NC2=$(curl -s https://ip-api.com/json/${NI2}?fields=country) | jq '.country'
NC3=$(curl -s https://ip-api.com/json/${NI3}?fields=country) | jq '.country'
NC4=$(curl -s https://ip-api.com/json/${NI4}?fields=country) | jq '.country'
NC5=$(curl -s https://ip-api.com/json/${NI5}?fields=country) | jq '.country'
NC6=$(curl -s https://ip-api.com/json/${NI6}?fields=country) | jq '.country'
NC7=$(curl -s https://ip-api.com/json/${NI7}?fields=country) | jq '.country'

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
echo "Ethermine  ${ER1%?}  ${EC1}  ${EA1}"
echo "Ethermine  ${ER2%?}  ${EC2}  ${EA2}"
echo "Ethermine  ${ER3%?}  ${EC3}  ${EA3}"
echo "Ethermine  ${ER4%?}  ${EC4}  ${EA4}"
echo "Nanopool   ${NR1%?}  ${NC1}  ${NA1}"
echo "Nanopool   ${NR2%?}  ${NC2}  ${NA2}"
echo "Nanopool   ${NR3%?}  ${NC3}  ${NA3}"
echo "Nanopool   ${NR4%?}  ${NC4}  ${NA4}"
echo "Nanopool   ${NR5%?}  ${NC5}  ${NA5}"
echo "Nanopool   ${NR6%?}  ${NC6}  ${NA6}"
echo "Nanopool   ${NR7%?}  ${NC7}  ${NA7}"
