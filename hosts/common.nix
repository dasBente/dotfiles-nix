#
# Definitions, utils etc. shared by all hosts.
#
{
  pkgs,
  config,
  ...
}: {
  environment.etc."current-system-packages".text = let
    packages =
      builtins.map (p: "${p.name}") config.environment.systemPackages;
    sortedUnique =
      builtins.sort builtins.lessThan (pkgs.lib.lists.unique packages);
    formatted =
      builtins.concatStringsSep "\n" sortedUnique;
  in
    formatted;

  programs.zsh.enable = true;
}
