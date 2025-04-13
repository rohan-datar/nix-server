{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFYDkyHobLUDOAkNqHxcOkVScdCclKG6m6Az7OT/NAd3"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2wVTZEDwBCIvmTEiKj3pUmhOR+W9qknzbVTXhM25h6"
  ];
in {
  imports = [
    ./arr.nix
    # ./calibre.nix
    ./network.nix
    ./disk-config.nix
  ];
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    calibre
    curl
    git
    neovim
    inputs.agenix.packages.${system}.default
    clang
    fzf
    ripgrep
    shellcheck
    tmux
    wget
    yamllint
    nix-index
    fd
    yq
    lua
    busybox
    gnumake
    cifs-utils
  ];

  environment.shellAliases = {
    vim = "nvim";
  };

  environment.variables.EDITOR = "nvim";

  system.autoUpgrade = {
    enable = false;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  services.openssh.enable = true;


  fileSystems = {
    "/mnt/media" = {
      device = "10.10.100.1:/mnt/data-pool/data-share/media";
      fsType = "nfs";
    };

    "/mnt/Books" = {
      device = "10.10.100.1:/mnt/data-pool/data-share/Books";
      fsType = "nfs";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    rdatar = {
      isNormalUser = true;
      description = "Rohan Datar";
      extraGroups = ["networkmanager" "wheel"];
      openssh.authorizedKeys.keys = sshKeys;
    };

    root = {
      openssh.authorizedKeys.keys = sshKeys;
    };
  };

  nix.settings = {
    warn-dirty = false;
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "24.11";
}
