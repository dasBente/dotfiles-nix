{pkgs}: [
  (import ./tmux-sessionizer.nix {inherit pkgs;})
  (import ./rebuild.nix {inherit pkgs;})
  (import ./update-input.nix {inherit pkgs;})
  (import ./unzip-jp.nix {inherit pkgs;})
  (import ./to-jpg.nix {inherit pkgs;})
]
