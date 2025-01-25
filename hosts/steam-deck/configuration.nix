{
  pkgs,
  inputs,
  ...
}: 
{
  imports = [
    ./hardware-configuration.nix
    (
      let
        sha = "sha256:0nx81cb7lwn7d2nbdsv5w0mf021wqwbailsf9r7rw3ci2x9xl4gn";
        rev = "2dd65c3c92a4b8b1bf653657ae8648b883a4d427";
        url = "https://github.com/Jovian-Experiments/Jovian-NixOS";
      in
      builtins.fetchTarball {
        url = "${url}/archive/${rev}.tag.gz";
        sha256 = "${sha}";
      } + "/modules")
    inputs.home-manager.nixosModules.home-manager
    ../common.nix
    ../../nixosModules/games/default.nix
  ];

  nixpkgs.config.packageOverrides = pkgs: {
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "steam-deck"; # Define your hostname.
  networking.networkmanager.enable = true;

  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      desktopSession = "gnome";
      user = "dasbente";
    };
    devices.steamdeck.enable = true;
  };

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
      desktopManager.gnome.enable = true;
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

      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      }))
    ];
  };

  honkers-railway-launcher.enable = true;
  shipwright.enable = true;

  console.keyMap = "de";

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.dasbente = {
    isNormalUser = true;
    description = "Tobias Möhring";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;

  nixpkgs.config.allowUnfree = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  fonts.packages = with pkgs; [
    nerd-fonts.roboto-mono
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
