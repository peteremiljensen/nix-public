{inputs, ...}: {
  imports = [
    inputs.flake-file.flakeModules.default
    ./neovim
    ./tmux
    ./cachix
  ];

  systems = ["aarch64-darwin" "aarch64-linux" "x86_64-linux"];

  flake-file.inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    flake-file.url = "github:vic/flake-file";

    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";

    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
