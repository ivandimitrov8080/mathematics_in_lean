{ inputs, ... }: {
  systems = [ "x86_64-linux" ];
  perSystem = { system, pkgs, ... }: {
    config._module.args = {
      pkgs = import inputs.configuration.inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.configuration.overlays.default
        ];
      };
    };
    config.devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        (nvim.extend {
          plugins.lsp.servers = {
            leanls.enable = true;
          };
        })
        lean4
      ];
    };
    config.packages.default = pkgs.stdenv.mkDerivation { };
  };
}
