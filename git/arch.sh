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
	pacman -Sy --noconfirm archlinux-keyring ;
	pacstrap /mnt base base-devel linux linux-headers linux-firmware xf86-video-nouveau git neovim intel-ucode curl htop neofetch python-pip gawk grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools avahi gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils alsa-utils pulseaudio bash-completion openssh rsync acpi acpi_call tlp iptables-nft ipset firewalld sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font cups reflector polkit udisks2 pulseaudio-bluetooth npm
	genfstab -U /mnt >> /mnt/etc/fstab ;
	cat /mnt/etc/fstab ;
	sleep 20
}

i3_install() {
	pacstrap /mnt xorg i3 dmenu lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings ttf-dejavu ttf-liberation noto-fonts firefox nitrogen picom lxappearance vlc pcmanfm materia-gtk-theme papirus-icon-theme alacritty blueman volumeicon virt-manager qemu qemu-arch-extra ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat awesome rofi picom xclip ttf-roboto polkit-gnome materia-theme lxappearance flameshot network-manager-applet xfce4-power-manager papirus-icon-theme net-tools noto-fonts-emoji noto-fonts noto-fonts-extra
}

gnome_install() {
	pacstrap /mnt xorg gdm gnome gnome-tweaks htop ttf-dejavu ttf-liberation noto-fonts firefox vlc pcmanfm materia-gtk-theme papirus-icon-theme alacritty virt-manager qemu qemu-arch-extra ovmf vde2 ebtables dnsmasq bridge-utils openbsd-netcat
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
	systemctl enable libvirtd
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
	newgrp libvirt
	echo "vijay ALL=(ALL) ALL" >> /etc/sudoers.d/vijay
	printf "\e[1;32m\n********createing user Successfully Done*********\n\e[0m"
	sed -i 's/^#Para/Para/' /etc/pacman.conf
	sleep 10
}


etc-configs
config-users
starting-service
sleep 10
printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
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

de_type() {
	if [[ $DE == GNOME ]] || [[ $DE == 1 ]] || [[ $DE == gnome ]]; then
		printf "\e[1;34m Selected Gnome \n\e[0m"
		gnome_install
	elif [[ $DE == i3 ]] || [[ $DE == 2 ]] || [[ $DE == i3wm ]]; then
		printf "\e[1;34m Selected i3wm \n\e[0m"
		i3_install
	elif [[ $DE == basic ]] || [[ $DE == 3 ]]; then
		printf "\e[1;34m Basic installation completed \e[0m"
	else
		printf "\e[1;34m Invalid option \e[0m"
		exit
	fi
}

de_choose() {
  DIALOG_CANCEL=1
  DIALOG_ESC=255
  HEIGHT=0
  WIDTH=0
  exec 3>&1
  DE=$(dialog \
    --backtitle "Arch Installation" \
    --title "Select Desktop type" \
    --cancel-label "Exit" \
    --menu "Please select:" $HEIGHT $WIDTH 4 \
    "1" "Gnome" \
    "2" "i3wm" \
    "3" "basic" \
    2>&1 1>&3)
    exit_status=$?
  exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
  esac
  case $DE in
	  1 )
		  ;;
	  2 )
		  ;;
	  3 )
		  ;;
  esac

}

uefi_install() {
	uefi_partition
	uefi_makefs
	install_pkgs
	de_type
	chroot_ex
	grub_uefi
	printf "\e[1;35m\n\nUEFI Installation completed \n\e[0m"
}

mbr_install() {
	mbr_partition
	mbr_makefs
	install_pkgs
	de_type
	chroot_ex
	grub_mbr
	printf "\e[1;35m\n\nMBR Installation completed  \e[0m"
}

main() {
  pacman -Sy --noconfirm dialog
  DIALOG_CANCEL=1
  DIALOG_ESC=255
  HEIGHT=0
  WIDTH=0
  exec 3>&1
  selection=$(dialog \
    --backtitle "Arch Installation" \
    --title "Select Firmware type" \
    --cancel-label "Exit" \
    --menu "Please select:" $HEIGHT $WIDTH 4 \
    "1" "UEFI" \
    "2" "MBR" \
    2>&1 1>&3)
    exit_status=$?
  exec 3>&-
    case $exit_status in
    $DIALOG_CANCEL)
      clear
      echo "Program terminated."
      exit
      ;;
    $DIALOG_ESC)
      clear
      echo "Program aborted." >&2
      exit 1
      ;;
  esac
  case $selection in
	  1 )
		  de_choose
		  uefi_install
		  ;;
	  2 )
		  de_choose
		  mbr_install
		  ;;
  esac

}
printf "\e[1;32m*********Arch Scripts Started**********\n\e[0m"
preinstall() {
	echo "-------------------------------------------------"
	echo "Setting up mirrors for optimal download          "
	echo "-------------------------------------------------"
	iso=$(curl -4 ifconfig.co/country-iso)
	timedatectl set-ntp true
	pacman -S --noconfirm pacman-contrib terminus-font
	setfont ter-v22b
	sed -i 's/^#Para/Para/' /etc/pacman.conf
	pacman -S --noconfirm reflector rsync
	mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
	reflector -a 48 -c $iso -f 5 -l 20 --sort rate --save /etc/pacman.d/mirrorlist
}
timedatectl set-ntp true
timedatectl set-timezone Asia/Kolkata
preinstall
main
