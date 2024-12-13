{ config, pkgs, ... }:

{
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

  programs.neovim = {
    enable = true;

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
      ${builtins.readFile ./nvim/remap.lua}
    '';
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = false;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch --flake ~/dotfiles/nixos/#default";
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "z" "node" "npm" "aliases"];
      theme = "avit";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
