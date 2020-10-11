{pkgs, ...}:

{
  # home.packages = [
  #   pkgs.ranger
  #   pkgs.python3
  #   pkgs.screen
  #   pkgs.bat
  #   pkgs.feh
  #   pkgs.rofi
  #   pkgs.zathura
  #   pkgs.gcc
  #   pkgs.ghc
  #   pkgs.tmux
  #   pkgs.qutebrowser
  #   my-texlive
  # ];
  home.packages = [
    pkgs.zathura
  ];

  programs.texlive.enable = true;
  programs.texlive.extraPackages = tpkgs: {
    inherit (tpkgs)
      scheme-medium
      titlesec
      enumitem
      preprint;
  };


  home.file = {
    ".config/ranger/rc.conf".source = ./ranger/rc.conf;
    ".config/rofi/config".source = ./rofi/config;
    ".config/alacritty/alacritty.yml".source = ./alacritty/alacritty.yml;

    # xmonad
    ".xmonad/xmonad.hs".source = ./xmonad/xmonad.hs;
    ".xmobarrc".source = ./xmonad/xmobarrc.hs;

    # xorg
    ".Xresources".source = ./xorg/Xresources;
    # ".xinitrc".source = ./xorg/xinitrc;

    # (n)vim
    ".vimrc".source = ./vim/vim.vimrc;
    ".config/nvim/init.vim".source = ./vim/init.vim;

    # startx
    ".xprofile".text = "feh --bg-fill /home/ethan/Pictures/current_wallpaper.png & picom -b & urxvt &";
  };
}
