{
  description = "Python environment flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pythonPackages = pkgs.python311Packages; # Adjust Python version as needed

        # Virtual environment directory
        venvDir = "./.venv";

        # Base packages for running Python
        runPackages = with pkgs; [
          pythonPackages.python
          pythonPackages.venvShellHook
        ];

        # Additional packages for development
        devPackages = with pkgs; runPackages ++ [
          pythonPackages.pylint
          pythonPackages.black
          pythonPackages.flake8
          pythonPackages.mypy
          # Add any other global tools you want
        ];

        # Hook to include venv packages in PYTHONPATH for tools like pylint
        postVenvCreation = ''
          pip install --upgrade pip setuptools wheel
          if [ -f requirements.txt ]; then
            pip install -r requirements.txt
          fi
        '';

        postShellHook = ''
          export PYTHONPATH="$PWD/${venvDir}/${pythonPackages.python.sitePackages}:$PYTHONPATH"
        '';

      in {
        devShells = {
          default = pkgs.mkShell {
            name = "python-run";
            packages = runPackages;
            venvDir = venvDir;
            postVenvCreation = postVenvCreation;
            postShellHook = postShellHook;
          };

          dev = pkgs.mkShell {
            name = "python-dev";
            packages = devPackages;
            venvDir = venvDir;
            postVenvCreation = postVenvCreation;
            postShellHook = postShellHook;
          };
        };
      }
    );
}
