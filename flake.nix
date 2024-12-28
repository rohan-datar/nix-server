{
  description = "Nix config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    disk9 = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixarr.url = "github:rasmus-kirk/nixarr";
  };

  outputs = {
    self,
    nixpkgs,
    disko,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    hostName = "com.rdatar.media";
    rootAuthorizedKeys = [
      # This user can ssh using `ssh root@<ip>`
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFYDkyHobLUDOAkNqHxcOkVScdCclKG6m6Az7OT/NAd3"
    ];
  in {
    nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};
      modules = [
        ./disk-config.nix
        disko.nixosModules.disko
        ({pkgs, ...}: {
          boot.loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
          networking = {inherit hostName;};
          services.openssh.enable = true;
          environment.systemPackages = with pkgs; [
            htop
            git
            neovim
          ];

          users.users.root.openssh.authorizedKeys.keys = rootAuthorizedKeys;

          system.stateVersion = "24.11";
        })
      ];
    };
  };
}
