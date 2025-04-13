
{
pkgs,
lib,
config,
...
}:
let
  calibreLibraryPath = "/mnt/Books/library";
in
{
  services = {
    # calibre-server = {
    #   enable = true;
    #   openFirewall = true;
    #   libraries = [ calibreLibraryPath ];
    # };
    calibre-web = {
      user = "calibre-web";
      group = "calibre-web";
      enable = true;
      openFirewall = true;
      listen = {
        ip = "0.0.0.0";
        port = 8083;
      };
      options = {
        calibreLibrary = calibreLibraryPath;
        enableBookUploading = true;
        enableBookConversion = true;
        enableKepubify = true;
      };
    };

  };

  systemd.tmpfiles.rules = [
    "d ${calibreLibraryPath} 0755 calibre-web calibre-web"
  ];
}
