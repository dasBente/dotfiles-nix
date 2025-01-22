{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../common.nix
  ];

  home-manager = {
    users.nixos = import ./home.nix;
  };

  networking.hostName = "nixos-wsl";

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

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
}
