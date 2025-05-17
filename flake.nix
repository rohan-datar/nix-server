{
  description = "Nix Server config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix-template.url = "github:jhillyerd/agenix-template/1.0.0";

    nixarr.url = "github:rasmus-kirk/nixarr";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    nixarr,
    agenix,
    agenix-template,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    hostName = "home-media";
  in {
    nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        disko.nixosModules.disko
        nixarr.nixosModules.default
        ./configuration.nix
        ./hardware-configuration.nix
        agenix.nixosModules.default
        agenix-template.nixosModules.default
      ];
    };
  };
}
