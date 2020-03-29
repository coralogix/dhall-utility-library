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

  dhall-haskell = import (
    let
      version = "1.31.0";
    in nixpkgs.fetchFromGitHub {
      owner           = "dhall-lang";
      repo            = "dhall-haskell";
      rev             = version;
      fetchSubmodules = true;
      sha256          = "030kxbghm9k1r0amrfdlnz9kq2rqijr7pxhbv0bhcb5lrkzajjak";
    }
  );

in nixpkgs.mkShell {
  buildInputs = [
    dhall-haskell.dhall
    nixpkgs.git
  ];
}
