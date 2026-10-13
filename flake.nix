# DO-NOT-EDIT. This file was auto-generated using github:denful/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } ./modules;

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://peteremiljensen.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "peteremiljensen.cachix.org-1:q6F2VNjqkkSJYFyk8QdI2EyBrJzNPa4fmLT0kFiRkZ8="
    ];
  };

  inputs = {
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    tmux-dotbar = {
      url = "github:vaaleyard/tmux-dotbar";
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
      url = "github:nix-community/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
