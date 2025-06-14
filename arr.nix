{
pkgs,
lib,
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

  age.secrets.transCreds.file = ./secrets/transmissioncreds.json.age;

  nixarr = {
    enable = true;

    vpn = {
      enable = true;
      wgConf = config.age.secrets.wgconf.path;
    };

    mediaDir = "/mnt/media";

    jellyfin.enable = true;
    jellyseerr.enable = true;
    bazarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;

    transmission = {
      enable = true;
      flood.enable = true;
      vpn.enable = true;
      peerPort = 21209;
      credentialsFile = config.age.secrets.transCreds.path;
   };
  };


  # Hardware transcoding for jellyfin
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      vpl-gpu-rt # QSV on 11th gen or newer
      intel-media-sdk # QSV up to 11th gen
    ];
  };

}
