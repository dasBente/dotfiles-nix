{pkgs}: [
  (import ./tmux-sessionizer.nix {inherit pkgs;})
  (import ./rebuild.nix {inherit pkgs;})
  (import ./update-input.nix {inherit pkgs;})
]
