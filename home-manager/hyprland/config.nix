{...}: {
  services.dunst.enable = true;

  home = {
    sessionVariables.NIXOS_OZONE_WL = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
