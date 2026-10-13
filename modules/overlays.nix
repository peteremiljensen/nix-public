{inputs, ...}: {
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          stable = inputs.nixpkgs-stable.legacyPackages.${system};
        })

        inputs.neovim-nightly-overlay.overlays.default
      ];
    };
  };
}
