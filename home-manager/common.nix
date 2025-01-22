{pkgs, ...}: {
  imports = [
    ./nvim/config.nix
    ./tmux.nix
    ./zsh.nix
    ./lf/config.nix
  ];

  home.packages = import ./bins/default.nix {inherit pkgs;};
  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    lfs.enable = true;
    enable = true;
    extraConfig = {
      push = {autoSetupRemote = true;};
      pull = {rebase = true;};
      core = {editor = "nvim";};
      init = {defaultBranch = "main";};
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
