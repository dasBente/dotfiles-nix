{
  description = "Default NixOS setup";

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

  outputs = {
    self,
    nixpkgs,
    nixos-wsl,
    nixos-hardware,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
  in {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs system;};
        modules = [
          ./hosts/default/configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme
        ];
      };

      nixos = nixpkgs.lib.nixosSystem {
        system = system;

        specialArgs = {inherit inputs system;};

        modules = [
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "24.05";
            wsl.enable = true;
          }
          ./hosts/wsl/configuration.nix
        ];
      };
    };

    homeConfiguration."dasbente" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./hosts/default/home.nix];
      extraSpecialArgs = {inherit inputs;};
    };

    homeConfiguration."nixos" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [./hosts/wsl/home.nix];
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
