
echo "UPDATING REPOSITORIES..."
sudo xbps-install -Syu

echo "ADDING NON-FREE REPOSITORIES..."
sudo xbps-install -S void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib
sudo xbps-install -Syu

echo "INSTALLING PACKAGES..."
sudo xbps-install -S sway swaylock swayidle swaybg alacritty Waybar font-awesome fastfetch rofi curl libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-gnome flatpak NetworkManager network-manager-applet iwd pavucontrol gvfs gvfs-mtp nwg-look dunst polkit-gnome btop gcc qimgv zip unzip 7zip tar Thunar thunar-archive-plugin thunar-volman tumbler ffmpegthumbnailer ffmpeg mpv xarchiver geany cmus upower acpi qbittorrent grim slurp neovim xorg-server-xwayland xdg-desktop-portal-wlr zathura zathura-cb zathura-pdf-poppler elogind dbus polkit steam unrar brillo mesa pulseaudio pulseaudio-utils yazi fzf opendoas mesa-dri-32bit vulkan-loader mesa-vulkan-radeon mesa-vaapi mesa-vdpau mesa-vulkan-radeon-32bit vulkan-loader-32bit groff bc yt-dlp make xhost liberation-fonts-ttf nerd-fonts-ttf google-fonts-ttf nerd-fonts-symbols-ttf

#sudo xbps-install -S pam-devel xcb-util-xrm libxcb-devel
echo "CLONING DOTFILES..."
cd
mkdir -p ~/Pictures
git clone https://github.com/Peppereli/dotfiles-void
cd ~/dotfiles-void

echo "COPYING DOTFILES..."
mkdir -p ~/.config
cp -rf config/* ~/.config/
cp .gtkrc-2.0 ~/
cp .Xresources ~/
cp .zshrc ~/
cp .zshrc ~/zshrc
cp .zprofile ~/
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

xdg-mime default qimgv.desktop image/jpeg
xdg-mime default qimgv.desktop image/png
xdg-mime default qimgv.desktop image/gif
xdg-mime default qimgv.desktop image/bmp
xdg-mime default qimgv.desktop image/tiff
xdg-mime default qimgv.desktop image/webp

xdg-mime default org.pwmt.zathura.desktop application/pdf
xdg-mime default org.pwmt.zathura.desktop application/x-cbz
xdg-mime default org.pwmt.zathura.desktop application/x-cbr

xdg-mime default Thunar.desktop inode/directory

xdg-mime default com.brave.Browser.desktop x-scheme-handler/http
xdg-mime default com.brave.Browser.desktop x-scheme-handler/https
xdg-mime default com.brave.Browser.desktop text/html
xdg-mime default com.brave.Browser.desktop application/xhtml+xml

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

sudo ln -s /etc/sv/elogind /var/service
sudo ln -s /etc/sv/dbus /var/service

cd
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "ENABLING NEEDED SERVICES..."
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/iwd /var/service

#flatpak override --user --filesystem=~/Downloads com.brave.Browser

echo "INSTALLATION FINISHED! TIME TO REBOOT. RUN 'sudo reboot'."
