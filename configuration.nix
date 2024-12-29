{
  lib,
  pkgs,
  inputs,
  ...
}: {
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
  ];

  environment.shellAliases = {
    vim = "nvim";
  };

  environment.variables.EDITOR = "neovim";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rdatar = {
    isNormalUser = true;
    description = "Rohan Datar";
    extraGroups = ["networkmanager" "wheel"];
  };

  system.stateVersion = "24.11";
}
