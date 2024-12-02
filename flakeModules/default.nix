{
  _class = "flake";

  imports = [
    ./common.nix
    ./lib.nix
    ./nixos.nix
    ./nixpkgs.nix
    ./users.nix
  ];
}
