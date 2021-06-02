#!/bin/bash

etc-configs() {
	ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
	timedatectl set-ntp true
	hwclock --systohc
	echo "archlinux" >> /mnt/etc/hostname
	echo "127.0.0.1 localhost" >> /mnt/etc/hosts
	echo "::1       localhost" >> /mnt/etc/hosts
	echo "127.0.1.1 archlinux.localdomain archlinux" >> /mnt/etc/hosts
	echo "LANG=en_US.UTF-8" >> /etc/locale.conf
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	echo "en_US ISO-8859-1" >> /etc/locale.gen
	locale-gen
	sleep 10
}

starting-service() {
	systemctl enable NetworkManager
	systemctl start NetworkManager
	systemctl enable gdm
	systemctl enable bluetooth
	systemctl enable cups.service
	systemctl enable sshd
	systemctl enable avahi-daemon
	systemctl enable tlp
	systemctl enable reflector.timer
	systemctl enable fstrim.timer
	systemctl enable libvirtd
	systemctl enable firewalld
	systemctl enable acpid
	sleep 10
}

config-users() {
	useradd -m vijay
	echo root:vijay | chpasswd
	echo vijay:vijay | chpasswd
	usermod -aG libvirt vijay
	echo "vijay ALL=(ALL) ALL" >> /etc/sudoers.d/vijay
	sleep 10
}

install-pkgs() {
	pacman -U --noconfirm /temp/*.pkg.tar.zst
	sleep 10
}

etc-configs
starting-service
config-users
install-pkgs
grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg
sleep 10
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
