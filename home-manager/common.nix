{pkgs, ...}: {
  imports = [
    ./nvim/config.nix
    ./tmux.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; let
    loadBin = cmd: file: (
      writeShellScriptBin "${cmd}" (builtins.readFile "${file}")
    );
  in [
    fzf
    alejandra

    (loadBin "tmux-sessionizer" ./bins/tmux-sessionizer)
    (loadBin "rebuild" ./bins/rebuild)
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    extraConfig = {
      push = {autoSetupRemote = true;};
      core = {editor = "nvim";};
      init = {defaultBranch = "main";};
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
