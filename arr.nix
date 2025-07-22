{
pkgs,
lib,
config,
...
}: {
  age.secrets.wgconf.file = ./secrets/AirVPN-America-WG.conf.age;


  nixarr = {
    enable = true;

    vpn = {
      enable = true;
      wgConf = config.age.secrets.wgconf.path;
      accessibleFrom = [ "10.10.0.0/19" ];
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
   };

    recyclarr = {
      enable = true;

      configuration =  {
        sonarr = {
          series = {
            base_url = "http://localhost:8989";
            api_key = "!env_var SONARR_API_KEY";
          };
        };
        radarr = {
          movies = {
            base_url = "http://localhost:7878";
            api_key = "!env_var RADARR_API_KEY";
          };
        };
      };
    };
  };


  nixpkgs.config.packageOverrides = pkgs: {
    # Only set this if using intel-vaapi-driver
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD"; # Or "i965" if using older driver
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };      # Same here
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
