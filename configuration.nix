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
    enable = true;
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

  age.secrets.smbcredentials.file = ./secrets/smbcredentials.age;
  fileSystems."/mnt/data-share" = {
    device = "//10.10.100.1/data-share";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=${config.age.secrets.smbcredentials.path},uid=1000,gid=3000"];
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
