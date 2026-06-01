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

      configBefore = ''
        set-option -g default-terminal "tmux-256color"
        set -ga terminal-features ",*256color:RGB"

        set-option -g renumber-windows on
        set -g base-index 1
        setw -g pane-base-index 1

        set -g @tmux-dotbar-position top
        set -g @tmux-dotbar-right true
        set -g @tmux-dotbar-rounded true

        set -g @tmux-dotbar-ssh-icon '󰌘'
        set -g @tmux-dotbar-ssh-icon-only false
        set -g @tmux-dotbar-ssh-enabled true

        set -g @tmux-dotbar-bg "#1f1f28"
        set -g @tmux-dotbar-fg "#9e9b93"
        set -g @tmux-dotbar-fg-current "#dcd7ba"
        set -g @tmux-dotbar-fg-session "#9e9b93"
        set -g @tmux-dotbar-fg-prefix "#dcd7ba"


        # keys
        bind c new-window -a -c "#{pane_current_path}"
        bind v split-window -h -c "#{pane_current_path}"
        bind s split-window -v -c "#{pane_current_path}"
        unbind '"'
        unbind %

        unbind [
        bind Escape copy-mode
        unbind p
        bind p paste-buffer

        # needed by wezterm
        set -g allow-passthrough on

      '';

      # shell = "/bin/bash";

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

        # {
        #   name = "2k";
        #   plugin = inputs.tmux-2k;
        # }
      ];

      runtimePkgs = [
        pkgs.tmux
        # pkgs.bash
        # inputs.tmux-muxbar.defaultPackage.${system}
      ];
    });
in {
  flake-file.inputs = {
    # tmux-muxbar = {
    #   url = "github:Dlurak/muxbar";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    tmux-dotbar = {
      url = "github:vaaleyard/tmux-dotbar";
      flake = false;
    };

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
