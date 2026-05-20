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

    settings.config_directory = ./config;
    hosts.node.nvim-host.enable = false;
    hosts.ruby.nvim-host.enable = false;

    env.NVIM_APPNAME = "kickstarter-nvim-new";
    env.NIX_CONFIG_ROOT = toString self;

    specs.general = {
      data = with pkgs.vimPlugins;
        [
          lze
          lzextras

          guess-indent-nvim
          nvim-web-devicons
          which-key-nvim
          tokyonight-nvim
          todo-comments-nvim
          mini-nvim

          plenary-nvim

          # telescope plugins
          telescope-nvim
          telescope-ui-select-nvim

          nui-nvim

          # lsp

          nvim-treesitter.withAllGrammars

          # neo-tree

          {
            pname = "nvim-autopairs";
            data = nvim-autopairs;
          }

          # debug
          nvim-nio

          {
            pname = "lint";
            data = nvim-lint;
          }
        ]
        ++ lib.attrValues (config.nvim-lib.pluginsFromPrefix "plugin-");
    };

    specs.lazy = {
      lazy = true;
      data = with pkgs.vimPlugins; [
        {
          pname = "gitsigns";
          data = gitsigns-nvim;
        }
        {
          pname = "neo-tree";
          data = neo-tree-nvim;
        }
        {
          pname = "ibl";
          data = indent-blankline-nvim;
        }

        # lsp
        nvim-lspconfig
        {
          pname = "fidget";
          data = fidget-nvim;
        }

        {
          pname = "luasnip";
          data = luasnip;
        }

        {
          pname = "blink.cmp";
          data = blink-cmp;
        }

        {
          pname = "conform";
          data = conform-nvim;
        }

        # debug
        {
          pname = "dap";
          data = nvim-dap;
        }
        {
          pname = "dapui";
          data = nvim-dap-ui;
        }
        {
          pname = "dap-go";
          data = nvim-dap-go;
        }
      ];
    };

    runtimePkgs = with pkgs; [
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
  perSystem = {pkgs, ...}: {
    packages.neovim = neovim.wrap {
      inherit pkgs;
    };
  };
  flake = {
    neovim = neovim.eval {};
  };
}
