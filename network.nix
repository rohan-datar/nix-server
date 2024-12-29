{...}: {
  networking = {
    hostName = "home-media";
    interfaces = {
      enp1s0.ipv4.addresses = [
        {
          address = "10.10.1.11";
          prefixLength = 19;
        }
      ];
    };
    defaultGateway = {
      address = "10.10.0.1";
      interface = "enp1s0";
    };

    nameservers = ["10.10.0.1"];
  };
}
