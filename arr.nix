{
config,
...
}: {
  # needed due to https://github.com/NixOS/nixpkgs/issues/360592
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];
  age.secrets.wgconf.file = ./secrets/AirVPN-America-WG.conf.age;

  nixarr = {
    enable = true;

    vpn = {
      enable = true;
      wgConf = config.age.secrets.wgconf.path;
      # vpnTestService = {
      #   enable = true;
      #   port = 21209;
      # };
    };

    mediaDir = /mnt/media;
    # mediaUsers = [ "rdatar" ];

    jellyfin.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;

    transmission = {
      enable = true;
      flood.enable = true;
      vpn.enable = true;
      peerPort = 21209;
    };
  };
}
