{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../common.nix
    ../../modules/games/default.nix
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nixos = import ./home.nix;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    code
  ];

  networking.hostName = "nixos-wsl";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = pkgs.nixVersions.latest;

  users.users.nixos = {
    isNormalUser = true;
    description = "Tobias Möhring";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.zsh;
  };

  wsl = {
    enable = true;
    defaultUser = "nixos";
    docker-desktop.enable = true;

    extraBin = with pkgs; [
      {src = "${coreutils}/bin/mkdir";}
      {src = "${coreutils}/bin/cat";}
      {src = "${coreutils}/bin/whoami";}
      {src = "${coreutils}/bin/ls";}
      {src = "${busybox}/bin/addgroup";}
      {src = "${su}/bin/groupadd";}
      {src = "${su}/bin/usermod";}
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
}
