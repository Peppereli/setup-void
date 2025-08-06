
echo "UPDATING REPOSITORIES..."
sudo xbps-install -Syu

echo "ADDING NON-FREE REPOSITORIES..."
sudo xbps-install -S void-repo-nonfree void-repo-multilib-nonfree
sudo xbps-install -Syu

echo "INSTALLING PACKAGES..."
sudo xbps-install -S sway swaylock swayidle swaybg swayimg alacritty Waybar wofi font-awesome fastfetch rofi curl libreoffice ModemManager NetworkManager network-manager-applet iwd bleachbit pavucontrol gvfs gvfs-mtp nwg-look dunst xfce-polkit btop gcc zsh sxiv zip unzip 7zip tar Thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler ffmpegthumbnailer mpv xarchiver geany cmus upower qbittorrent grim slurp neovim pipewire wireplumber xorg-server-xwayland xdg-desktop-portal-wlr zathura zathura-cb zathura-pdf-poppler noto-fonts-ttf noto-fonts-emoji elogind polkit-elogind dbus-elogind acpilight xorg-font alsa-pipewire libjack-pipewire rtkit steam unrar

#sudo xbps-install -S pam-devel xcb-util-xrm libxcb-devel

#echo "ADDING FLATHUB REPOSITORY"
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "CLONING DOTFILES..."
cd
git clone https://github.com/Peppereli/dotfiles-deb
cd ~/dotfiles-deb

echo "COPYING DOTFILES..."
mkdir -p ~/.config
cp -rf config/* ~/.config/
cp .gtkrc-2.0 ~/
cp .Xresources ~/
cp .zshrc ~/zshrc
chmod +x ~/.config/sway/exit.sh
chmod +x ~/.config/sway/audio.sh
cd
echo "CLEANING DOTFILES CLONE..."
rm -rf ~/dotfiles-void

echo "CLONING FONTS..."
git clone https://github.com/Peppereli/fonts
cd
echo "COPYING FONTS..."
sudo cp -rf ~/fonts/* /usr/share/fonts/

echo "UPDATING FONT CACHE..."
fc-cache -f -v

echo "CLEANING FONTS CLONE..."
rm -rf ~/fonts

echo "INSTALLING BRAVE BROWSER..."
curl -fsS https://dl.brave.com/install.sh | sh

echo "CLONING NVCHAD..."
git clone -b v2.0 https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
echo "TO INSTALL NVCHAD RUN 'nvim' AND LET IT INSTALL THE PLUGINS"

echo "CLONING GTK THEMES..."
git clone https://github.com/Peppereli/themes
cd ~/themes

echo "EXTRACTING GTK THEMES..."
7z x themes.7z

echo "COPYING GTK THEMES..."
sudo cp -rf ~/themes/themes/* /usr/share/themes/
sudo cp -rf ~/themes/icons/* /usr/share/icons/
cd

echo "UPDATING ICON CACHE..."
gtk-update-icon-cache

echo "CLEANING THEMES CLONE..."
rm -rf ~/themes

echo "CHANGING THE SHELL TO ZSH..."
sudo chsh -s $(which zsh) $USER


echo "SETTING DEFAULT APPLICATIONS..."
xdg-mime default xarchiver.desktop application/zip
xdg-mime default xarchiver.desktop application/x-tar
xdg-mime default xarchiver.desktop application/x-gzip
xdg-mime default xarchiver.desktop application/x-bzip2
xdg-mime default xarchiver.desktop application/x-xz
xdg-mime default xarchiver.desktop application/x-rar
xdg-mime default xarchiver.desktop application/x-7z-compressed

xdg-mime default sxiv.desktop image/jpeg
xdg-mime default sxiv.desktop image/png
xdg-mime default sxiv.desktop image/gif
xdg-mime default sxiv.desktop image/bmp
xdg-mime default sxiv.desktop image/tiff
xdg-mime default sxiv.desktop image/webp

xdg-mime default org.pwmt.zathura.desktop application/pdf
xdg-mime default org.pwmt.zathura.desktop application/x-cbz
xdg-mime default org.pwmt.zathura.desktop application/x-cbr

xdg-mime default Thunar.desktop inode/directory

xdg-mime default brave-browser.desktop x-scheme-handler/http
xdg-mime default brave-browser.desktop x-scheme-handler/https
xdg-mime default brave-browser.desktop text/html
xdg-mime default brave-browser.desktop application/xhtml+xml

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
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/iwd /var/service

sudo xbps-remove -R foot xterm

echo "INSTALLATION FINISHED! TIME TO REBOOT. RUN 'sudo reboot'."
