echo ""
echo "--------------------UFW KONTROLU-------------------"
ufw status
echo ""
echo "---------------------SSH KONTROLU-------------------"
service ssh status
echo ""
echo "--------------------DAGITIM KONTROLU--------------------"
uname -v
echo ""
echo "-------------------KULLANICI KONTROLU--------------------"
groups miskirik
echo ""
echo "--------------------SIFRE POLITIKASI KONTROLU--------------------"
cat /etc/login.defs | grep -E "PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE"
echo ""
echo "--------------------SIFRE OLUSTURMA AYARLARI---------------------"
cat /etc/security/pwquality.conf |grep -E "difok|minlen|dcredit|ucredit|enforce_for_root|enforcing|maxrepeat|usercheck|dictcheck"
echo ""
echo "--------------------MAKINE ADI--------------------"
cat /etc/hostname
echo ""
echo "--------------------SUDO LOG DOSYASI VARLIGI KONTROLU--------------------"
ls  /var/log/sudo
echo ""
echo "--------------------SUDO LOG DOSYASI CIKTISI--------------------"
cat /var/log/sudo/sudo.log
