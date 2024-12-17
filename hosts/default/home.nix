{...}: {
  imports = [
    ../../home-manager/common.nix
    ../../home-manager/hyprland/config.nix
    ../../home-manager/kitty.nix
  ];

  home.username = "dasbente";
  home.homeDirectory = "/home/dasbente";
  home.stateVersion = "24.11"; # do not touch unless necessary!

  home.file = {
  };

  home.sessionVariables = {
    FLAKE_NAME = "default";
  };

  programs.git = {
    userName = "dasBente";
    userEmail = "dasbente@gmail.com";
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = ["neovide.desktop"];
    "application/pdf" = ["zathura.desktop"];
    "image/*" = ["sxiv.desktop"];
    "video/png" = ["mpv.desktop"];
    "video/jpg" = ["mpv.desktop"];
    "video/*" = ["mpv.desktop"];
  };
}
