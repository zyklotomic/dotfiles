{pkgs, ...}:

{
  home.file = {
    ".config/ranger/rc.conf".source = ./ranger/rc.conf;
    ".xmonad/xmonad.hs".source = ./xmonad/xmonad.hs;
    ".xmobarrc".source = ./xmonad/.xmobarrc;
    ".config/rofi/config".source = ./rofi/config;
	".config/alacritty/alacritty.yml".source = ./alacritty/alacritty.yml;
  };
}
