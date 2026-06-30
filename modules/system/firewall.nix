{ config, hostname, ... }:
{

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 40 443 11434 7000 42069 ];
      allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
    networkmanager = {
      enable = true;
    };

    hostName = hostname;
  };
}
