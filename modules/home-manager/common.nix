{pkgs, inputs, ...}: {
  imports = [
    ./default.nix
#    ./nvim/config.nix
  ];

  home.stateVersion = "24.11"; # do not touch unless necessary!

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = import ./bins/default.nix {
    inherit pkgs;
  } ++ [ inputs.portable-nvim.packages.${pkgs.system}.default ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.tmux.enable = true;
  home.zsh.enable = true;
  home.lf.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings.user = {
      name = "dasBente";
      email = "dasbente@gmail.com";
      push = {autoSetupRemote = true;};
      pull = {rebase = true;};
      core = {editor = "nvim";};
      init = {defaultBranch = "main";};
    };
  };

}
