set -e
cd
echo "ADDING NON-FREE AND 32-BIT REPOS..."
sudo xbps-install -S void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib
echo "INSTALLING PACKAGES..."
sudo xbps-install -Syu sway swaylock swayidle swaybg foot gammastep Waybar rofi fzf flatpak NetworkManager network-manager-applet iwd pulsemixer gvfs gvfs-mtp nwg-look dunst polkit-gnome btop gcc gthumb zip unzip 7zip tar Thunar thunar-archive-plugin thunar-volman tumbler ffmpegthumbnailer ffmpeg mpv xarchiver cmus qbittorrent grim slurp neovim xorg-server-xwayland xdg-desktop-portal-wlr zathura zathura-cb zathura-pdf-poppler elogind unrar brillo pipewire wireplumber lf opendoas mesa mesa-dri-32bit groff bc yt-dlp liberation-fonts-ttf noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra nerd-fonts-symbols-ttf firefox zsh zsh-syntax-highlighting zsh-autosuggestions vulkan-loader mesa-vulkan-radeon mesa-vaapi mesa-vdpau mesa-vulkan-radeon-32bit vulkan-loader-32bit acpi wl-clipboard steam telegram-desktop wireshark libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-gnome upower rdfind alsa-pipewire tldr

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

echo "SETTING DEFAULT APPLICATIONS..."
xdg-mime default xarchiver.desktop application/zip
xdg-mime default xarchiver.desktop application/x-tar
xdg-mime default xarchiver.desktop application/x-gzip
xdg-mime default xarchiver.desktop application/x-bzip2
xdg-mime default xarchiver.desktop application/x-xz
xdg-mime default xarchiver.desktop application/x-rar
xdg-mime default xarchiver.desktop application/x-7z-compressed
xdg-mime default org.gnome.gThumb.desktop image/jpeg
xdg-mime default org.gnome.gThumb.desktop image/png
xdg-mime default org.gnome.gThumb.desktop image/gif
xdg-mime default org.gnome.gThumb.desktop image/bmp
xdg-mime default org.gnome.gThumb.desktop image/tiff
xdg-mime default org.gnome.gThumb.desktop image/webp
xdg-mime default org.gnome.gThumb.desktop image/jpg
xdg-mime default org.gnome.gThumb.desktop image/GIF
xdg-mime default org.pwmt.zathura.desktop application/pdf
xdg-mime default org.pwmt.zathura.desktop application/vnd.comicbook-rar
xdg-mime default org.pwmt.zathura.desktop application/vnd.comicbook+zip
xdg-mime default org.pwmt.zathura.desktop application/x-cbz
xdg-mime default org.pwmt.zathura.desktop application/x-cbr
xdg-mime default thunar.desktop inode/directory
gio mime inode/directory thunar.desktop
xdg-mime default firefox.desktop x-scheme-handler/http
xdg-mime default firefox.desktop x-scheme-handler/https
xdg-mime default firefox.desktop text/html
xdg-mime default firefox.desktop application/xhtml+xml
xdg-mime default mpv.desktop video/mpeg
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-matroska
xdg-mime default mpv.desktop video/x-flv
xdg-mime default mpv.desktop video/x-msvideo
xdg-mime default mpv.desktop video/quicktime
xdg-mime default mpv.desktop video/x-wmv
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/3gpp
xdg-mime default mpv.desktop video/ogg
xdg-mime default mpv.desktop audio/mpeg
xdg-mime default mpv.desktop audio/x-wav
xdg-mime default mpv.desktop audio/ogg
xdg-mime default mpv.desktop audio/flac
xdg-mime default mpv.desktop audio/aac
xdg-mime default mpv.desktop audio/mp4
xdg-mime default mpv.desktop audio/x-ms-wma
xdg-mime default mpv.desktop audio/x-aiff
xdg-mime default mpv.desktop audio/opus
xdg-mime default mpv.desktop application/x-ogg
xdg-mime default nvim.desktop text/plain
xdg-mime default nvim.desktop text/markdown
xdg-mime default nvim.desktop application/json
xdg-mime default nvim.desktop application/xml
xdg-mime default nvim.desktop text/x-csrc
xdg-mime default nvim.desktop text/x-c++src
xdg-mime default nvim.desktop text/x-java
xdg-mime default nvim.desktop text/x-python
xdg-mime default nvim.desktop text/x-shellscript
xdg-mime default nvim.desktop application/x-sh
xdg-mime default nvim.desktop text/csv
xdg-mime default nvim.desktop application/yaml
xdg-mime default nvim.desktop text/yaml
xdg-mime default nvim.desktop text/x-log

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
cd ~/.config/
rm -rf wofi
rm -rf alacritty
cd
sudo xbps-remove -oOO

echo "MAKING NEEDED FILES EXECUTABLE..."
find . -type f -print0 | xargs -0 chmod -x
chmod +x ~/.config/sway/exit.sh
chmod +x ~/.config/waybar/powermenu
chmod +x ~/.config/fetch
chmod +x ~/.config/sway/powermenu
echo "INSTALLATION COMPLETE! PLEASE REBOOT THE SYSTEM..."
