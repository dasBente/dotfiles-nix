{
  pkgs,
  inputs,
  ...
}: 
let
  jovian-nixos = builtins.fetchGit {
    url = "https://github.com/Jovian-Experiments/Jovian-NixOS";
    ref = "development";
  };
in {
  imports = [
    "${jovian-nixos}/modules"
    inputs.home-manager.nixosModules.home-manager
    ../common.nix
  ];

  nixpkgs.config.packageOverrides = pkgs: {
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {dasbente = import ./home.nix;};
  };

  # Jovian
  jovian.devices.steamdeck.enable = true;

  networking.hostName = "steamdeck";
  networking.networkmanager.enable = true;

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

      displayManager.gdm.enable = true;
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
    pathsToLink = ["/share/zsh"];

    systemPackages = with pkgs; [
      pkgs.home-manager
      git
      networkmanagerapplet
      firefox-wayland
      discord-ptb
      steam-run
    ];
  };

  console.keyMap = "de";

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

  nixpkgs.config.allowUnfree = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  fonts.packages = with pkgs; [
    nerd-fonts.roboto-mono
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}
