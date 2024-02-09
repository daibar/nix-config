{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8"
 ];
    defaultGateway = "161.35.224.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="161.35.235.55"; prefixLength=20; }
{ address="10.48.0.5"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="fe80::9003:75ff:feea:3673"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "161.35.224.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 128; } ];
      };
            eth1 = {
        ipv4.addresses = [
          { address="10.124.0.2"; prefixLength=20; }
        ];
        ipv6.addresses = [
          { address="fe80::9cee:bbff:fe29:43ae"; prefixLength=64; }
        ];
        };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="92:03:75:ea:36:73", NAME="eth0"
    ATTR{address}=="9e:ee:bb:29:43:ae", NAME="eth1"
  '';
}
