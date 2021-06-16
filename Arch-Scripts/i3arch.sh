#!/bin/bash

uefi_partition() {
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

uefi_makefs() {
	clear
	echo "Make and Mounting partition"
	mkfs.ext4 /dev/sda3
	mkfs.fat -F32 /dev/sda1
	mkswap /dev/sda2
	swapon /dev/sda2
	mount /dev/sda3 /mnt
	mkdir -p /mnt/boot/efi
	mount /dev/sda1 /mnt/boot/efi
	lsblk
	sleep 10
	if [[ -b /dev/sdb1 ]]; then
		echo "Home partition Already exist"
		mkdir -p /mnt/home
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
		mkfs.ext4 /dev/sdb1
		mount /dev/sdb1 /mnt/home
	else
		echo "Home disk not found"
	fi
	lsblk
	sleep 20
}

mbr_partition() {
	clear
	echo "Creating ROOT partition"
	cat <<EOF | fdisk /dev/sda
o
n
p


+200M
n
p


+2G
n
p



n
p


w
EOF
	partprobe
	lsblk
	sleep 10
}

mbr_makefs() {
	clear
	echo "Make and Mounting partition"
	mkfs.ext4 /dev/sda3
	mkfs.ext4 /dev/sda1
	mkswap /dev/sda2
	swapon /dev/sda2
	mount /dev/sda3 /mnt
	mkdir -p /mnt/boot
	mount /dev/sda1 /mnt/boot
	lsblk
	sleep 10
	if [[ -b /dev/sdb1 ]]; then
		echo "Home partition Already exist"
		mkdir -p /mnt/home
		mount /dev/sdb1 /mnt/home
	elif [[ -b /dev/sdb ]]; then
		clear
		echo "Creating home partition"
		cat <<EOF | fdisk /dev/sdb
o
n
p



w
EOF
		partprobe
		mkdir /mnt/home
		mkfs.ext4 /dev/sdb1
		mount /dev/sdb1 /mnt/home
	else
		echo "Home disk not found"
	fi
	lsblk
	sleep 20
}


install_pkgs() {
	clear
	echo "Installing Required packages"
	pacman -Sy --noconfirm archlinux-keyring
	pacstrap /mnt base base-devel linux linux-headers linux-firmware xf86-video-nouveau git neovim intel-ucode curl htop neofetch python-pip gawk grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools avahi gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pulseaudio bash-completion openssh rsync acpi acpi_call tlp iptables-nft ipset firewalld sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font cups reflector polkit udisks2 pulseaudio-bluetooth npm
	genfstab -U /mnt >> /mnt/etc/fstab ;
	cat /mnt/etc/fstab ;
	sleep 20
}

i3_install() {
	pacstrap /mnt xorg i3 dmenu lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings ttf-dejavu ttf-liberation noto-fonts firefox nitrogen picom lxappearance vlc pcmanfm materia-gtk-theme papirus-icon-theme alacritty blueman volumeicon
}

gnome_install() {
	pacstrap /mnt xorg gdm gnome gnome-tweaks htop ttf-dejavu ttf-liberation noto-fonts firefox vlc pcmanfm materia-gtk-theme papirus-icon-theme alacritty
}

chroot_ex() {
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
	echo "Enableing Services "
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
	systemctl enable libvertd
	systemctl enable lightdm
	systemctl enable gdm
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



kvm-install() {
	clear
	echo "Installing Kvm"
	pacman -S --noconfirm virt-manager qemu qemu-arch-extra ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat
}

etc-configs
i3-install
kvm-install
config-users
starting-service
sleep 10
#printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
EOF
}

grub_uefi() {
	cat <<EOF | arch-chroot /mnt bash
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB  && grub-mkconfig -o /boot/grub/grub.cfg
EOF
}

grub_mbr() {
	cat <<EOF | arch-chroot /mnt bash
grub-install --target=i386-pc /dev/sda && grub-mkconfig -o /boot/grub/grub.cfg
EOF
}

env_type() {
	if [[ $DE == GNOME ]] || [[ $DE == 1 ]] || [[ $DE == gnome ]]; then
		printf "\e[1;34m Selected Gnome \n\e[0m"
		gnome_install
	elif [[ $DE == i3 ]] || [[ $DE == 2 ]] || [[ $DE == i3wm ]]; then
		printf "\e[1;34m Selected i3wm \n\e[0m"
		i3_install
	elif [[ $DE == basic ]] || [[ $DE == 3 ]]; then
		printf "\e[1;34m Basic installation completed \e[0m"
		exit
	else
		printf "\e[1;34m Invalid option \e[0m"
		exit
	fi
}

uefi_install() {
	uefi_partition
	uefi_makefs
	install_pkgs
	env_type
	chroot_ex
	grub_uefi
	printf "\e[1;35m\n\n Installation completed \n\e[0m"
}

mbr_install() {
	mbr_partition
	mbr_makefs
	install_pkgs
	env_type
	chroot_ex
	grub_mbr
	printf "\e[1;35m\n\n Installation completed  \e[0m"
}

main() {
	clear
	printf "\e[1;33m Select System Type \n\e[0m"
	printf "\e[1;33m 1.UEFI \n\e[0m"
	printf "\e[1;33m 2.MBR \n\e[0m"
	read -p " Enter your system type: " opt
	clear
	printf "\e[1;34m Select Desktop Environment \n\e[0m"
	printf "\e[1;34m 1.Gnome \n\e[0m"
	printf "\e[1;34m 2.i3wm \n\e[0m"
	printf "\e[1;34m 3.basic \n\e[0m"
	read -p " Enter your DE type: " DE

	if [[ $opt == UEFI ]] || [[ $opt == 1 ]] || [[ $opt == uefi ]]; then
		printf "\e[1;33m Selected UEFI mode \e[0m"
		system="uefi"
		uefi_install
	elif [[ $opt == MBR ]] || [[ $opt == 2 ]] || [[ $opt == mbr ]]; then
		printf "\e[1;33m Selected MBR mode \e[0m"
		system="mbr"
		mbr_install
	else
		printf "\e[1;33m Invalid option \e[0m"
		exit
	fi
}

printf "\e[1;32m*********Arch Scripts Started**********\n\e[0m"
timedatectl set-ntp true
main

