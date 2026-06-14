{
  lib,
  inputs,
  self,
  ...
}: let
  tmux =
    inputs.wrappers.wrappers.tmux.apply
    ({
      pkgs,
      config,
      ...
    }: let
      system = pkgs.stdenv.system;
    in {
      sourceSensible = true;
      prefix = "C-x";

      package = pkgs.tmux.overrideAttrs (oldAttrs: {
        version = "next-3.7";
        src = inputs.tmux-kitty;
        patches = [];
      });

      configBefore = builtins.readFile ./tmux.before.conf;

      # shell = pkgs.lib.getExe pkgs.bash;

      configAfter = ''
      '';

      modeKeys = "vi";

      plugins = [
        # {
        #   name = "ukiyo";
        #   plugin = inputs.tmux-ukiyo;
        # }

        {
          name = "dotbar";
          plugin = inputs.tmux-dotbar;
        }
        {
          name = "vim-tmux-navigator";
          plugin = pkgs.tmuxPlugins.vim-tmux-navigator;
        }
        {
          name = "tmux_super_fingers";
          plugin = inputs.tmux-super-fingers;
        }
        {
          name = "tpad";
          plugin = inputs.tmux-tpad;
        }

        # {
        #   name = "sessionx";
        #   plugin = pkgs.tmuxPlugins.tmux-sessionx;
        # }

        # {
        #   name = "fzf";
        #   plugin = pkgs.tmuxPlugins.tmux-fzf;
        # }

        # {
        #   name = "2k";
        #   plugin = inputs.tmux-2k;
        # }
      ];

      runtimePkgs = [
        pkgs.tmux
        pkgs.sesh
        pkgs.fd
        pkgs.fzf
        pkgs.bat
        # pkgs.bash
        # inputs.tmux-muxbar.defaultPackage.${system}
      ];
    });
in {
  flake-file.inputs = {
    tmux-kitty = {
      url = "github:jixiuf/tmux";
      flake = false;
    };
    # tmux-muxbar = {
    #   url = "github:Dlurak/muxbar";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
    # tmux-sessionx = {
    #   url = "github:omerxx/tmux-sessionx";
    #   flake = false;
    # };

    # tmux-ukiyo = {
    #   url = "github:Nybkox/tmux-ukiyo";
    #   flake = false;
    # };
    # tmux-2k = {
    #   url = "github:2KAbhishek/tmux2k";
    #   flake = false;
    # };
  };

  perSystem = {pkgs, ...}: let
    tmuxWrapped = tmux.wrap {inherit pkgs;};
  in {
    apps.tmux = {
      type = "app";
      program = lib.getExe tmuxWrapped;
    };
    packages.tmux = tmuxWrapped;
  };
  flake = {
    # tmux = tmux.config;
    tmux = tmux.eval {pkgs = inputs.nixpkgs.legacyPackages."aarch64-darwin";};
  };
}
