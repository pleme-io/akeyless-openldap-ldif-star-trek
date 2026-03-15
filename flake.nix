{
  description = "Akeyless OpenLDAP LDIF data file with Star Trek themed entries for LDAP import demos";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [ openldap ];
      };
    });
}
