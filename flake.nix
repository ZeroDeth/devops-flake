{
  description = "A Nix-flake-based Nix development environment";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Set of utilities for working with Nix flakes.
    # It provides functions for parsing and manipulating flake inputs, as well as tools for working with flake registries.
    flake-utils.url = "github:numtide/flake-utils";

    # vscode-server.url = "github:msteen/nixos-vscode-server";

    # code-server.url = "github:nix-community/code-server";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";

      # We want to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";

      # We want to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , flake-utils
    , home-manager
    , darwin
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
       pkgs = nixpkgs.legacyPackages.${system}; in
      {
        devShells.default = import ./shell.nix { inherit pkgs; };
      }
    );
}
