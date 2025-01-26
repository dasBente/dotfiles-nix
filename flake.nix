{
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = import ./nixosConfigurations/default.nix
      {inherit nixpkgs system inputs;};
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
