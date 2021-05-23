## Material Awesome

### Original work by PapyElGringo, official development has moved to [material-shell](https://github.com/PapyElGringo/material-shell)

#### Now I am further developing this project to full extent of my abilities.

An almost desktop environment made with [AwesomeWM](https://awesomewm.org/) following the [Material Design guidelines](https://material.io) with a performant opiniated mouse/keyboard workflow to increase daily productivity and comfort.
![](/theme/eqan-theme/desktop.png)

|              Tiled               |                Panel                 |              Exit screen               |
| :------------------------------: | :----------------------------------: | :------------------------------------: |
| ![](/theme/eqan-theme/tiled.png) | ![](/theme/eqan-theme/menu-open.png) | ![](/theme/eqan-theme/exit-screen.png) |

## Installation

### 1) Get all the dependencies

#### Debian-Based

```
sudo apt install awesome fonts-roboto rofi compton i3lock xclip qt5-style-plugins materia-gtk-theme lxappearance xbacklight flameshot pnmixer ranger policykit-1-gnome grabc rofi-wifi-menu-git  -y

wget -qO- https://git.io/papirus-icon-theme-install | sh
```

#### Arch-Based

```
pacman -S awesome rofi picom i3lock-fancy xclip ttf-roboto polkit-gnome materia-theme lxappearance flameshot pnmixer qt5-styleplugins ranger papirus-icon-theme rofi-wifi-menu-git grabc -y
```

- [AwesomeWM](https://awesomewm.org/) as the window manager - universal package install: awesome
- [Roboto](https://fonts.google.com/specimen/Roboto) as the **font** - Debian: fonts-roboto Arch: ttf-roboto
- [Rofi](https://github.com/DaveDavenport/rofi) for the app launcher - universal install: rofi
- [Picom](https://github.com/yshui/picom) for the compositor (blur and animations) universal install: picom
- [betterlockscreen](https://github.com/pavanjadhaw/betterlockscreen) the lockscreen application Arch Install: betterlockscreen Debian: betterlockscreen
- [Rofi-Wifi-Menu](https://aur.archlinux.org/packages/rofi-wifi-menu-git/) for the wifi menu, extra light and gets the job done
- [xclip](https://github.com/astrand/xclip) for copying screenshots to clipboard package: xclip
- [Parcellite](https://github.com/ZaWertun/parcellite) Clipboard That Manages Your Copy/Paste Content On The Go
- **gnome-keyring** and a **policykit-agent** (by default policykit-1-gnome is enabled) OR mate-polkit
- (Optional) **qt5-styles-gtk2** or **qt5-styleplugins-git** for making QT and KDE applications look the same as gnome applications debian: qt5-style-plugins
- (Optional) [Materia](https://github.com/nana-4/materia-theme) as GTK theme - Arch Install: materia-theme debian: materia-gtk-theme
- (Optional) [Papirus Dark](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme) as icon theme Universal Install: wget -qO- https://git.io/papirus-icon-theme-install | sh
- (Optional) [lxappearance](https://sourceforge.net/projects/lxde/files/LXAppearance/) to set up the gtk and icon theme
- (Optional) [xbacklight](https://www.x.org/archive/X11R7.5/doc/man/man1/xbacklight.1.html) for adjusting brightness on laptops (disabled by default)
- (Optional) [FlameShot](https://github.com/flameshot-org/flameshot) my personal screenshot utility of choice, can be replaced by whichever you want, just remember to edit the screenshot utility script
- (Optional) [GrabC](https://github.com/muquit/grabc) Color Picker Key Combination is Super + Shift + P
- (Optional) [Alacrty](https://github.com/alacritty/alacritty) Default Terminal

### 2) Current Features

- [x] Material Design
- [x] Built-In Native Script Based Widget(wifi, weather, volume, brightness, battery etc)
- [x] Rofi Script based menus, instead of 3rd party applications(which consume alot of resources)
- [x] Keyboard Shortcut driven(Most love dedicated to Vim Keybindings)
- [x] Hybrid Keyboard and Mouse driven experience
- [x] Best of both worlds(Desktop Environment & Window Manager)


### 3) Future Developmental Features

- [ ] Aim: To make window manager that relies less on 3rd party apps and has most of the things built-in natively
- [ ] Tree Tiling: i3 Window Manager Tree Tiling Setup for Awesome.
- [ ] More Functionality To DashBoard
- [ ] Code Optimization
- [ ] Documentation Update


### 4) Clone the configuration

```
git clone https://github.com/eqan/material-awesome.git ~/.config/awesome
```

> Awesome 4.3 is so new that most of the distributions have not updated it yet. If you want to install this config on Awesome 4.2 (current version on depo) use the specific awesome-4.2 branch (not in development by me)

```
git clone -b awesome-4.2 https://github.com/PapyElGringo/material-awesome.git ~/.config/awesome
```

### 5) Set the themes

Start **lxappearance** to active the **icon** theme and **GTK** theme
Note: for cursor theme, edit `~/.icons/default/index.theme` and `~/.config/gtk3-0/settings.ini`, for the change to also show up in applications run as root, copy the 2 files over to their respective place in `/root`.

### 6) Same theme for Qt/KDE applications and GTK applications, and fix missing indicators

First install `qt5-style-plugins` or `qt5-style-gtk2` (debian) | `qt5-styleplugins` (arch) and add this to the bottom of your `/etc/environment`

```bash
XDG_CURRENT_DESKTOP=Unity
QT_QPA_PLATFORMTHEME=gtk2
```

The first variable fixes most indicators (especially electron based ones!), the second tells Qt and KDE applications to use your gtk2 theme set through lxappearance.

### 7) Read the documentation

The documentation live within the source code.

The project is split in functional directories and in each of them there is a readme where you can get additionnal informations about the them.

- [Configuration](./configuration) is about all the **settings** available
- [Layout](./layout) hold the **disposition** of all the widgets
- [Module](./module) contain all the **features** available
- [Theme](./theme) hold all the **aestetic** aspects
- [Widget](./widget) contain all the **widgets** available
