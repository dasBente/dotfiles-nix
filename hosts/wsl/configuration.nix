{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    #    <nixos-wsl/modules>
    inputs.home-manager.nixosModules.home-manager
    ../common.nix
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {nixos = import ./home.nix;};
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.zsh.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    description = "Tobias Möhring";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  system.stateVersion = "24.05"; # Did you read the comment?
}
