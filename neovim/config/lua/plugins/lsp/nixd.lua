return {
  {
    'nixd',
    lsp = {
      filetypes = { 'nix' },
      cmd = {
        'nixd',
        -- "./nixd-log.sh",
      },
      settings = {
        nixd = {
          formatting = {
            command = { 'nixfmt' },
          },
          nixpkgs = {
            expr = [[
                  (import (builtins.getFlake "]]
              .. nixConfigRoot
              .. [[").inputs.nixpkgs {  })
                ]],
          },
          -- nixpkgs = {
          --   -- expr = "import " .. flakeStr .. ".inputs.nixpkgs { }",
          --   -- expr = "import " .. flakeStr .. ".inputs.nixpkgs { }",
          -- },
          options = {
            nixos = {
              expr = [[
                    (let
                      flake = builtins.getFlake "]]
                .. nixConfigRoot
                .. [[";
                      pkgs = import "${flake.inputs.nixpkgs}" { };
                      inherit (pkgs) lib;
                    in (lib.evalModules {
                      modules = (import "${flake.inputs.nixpkgs}/nixos/modules/module-list.nix");
                      check = false;
                    })).options
                  ]],
            },
            -- nix_darwin = {
            --   expr = [[
            --     (let
            --       pkgs = import "${flake.inputs.nixpkgs}" { };
            --       inherit (pkgs) lib;
            --     in (lib.evalModules {
            --       modules = (import "${flake.inputs.nix-darwin}/modules/module-list.nix");
            --       check = false;
            --     })).options
            --   ]],
            -- },
            ['home-manager'] = {
              expr = [[
                    (let
                      flake = builtins.getFlake "]]
                .. nixConfigRoot
                .. [[";
                      pkgs = import "${flake.inputs.nixpkgs}" { };
                      lib = import "${flake.inputs.home-manager}/modules/lib/stdlib-extended.nix" pkgs.lib;
                    in (lib.evalModules {
                      modules =  (import "${flake.inputs.home-manager}/modules/modules.nix") {
                        inherit lib pkgs;
                        check = false;
                      };
                    })).options
                  ]],
            },
          },

          -- nixos = {
          --   expr = formatFlake("nixosConfigurations") .. ".options",
          -- },
          -- ["home-manager"] = {
          --   expr = formatFlake("nixosConfigurations") .. ".options.home-manager.users.type.getSubOptions []",
          -- },
          -- darwin = {
          --   expr = formatFlake("darwinConfigurations") .. ".options",
          -- },
        },
      },
    },
  },
}
