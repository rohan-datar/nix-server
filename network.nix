{...}: {
  networking = {
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
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFYDkyHobLUDOAkNqHxcOkVScdCclKG6m6Az7OT/NAd3"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2wVTZEDwBCIvmTEiKj3pUmhOR+W9qknzbVTXhM25h6"
  ];
}
