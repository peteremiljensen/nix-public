{
  lib,
  inputs,
  self,
  ...
}: let
  neovim = inputs.wrappers.wrappers.neovim.apply ({
    pkgs,
    config,
    ...
  }: {
    imports = [
      ({config, ...}: {
        options.nvim-lib.pluginsFromPrefix = lib.mkOption {
          type = lib.types.raw;
          readOnly = true;
          default = prefix:
            lib.pipe inputs [
              builtins.attrNames
              (builtins.filter (s: lib.hasPrefix prefix s))
              (map (
                input: let
                  name = lib.removePrefix prefix ((_: break _) input);
                in {
                  inherit name;
                  value = config.nvim-lib.mkPlugin name inputs.${input};
                  lazy = false;
                }
              ))
              builtins.listToAttrs
            ];
        };
      })
    ];

    settings.config_directory = "/Users/peteremiljensen/git/personal/nix-public/modules/neovim/config_new";
    # settings.config_directory = ./config;
    hosts.node.nvim-host.enable = false;
    hosts.ruby.nvim-host.enable = false;

    env.NVIM_APPNAME = "kickstarter-nvim-new-2";
    env.NIX_CONFIG_ROOT = toString self;

    specs.general = {
      data = with pkgs.vimPlugins; [
        lazy-nvim
      ];
      # ++ lib.attrValues (config.nvim-lib.pluginsFromPrefix "plugin-");
    };

    specs.lazy = {
      lazy = true;
      data = with pkgs.vimPlugins; [
        gitsigns-nvim
      ];
    };

    runtimePkgs = with pkgs; [
      tree-sitter

      # lsp
      nixd
      gopls

      # lint
      markdownlint-cli

      # debug
      delve
    ];
  });
in {
  perSystem = {pkgs, ...}: let
    neovimWrapped = neovim.wrap {inherit pkgs;};
  in {
    apps.neovim = {
      type = "app";
      program = lib.getExe neovimWrapped;
    };
    packages.neovim = neovimWrapped;
  };

  flake-file.inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  flake-file.nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  # flake = {
  #   neovim = neovim.eval {};
  # };
}
