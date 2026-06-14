# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: import ./outputs.nix inputs;

  nixConfig = {
    extra-substituters = [ "https://peteremiljensen.cachix.org" ];
    extra-trusted-public-keys = [
      "peteremiljensen.cachix.org-1:q6F2VNjqkkSJYFyk8QdI2EyBrJzNPa4fmLT0kFiRkZ8="
    ];
  };

  inputs = {
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    tmux-dotbar = {
      url = "github:vaaleyard/tmux-dotbar";
      flake = false;
    };
    tmux-kitty = {
      url = "github:jixiuf/tmux";
      flake = false;
    };
    tmux-super-fingers = {
      url = "github:artemave/tmux_super_fingers";
      flake = false;
    };
    tmux-tpad = {
      url = "github:Subbeh/tmux-tpad";
      flake = false;
    };
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
