{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    #    <nixos-wsl/modules>
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {nixos = import ./home.nix;};
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  system.stateVersion = "24.05"; # Did you read the comment?
}
