apt install lrzsz -y
apt remove ufw -y
apt install pptpd -y
service pptpd stop
cp vpn/pptpd.conf /etc/pptpd.conf
cp vpn/options /etc/ppp/options
cp vpn/pptpd-options /etc/ppp/pptpd-options
cp vpn/chap-secrets /etc/ppp/chap-secrets
cp vpn/sysctl.conf /etc/sysctl.conf
sysctl -p
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o enp1s0 -j MASQUERADE
iptables -I FORWARD -s 192.168.0.0/24 -p tcp --syn -i ppp+ -j TCPMSS --set-mss 1300
service pptpd start
