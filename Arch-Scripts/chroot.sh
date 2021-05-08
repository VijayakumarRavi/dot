#!/bin/bash

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
sleep 5
systemctl start NetworkManager
sleep 5
systemctl enable gdm
sleep 5
systemctl enable bluetooth
sleep 5
systemctl enable cups.service
sleep 5
systemctl enable sshd
sleep 5
systemctl enable avahi-daemon
sleep 5
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
sleep 5
systemctl enable reflector.timer
sleep 5
systemctl enable fstrim.timer
sleep 5
systemctl enable libvirtd
sleep 5
systemctl enable firewalld
sleep 5
systemctl enable acpid
sleep 5

# pacman --noconfirm --needed -S grub && grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg


useradd -m vijay
echo vijay:vijay | chpasswd
usermod -aG libvirt vijay

echo "vijay ALL=(ALL) ALL" >> /etc/sudoers.d/vijay

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

