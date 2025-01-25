{...}: {
  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./themes/monokai.conf;
  };
}
