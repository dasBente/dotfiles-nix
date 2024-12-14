{ pkgs, ... }:
{
  imports = [
    ./nvim/config.nix
  ];

  home.username = "dasbente";
  home.homeDirectory = "/home/dasbente";
  home.stateVersion = "24.11"; # do not touch unless necessary!

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "dasBente";
    userEmail = "dasbente@gmail.com";
    extraConfig = {
      push = { autoSetupRemote = true; };
      core = { editor = "nvim"; };
      init = { defaultBranch = "main"; };
    };
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "image/*" = [ "sxiv.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = false;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch --flake /home/$USER/dotfiles#default";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "z" "node" "npm" "aliases"];
      theme = "avit";
    };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    
    plugins = with pkgs.tmuxPlugins; [
      sensible
      power-theme
    ];

    extraConfig = ''
    set-option -g status-position top
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
