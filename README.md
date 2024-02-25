My dotfiles will install a fully-featured tiling window manager environment on any Arch Linux based system, with custom theming, gaming on linux, completely keyboard-centric functionality (vim-motions) and a lot more.

## Manual Installing Dotfiles

First you need to install ArchLinux with the `archinstall` script using the **Hyprland** profile.

### Install Yay and Git

To configure and install the other packages and tools, you will have to install yay as the AUR helper and git for version control.

```sh
pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

### Install ASDF, NodeJS and Yarn

Download ASDF from the original repository:

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
```

Add the following to `~/.zshrc`:

```sh
. "$HOME/.asdf/asdf.sh"
```

Add NodeJS to the ASDF plugins list:

```sh
asdf plugin add nodejs
```

Install the latest version:

```sh
asdf install nodejs latest
```

Set the latest version of node globally:

```sh
asdf global nodejs latest
```

Finally install yarn:

```sh
npm --global install yarn
```

### Install Base Packages

For the system to work correctly it's important to have all the following packages installed:

```sh
yay -Syu nvim thunar polkit polkit-gnome cliphist wl-clipboard ripgrep neofetch noto-fonts-emoji noto-fonts ttf-fira-sans ttf-fira-code ttf-firacode-nerd ttf-ia-writer otf-font-awesome ttf-jetbrains-mono-nerd ttf-jetbrains-mono zsh starship oh-my-zsh xdg-ninja kitty wget unzip xdg-user-dirs gtk3 htop slurp grim waybar pavucontrol swaylock swayidle rofi-ibonn-wayland pacseek gum swww ntfs-3g nsxiv mpv zathura corectl
```

### Install NvChad from the original repository

For neovim configuration I use NvChad as a base configuration.

```sh
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
```

### Remove Unused Packages (Optional)

When installing Hyprland from the **archinstall** profile, a lot of unused packages will be installed, so to remove clutter you can remove these packages.

```sh
yay -R dolphin wofi nm-connection-editor
```

```sh
sudo pacman -Rsn $(pacman -Qdtq)
```

### Install Gaming Packages (Optional)

Check the main [source](https://www.reddit.com/r/linux_gaming/comments/knu89x/how_to_set_up_arch_linux_for_gaming_nvidia_intel/)

Enable `multilib` in `/etc/pacman.conf`.

```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Upgrade your system:

```bash
sudo pacman -Syu
```

#### GPU Drivers

You need to install the following gpu drivers depending on which gpu you are using.

##### AMD

```bash
yay -S lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
```

##### NVIDIA

```bash
yay -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
```

##### Intel

```bash
yay -S lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
```

#### Wine Packages

```bash
yay -S wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
```

#### Install Steam and Enable Proton

Open up a Terminal, and run the following command.

```bash
yay -S steam
```

Once installed, run Steam, install any updates, and sign into your Steam account.

Enable Proton to work with all your Steam library by navigating to _Steam / Steam Play / Advanced_, and ticking the Enable Steam Play for all other titles.

Reboot Steam once done.

#### Install Lutris

Open up a Terminal, and run the following command.

```bash
yay -S lutris
```

### Download and Install the dotfiles

First you need to download the dotifles from the git repository:

```shell
git clone git@github.com:alancunha26/Dotfiles.git ~/Dotfiles
```

Then you have to run the following command to _symlink_ these dotfiles into your _/home_ directory.

```shell
cd ~/Dotfiles && stow .
```
