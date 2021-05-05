
echo root:vijay | chpasswd

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
timedatectl set-ntp true
hwclock --systohc



echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "en_US ISO-8859-1" >> /etc/locale.gen
locale-gen

# pacman --noconfirm --needed -S networkmanager
systemctl enable NetworkManager
systemctl start NetworkManager
systemctl enable gdm
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid


# pacman --noconfirm --needed -S grub && grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg


useradd -m vijay
echo vijay:vijay | chpasswd
usermod -aG libvirt vijay

echo "vijay ALL=(ALL) ALL" >> /etc/sudoers.d/vijay

firewall-cmd --add-port=1025-65535/tcp --permanent
firewall-cmd --add-port=1025-65535/udp --permanent
firewall-cmd --reload

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

