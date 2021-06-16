#!/bin/bash

partition() {
	clear
	echo "Creating ROOT partition"
	cat <<EOF | gdisk /dev/sda
o
y
n


+200M
ef00
n


+2G
8200
n



n


w
y
EOF
	partprobe
	lsblk
	sleep 10
}

makefs() {
	clear
	echo "Make and Mounting partition"
	mkfs.ext4 /dev/sda3
	mkfs.fat -F32 /dev/sda1
	mkswap /dev/sda2
	swapon /dev/sda2
	mount /dev/sda3 /mnt
	mkdir -p /mnt/boot/efi
	mount /dev/sda1 /mnt/boot/efi
	sleep 10
	if [[ -b /dev/sdb1 ]]; then
		echo "Home partition Already exist"
		mkdir /mnt/home
		mount /dev/sdb1 /mnt/home
	elif [[ -b /dev/sdb ]]; then
		clear
		echo "Creating home partition"
		cat <<EOF | gdisk /dev/sdb
o
y
n
p



w
y
EOF
		partprobe
		mkdir /mnt/home
		mount /dev/sdb1 /mnt/home
	else
		echo "Home disk not found"
	fi
	lsblk
	sleep 20
}

install-pkgs() {
	clear
	echo "Installing Required packages"
	pacman -Sy --noconfirm archlinux-keyring
	pacstrap /mnt base base-devel linux linux-headers linux-firmware xf86-video-nouveau git neovim intel-ucode curl htop neofetch python-pip gawk grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools avahi gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pulseaudio bash-completion openssh rsync acpi acpi_call tlp iptables-nft ipset firewalld sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font cups reflector polkit udisks2 pulseaudio-bluetooth npm
	genfstab -U /mnt >> /mnt/etc/fstab ;
	cat /mnt/etc/fstab ;
	sleep 20
}

chroot-ex() {
	cat <<EOF | arch-chroot /mnt bash
#!/bin/bash
printf "\e[1;32m\n*********CHROOT Scripts Started**********\n\e[0m"
etc-configs() {
	clear
	echo "editing config files"
	ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
	timedatectl set-ntp true
	hwclock --systohc
	echo "archlinux" >> /etc/hostname
	echo "127.0.0.1 localhost" >> /etc/hosts
	echo "::1       localhost" >> /etc/hosts
	echo "127.0.1.1 archlinux.localdomain archlinux" >> /etc/hosts
	echo "LANG=en_US.UTF-8" >> /etc/locale.conf
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	echo "en_US ISO-8859-1" >> /etc/locale.gen
	locale-gen
	sleep 10
}

starting-service() {
	clear
	echo "Enableing Services \n\n"
	systemctl enable NetworkManager
	systemctl enable bluetooth
	systemctl enable cups.service
	systemctl enable sshd
	systemctl enable avahi-daemon
	systemctl enable tlp
	systemctl enable reflector.timer
	systemctl enable fstrim.timer
	systemctl enable firewalld
	systemctl enable acpid
	systemctl enable lightdm
	systemctl enable libvertd
	sleep 10
}

config-users() {
	printf "\e[1;32m\n********createing user vijay*********\n\e[0m"
	useradd -m vijay
	echo root:vijay | chpasswd
	echo vijay:vijay | chpasswd
	usermod -aG libvirt vijay
	echo "vijay ALL=(ALL) ALL" >> /etc/sudoers.d/vijay
	printf "\e[1;32m\n********createing user Successfully Done*********\n\e[0m"
	sleep 10
}

i3-install() {
	clear
	echo "Installing i3wm"
	pacman -S xorg i3 dmenu lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings ttf-dejavu ttf-liberation noto-fonts firefox nitrogen picom lxappearance vlc pcmanfm materia-gtk-theme papirus-icon-theme alacritty blueman volumeicon
}

kvm-install() {
	clear
	echo "Installing Kvm"
	pacman -S virt-manager qemu qemu-arch-extra ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat
}

etc-configs
config-users
i3-install
kvm-install
starting-service
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB  && grub-mkconfig -o /boot/grub/grub.cfg
sleep 10
#printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
EOF
}
printf "\e[1;32m*********Arch Scripts Started**********\n\e[0m"
timedatectl set-ntp true
partition
makefs
mountfs
install-pkgs
chroot-ex

