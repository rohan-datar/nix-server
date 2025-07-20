let
  user-ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIManVcKWQ9IZCy7Kge/CgHg4ER07TAEPnvOuSiQMKupS";
  user-rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5PieeZRD8Dbsab1V5cqUH8d9J+mP4vCLYL4apM8AH1rgXlfaDARtI61YXm9bd+IM+XUxTUnnGO/Seu/y6lvr41xyLrseAPMOpWVYRMbtdo2nCYZjYCKf8XRPoeheiJBZ8VVwHxMNuXeFaQccHkwB515mrXqgxOh/qAioi4quDg2WotT2QIPWuGBIqnMB7IaEvFJK1fCNMmCRskYn2DNt3R3lrgj6T+mNemf8NFeJ4t8AYnFOv2LqBhvT5MeI5lU5GpdPv6211DQy45MeQUTGCw91YMEi3f76zz6VikCEGeSXESnoZUcxXUXclqSkGHfmoDQxr8i0H8ZQKJZhpRmHxBBTe8x8gQJUAUjFOJULFnjewL66HzpZONN/pRE2JfZcYgnGxxmZ9OznNvpn97meQrMhsc43MEqGg2rrSAvBQdMuPGVkIFKr2cXochmSEIj0/idynyaZlMJgVWRrrLtep1Hy9Q91SHYZb+KMscBcDFGw71lzcHF+tGICs++523Ms=";
  user-keys = [user-ed25519 user-rsa];

  system-ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYALV0x6If58isPYKWvxsPoYPbBagPE9HAN360didH8";
  system-rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCoRE55TqhIzpB9nCIXHtak1Nzmw4UrGtRwyD9hF8JDuFhJl6YQ5n+SZXOeGTupDsdcu01tNTrfhl2WSnWHJcKzdUVxfT/+7RiiE4VTRV9phpLaaTJwsb7xHDm/J7f9mclamf8ZqAHU/dWRJ/7y0/9PlUUocXYcgoa6QEe8plki8zo2z3s2WNOFIZPRQJ7XBXh9n3I19XmN05+VsMhOASAWUIPETsVDU5dNV5OmWQbErBYDNPNwXw44XFXiN2BcuxmXRYq90x/oa+vLz9vqaJhx3XA3CFqGdWvkf3I/D4rq/Hu+v6FnF3WIZJOgegcHFcmTlVWowhs5oqXzI9NeahFW+tmJMCuq7rfyHQs6ny1zU/euTd30t45ItWip7+97b1DjXU7k50fXbRknu0T5Aq/nSagYH8+1p4GuYL8/7Pygcm/Dx47qa7Tp03AltiHUuuDWsBgCLI8P+xnQ2n41e/Gtn6ZOGQ8rtbK+D2W3h+AriC+tWZIfpZ2KGqaVy2G450cqP/ixgJFoh+MpZluCaUdStDDc5tAZPmBHYeLtDoLz6n3waxSbBTI4TwUT9zj4buL8DSzGNUngc/sXJeqp6RhKKrbAzigVBMWf5yCszPwkRpNQq+qx9oTbggYw9nXrDUVja8M2n7yDUiHrMuNY9YDlGmsQxn1Lu/vbc+9aVg5enQ==";
  system-keys = [ system-ed25519 system-rsa ];
  server-keys = system-keys ++ user-keys;
in {
  "AirVPN-America-WG.conf.age".publicKeys = server-keys;
  "transmissioncreds.json.age".publicKeys = server-keys;
  "transmissionPwd.age".publicKeys = server-keys;
  "sonarrApiKey.age".publicKeys = server-keys;
  "radarrApiKey.age".publicKeys = server-keys;
  "prowlarrApiKey.age".publicKeys = server-keys;
  "bazarrApiKey.age".publicKeys = server-keys;
  "jellyfinApiKey.age".publicKeys = server-keys;
  "jellyseerrApiKey.age".publicKeys = server-keys;
  "truenasApiKey.age".publicKeys = server-keys;
  "opnsenseUser.age".publicKeys = server-keys;
  "opnsensePass.age".publicKeys = server-keys;
  "adguardPass.age".publicKeys = server-keys;
}
