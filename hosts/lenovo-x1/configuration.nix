{
  pkgs,
  inputs,
  system,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../common.nix
    ../../modules/games/default.nix
  ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lenovo-x1"; # Define your hostname.
  networking.networkmanager.enable = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users.dasbente = import ./home.nix;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services = {
    xserver = {
      enable = true;
      # displayManager.gdm.enable = true;
      # desktopManager.gnome.enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
    };

    logind.settings.Login = {
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

  # games.dwarf-fortress.enable = true;
  
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
      discord-ptb
      steam-run
      pcmanfm

      inputs.helium.defaultPackage.${system}

      # hyprland packages
      swww
      rofi

      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      }))
    ];
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
      ];
    };
    nvidia.modesetting.enable = true;
  };

  console.keyMap = "de";

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {};
    permittedInsecurePackages = [
      "freeimage-unstable-2021-11-01"
    ];
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.dasbente = {
    isNormalUser = true;
    description = "Tobias Möhring";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs.steam.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  fonts.packages = with pkgs; [
    nerd-fonts.roboto-mono
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
