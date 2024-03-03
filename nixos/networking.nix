{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8"
 ];
    defaultGateway = "64.23.128.1";
    defaultGateway6 = {
      address = "";
      interface = "eth0";
    };
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="64.23.135.245"; prefixLength=20; }
{ address="10.48.0.6"; prefixLength=16; }
        ];
        ipv6.addresses = [
          { address="fe80::245d:11ff:fe29:d86c"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "64.23.128.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 128; } ];
      };
            eth1 = {
        ipv4.addresses = [
          { address="10.124.0.3"; prefixLength=20; }
        ];
        ipv6.addresses = [
          { address="fe80::704e:d0ff:fe76:85f8"; prefixLength=64; }
        ];
        };
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="26:5d:11:29:d8:6c", NAME="eth0"
    ATTR{address}=="72:4e:d0:76:85:f8", NAME="eth1"
  '';
}
