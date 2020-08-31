{pkgs, ...}:

{

  services = {
    picom.enable = false;
  };

  home.file = {
    ".config/ranger/rc.conf".source = ./ranger/rc.conf;
    ".config/rofi/config".source = ./rofi/config;
    ".config/alacritty/alacritty.yml".source = ./alacritty/alacritty.yml;
	
	# xmonad
    ".xmonad/xmonad.hs".source = ./xmonad/xmonad.hs;
    ".xmobarrc".source = ./xmonad/xmobarrc.hs; 

	# xorg
	".XResources".source = ./xorg/Xresources;

	# (n)vim
    ".vimrc".source = ./vim/vim.vimrc;
    ".config/nvim/init.vim".source = ./vim/init.vim;

	# startx
	".xprofile".text = "feh --bg-fill /home/ethan/Pictures/current_wallpaper.png & picom -b";
  };
}
