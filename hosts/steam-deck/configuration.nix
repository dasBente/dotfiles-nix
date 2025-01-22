{
  pkgs,
  inputs,
  ...
}: 
let
  mainUser = "dasbente";
in {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../common.nix
    inputs.jovian.nixosModules.jovian
  ];

  nixpkgs.config.packageOverrides = pkgs: {
  };

  jovian = {
    steam.enable = true;
    steam.autoStart = true;
    devices.steamdeck.enable = true;
  };

  services = {
    xserver.displayManager = {
      gdm.wayland.enable = true;
      defaultSession = "steam-wayland";
      autoLogin.enable = true;
      autoLogin.user = mainUser;
    };

    xserver.xkb = {
      layout = "de";
      variant = "";
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  sound.enable = true;

  services.xserver.displayManager.gnome.enable = true;

  networking.hostName = "steam-deck"; # Define your hostname.
  networking.networkmanager.enable = true;

  home-manager.users."${mainUser}" = import ./home.nix;

  systemd.services.gamescope-switcher = {
    wantedBy = [ "graphical.target" ];
    servicesConfig = {
      User = 1000;
      PAMName = "login";
      WorkingDirectory = "~";

      TTYPath = "/dev/tty7";
      TTYReset = "yes";
      TTYHangup = "yes";
      TTYVTDisallocate = "yes";

      StandardInput = "tty-fail";
      StandardOutput = "journal";
      StandardError = "journal";

      UtmpIdentifier = "tty7";
      UtmpMode = "user";

      Restart = "always";
    };

    script = ''
    set-session () {
      mkdir -p ~/.local/state
      >~/.local/state/steamos-session-select echo "$1"
    }
    consume-session () {
      if [[ -e ~/.local/state/steamos-session-select ]]; then
        cat ~/.local/state/steamos-session-select
        rm ~/.local/state/steamos-session-select
      else
        echo "gamescope"
      fi
    }
    while :; do
      session=$(consume-session)
      case "$session" in
        plasma)
          dbus-run-session -- gnome-shell --display-server --wayland
          ;;
        gamescope)
          steam-session
          ;;
      esac
    done
    '';
  };

  environment = {
    pathsToLink = ["/share/zsh"];

    systemPackages = with pkgs; [
      pkgs.home-manager
      git
      networkmanagerapplet
      firefox-wayland
      discord-ptb

      # steamdeck
      jupiter-dock-updater-bin
      steamdeck-firmware

      # hyprland packages
      swww
      rofi-wayland

      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      }))
    ];
  };

  security.rtkit.enable = true;

  users.users.dasbente = {
    isNormalUser = true;
    description = "Tobias Möhring";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.roboto-mono
  ];
}
