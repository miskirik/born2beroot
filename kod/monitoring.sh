isletim=$(uname -a)
fizikselIslemci=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
sanalIslemci=$(grep "^processor" /proc/cpuinfo | wc -l)
kulRam=$(free -m | awk '$1 == "Mem:" {print $3}')
topRam=$(free -m | awk '$1 == "Mem:" {print $2}')
yuzdeRam=$(free | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')
kulDisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
topDisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
yuzdeDisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
kulIslemci=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
sonGiris=$(who -b | awk '$1 == "system" {print $3 " " $4}')
lvmSayisi=$(lsblk | grep "lvm" | wc -l)
bilgiLvm=$(if [ $lvmSayisi -eq 0 ]; then echo no; else echo yes; fi)
tcpBaglantilari=$(cat /proc/net/sockstat{,6} | awk '$1 == "TCP:" {print $3}')
aktifBaglantilar=$(users | wc -w)
ipAdresi=$(hostname -I)
macAdresi=$(ip link show | awk '$1 == "link/ether" {print $2}')
sudoKullanimi=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "
-----------------------------------------------------------------------------------------------------------------
|Mimari Bilgileri       |$isletim
-----------------------------------------------------------------------------------------------------------------
|Fiziksel islemci       |$fizikselIslemci
-----------------------------------------------------------------------------------------------------------------
|Sanal islemci          |$sanalIslemci
-----------------------------------------------------------------------------------------------------------------
|Ram Bilgisi            |$kulRam/$topRam MB ($yuzdeRam%)
-----------------------------------------------------------------------------------------------------------------
|Disk Bilgisi           |$kulDisk/$topDisk GB ($yuzdeDisk%)
-----------------------------------------------------------------------------------------------------------------
|Islemci Kullanimi      |$kulIslemci
-----------------------------------------------------------------------------------------------------------------
|Son giris              |$sonGiris
-----------------------------------------------------------------------------------------------------------------
|LVM Kullanimi          |$bilgiLvm
-----------------------------------------------------------------------------------------------------------------
|TCP Bilgisi            |$tcpBaglantilari ESTABLISHED
-----------------------------------------------------------------------------------------------------------------
|Aktif Oturum Sayisi    |$aktifBaglantilar
-----------------------------------------------------------------------------------------------------------------
|Baglanti Bilgileri     |IP:$ipAdresi MAC:($macAdresi)
-----------------------------------------------------------------------------------------------------------------
|Sudo Kullanim Bilgileri|$sudoKullanimi cmd
-----------------------------------------------------------------------------------------------------------------
"
