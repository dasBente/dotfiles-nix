{
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      lenovo-x1 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          ./hosts/lenovo-x1/configuration.nix
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
          ./hosts/nixos-wsl/configuration.nix
        ];
      };
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    monokai-pro-nvim = {
      url = "github:loctvl842/monokai-pro.nvim";
      flake = false;
    };

    vim-renpy = {
      url = "github:chaimleib/vim-renpy";
      flake = false;
    };
  };
}
