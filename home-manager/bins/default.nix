{ pkgs }:

[
  (import ./bins/tmux-sessionizer.nix {inherit pkgs;})
  (import ./bins/rebuild.nix {inherit pkgs;})
  (import ./bins/update-input {inherit pkgs;})
]

