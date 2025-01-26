{nixpkgs, inputs, ...}:
let
  system = "x86_64-linux";
in {
  lenovo-x1 = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs system;};
    modules = [
      ./lenovo-x1/configuration.nix
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme
    ];
  };

  nixos-wsl = nixpkgs.lib.nixosSystem {
    system = system;
    specialArgs = {inherit inputs system;};
    modules = [
      inputs.nixos-wsl.nixosModules.default
      {
        system.stateVersion = "24.05";
        wsl.enable = true;
      }
      ./nixos-wsl/configuration.nix
    ];
  };

  steam-deck = nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs system;};
    modules = [
      ./steam-deck/configuration.nix
    ];
  };
}
