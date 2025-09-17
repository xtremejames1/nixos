#!/usr/bin/env bash

# Path to your Python env flake
FLAKE_PATH="$HOME/nixos/flakes/python-env"

# Default to dev shell unless specified
SHELL_TYPE=${1:-default}

# Create .envrc file
cat > .envrc << EOL
use flake ${FLAKE_PATH}#${SHELL_TYPE}
EOL

# Initialize direnv
direnv allow
echo "Python environment activated with '${SHELL_TYPE}' configuration."
echo "Virtual environment is at .venv/"
echo "You can use 'pip install' normally now."
