{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../common.nix
  ];

  nixpkgs.config.packageOverrides = pkgs: {
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "steam-deck"; # Define your hostname.
  networking.networkmanager.enable = true;

  home-manager.users.dasbente = import ./home.nix;

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
    };

    logind = {
      extraConfig = "HandlePowerKey=suspend";
      lidSwitch = "suspend";
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBVA_DRIVER_NAME = "iHD";
    };

    pathsToLink = ["/share/zsh"];

    systemPackages = with pkgs; [
      pkgs.home-manager
      git
      networkmanagerapplet
      firefox-wayland
      discord-ptb
      steam-run

      # hyprland packages
      swww
      rofi-wayland

      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      }))
    ];
  };

  hardware.graphics.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.dasbente = {
    isNormalUser = true;
    description = "Tobias Möhring";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  fonts.packages = with pkgs; [
    nerd-fonts.roboto-mono
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
