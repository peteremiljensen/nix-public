{
  perSystem = {pkgs, ...}: {
    # packages.cachix = pkgs.writeShellApplication {
    #   name = "cachix";
    #   runtimeInputs = with pkgs; [gum cachix nix jq];
    #   text = builtins.readFile ./cachix.sh;
    #   inheritPath = false;
    # };

    packages.cachix =
      pkgs.writers.writeFishBin "cachix" {
        makeWrapperArgs = [
          "--suffix"
          "PATH"
          ":"
          "${with pkgs; lib.makeBinPath [fish gum cachix jq]}"
        ];
      }
      (builtins.readFile ./cachix.fish);
  };
}
