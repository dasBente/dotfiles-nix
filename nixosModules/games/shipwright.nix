{ pkgs, lib, config, ... }:
{
  options = {
    shipwright.enable =
      lib.mkEnableOption "Enables Shipwright";
  };

  config = lib.mkIf config.shipwright.enable {
    environment.systemPackages = [pkgs.shipwright];
  };
}
