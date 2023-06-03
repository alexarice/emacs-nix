{
  description = "Nix config for emacs";

  inputs = {
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosModules = {
      emacs-nix = import ./module.nix;
    };
  };
}
