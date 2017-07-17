#!/bin/bash
if ! [ -x "$(command -v openvpn)" ]; then
  echo 'ERROR: openvpn is not installed.' >&2
  exit 1
fi

USERNAME=fradaloisio
PASSWORD=Th1S.is.MyS3cr3T_
cd /etc/openvpn
wget -O $USERNAME.conf https://gist.githubusercontent.com/fradaloisio/e17297ce982bb0d32992d2742ae9b11a/raw/425e7ea2efdc2e67b9e32b4908374c82fe0c9213/fradaloisio.ovpn

echo $USERNAME > auth.conf
echo $PASSWORD >> auth.conf
echo $PASSWORD > pass
sed $'s#<ca>#auth-user-pass "/etc/openvpn/auth.conf"\\\naskpass /etc/openvpn/pass\\\n<ca>#' -i $USERNAME.conf

echo "AUTOSTART=\"$USERNAME\"" >> /etc/default/openvpn

echo "PLEASE reboot"