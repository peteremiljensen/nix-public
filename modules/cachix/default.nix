{
  perSystem = {pkgs, ...}: {
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

    # packages.rust =
    #   pkgs.writers.writeFishBin "cachix" {
    #     makeWrapperArgs = [
    #       "--suffix"
    #       "PATH"
    #       ":"
    #       "${with pkgs; lib.makeBinPath [fish gum cachix jq]}"
    #     ];
    #   }
    #   (builtins.readFile ./cachix.fish);
  };
}
