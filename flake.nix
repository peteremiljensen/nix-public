{
  description = "public packages";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs-stable.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./neovim
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      # perSystem = {
      #   config,
      #   self',
      #   inputs',
      #   pkgs,
      #   system,
      #   ...
      # }: {
      #   # Per-system attributes can be defined here. The self' and inputs'
      #   # module parameters provide easy access to attributes of the same
      #   # system.
      #
      #   # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
      #   packages.default = pkgs.hello;
      # };
      # flake = {
      #   # The usual flake attributes can be defined here, including system-
      #   # agnostic ones like nixosModule and system-enumerating ones, although
      #   # those are more easily expressed in perSystem.
      # };
    };
}
