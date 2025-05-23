let
  user-ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLUEwPaAhMFKdNOEFyJZeISoezkZh4ooUyVvzgWhCvG";
  user-rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCrMa2yB1SsEQ2OuzeATHkOC0jSfs0z9SHg/GTeCF8sNYucL+fNlbL5QDyGU9oIe3ozCTZ2mJlJsO1F/3vzogJqbKcAEb+Uv9wIERmuXzIOZxwy0RH6xHuGKBoviMTfYQZepsd2jlLr/B04cBR8wZBSg3JDWSBtj8VMGcbDeLDXCby14V1wISZQAT2KvY2I7yHWfBBx9dWyEibyjk0JeeRpHPVYDT3TI3BVxvKirP6k/SYHRClMxhUEIbZw1vgF4fB1FMTSvCXpnOycGxQz6WL/7dnhyBEjTOayHxU8oYvAwSPlZcWqYjIsp27lhRreh/9AKrhKQlDIYRjewq/8lcOiz4OeitAI8Jit1XQoLUiOoGejn6g1Vwo5NoDInYxRgxwdB5RcEVzEYfLhtIXiM2gK4qILdQwa//Zn4tlKWEZGRlioZRobRV8sCfNaBugqtommVewLkdhqo3v3QjBZFNLQa2eZ/31sT5fOQuYflI6iyKykXh0+6PIU77Qq+IU4a20=";
  user-keys = [user-ed25519 user-rsa];

  system-ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMd7rEAz6FlgBshUYqBL4nLhL8GlG1MAYt4ztl9HwpUg";
  system-rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGe2Kw/vnzOLieMFeqCQGXNzPms3W6etDkCsXUhtOcMKBXz/HF2rrXwzB2+W3yiEtDkxKtv2DBbxRJVQ5V9RVPNVOlTrZFnT5zZv5+3mXuIvIwK0trE9Wn3kPgvjuYaJ1Ch+voMrkuFROBZpXHMEtaHWgSEK6CDjWEOSZYlXBZB/8QZYeof/Mg3iq8F/9ZET3uDv3kxLS+lbjjn2jVmV5pqxcs1HISdhgRNprKMm/YFVX/TgQ0LZkLEhCiSVmWZhGpeXeu+ILmEX8Q4nms9qGx2xQ18rmyS08JLSyUZfrJ5JIOXzoD9hqgMvqFbEOq2uzA8RcGJiSCckEAnik+/RoSd1KawE/r6wrGtlrBRG5R2W1bUgV2VvHCbJvOv5FSv437M7fmVYMGbZdIh3Hc6Uqww5jqlIsFIL93NZPuqb3Sk0P4gf6Mts9K8NtJUOEC/kNxpNOPNnGpt61Bq2Zs7F+1tqlGcPNbVNzdiPX4yqi9C7jmLklZx3/G+Rq/QeQVFbubzAXammdeNsaSdiJMJPJJgfGn4wKAuaUardli5ThvI6B4/ev0y2NFHxDuMNhRBErPNywmYNwzOlZYVrqf2zUOCSX7gLUJSDef+TAjSizljndMI9cEA8hkdkVD099ldVa6RSoI+/u+hWyJDqcmV7Yy+acQKN7MHMgZEhsy/r4k6Q==";
  system-keys = [ system-ed25519 system-rsa ];
  server-keys = system-keys ++ user-keys;
in {
  "smbcredentials.age".publicKeys = server-keys;
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
