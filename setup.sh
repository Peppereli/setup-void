set -e
cd
echo "ADDING NON-FREE AND 32-BIT REPOS..."
sudo xbps-install -S void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib
echo "INSTALLING PACKAGES..."
sudo xbps-install -Syu sway swaylock swayidle swaybg foot gammastep Waybar rofi fzf flatpak NetworkManager iwd pulsemixer gvfs gvfs-mtp nwg-look dunst polkit-gnome btop gcc zip unzip 7zip tar Thunar thunar-archive-plugin thunar-volman tumbler ffmpegthumbnailer ffmpeg sxiv mpv xarchiver cmus qbittorrent grim slurp neovim xorg-server-xwayland xdg-desktop-portal-wlr zathura zathura-cb zathura-pdf-poppler elogind unrar brillo pipewire wireplumber lf opendoas mesa mesa-dri-32bit groff bc yt-dlp liberation-fonts-ttf noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra nerd-fonts-symbols-ttf firefox zsh zsh-syntax-highlighting zsh-autosuggestions vulkan-loader mesa-vulkan-radeon mesa-vaapi mesa-vdpau mesa-vulkan-radeon-32bit vulkan-loader-32bit acpi wl-clipboard steam telegram-desktop wireshark libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-gnome upower rdfind alsa-pipewire tldr

echo "SETTING UP DOTFILES..."
mkdir -p ~/Pictures
mkdir -p ~/Documents
mkdir -p ~/movi
mkdir -p ~/Music
git clone https://github.com/Peppereli/dotfilesvoid
cd ~/dotfilesvoid
cp -r "." ~/
cd
echo "UPDATING FONT CACHE..."
fc-cache -f -v

echo "DEFAULTING TO ZSH..."
sudo chsh -s $(which zsh) $USER

echo "ENABLING NEEDED SERVICES..."
sudo ln -s /etc/sv/elogind /var/service
sudo ln -s /etc/sv/dbus /var/service
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
sudo mkdir -p /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/iwd /var/service
sudo rm /var/service/wpa_supplicant
sudo rm /var/service/udevd

echo "CLEANING UP FILES..."
rm -rf ~/.git
cd
sudo xbps-remove -oOO
echo "MAKING NEEDED FILES EXECUTABLE..."
#find . -type f -print0 | xargs -0 chmod -x
chmod +x ~/.config/sway/exit.sh
chmod +x ~/.config/waybar/powermenu
chmod +x ~/.config/fetch
chmod +x ~/.config/sway/powermenu
echo "INSTALLATION COMPLETE! PLEASE REBOOT THE SYSTEM..."
