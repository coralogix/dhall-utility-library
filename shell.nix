let
  nixpkgs = import (
    let
      version = "0c960262d159d3a884dadc3d4e4b131557dad116";
    in builtins.fetchTarball {
      name   = "nixpkgs-${version}";
      url    = "https://github.com/NixOS/nixpkgs/archive/${version}.tar.gz";
      sha256 = "0d7ms4dxbxvd6f8zrgymr6njvka54fppph1mrjjlcan7y0dhi5rb";
    }
  ) {};

  easy-dhall-nix = import (
    let
      version = "1.33.1";
    in nixpkgs.fetchFromGitHub {
      owner  = "justinwoo";
      repo   = "easy-dhall-nix";
      rev    = "288ee825c326f352a5db194a024bd3e1f2f735b2";
      sha256 = "12v4ql1nm1famz8r80k1xkkdgj7285vy2vn16iili0qwvz3i98ah";
      }
    ) {};

in nixpkgs.mkShell {
  buildInputs = [
    easy-dhall-nix.dhall-simple
  ];
}
