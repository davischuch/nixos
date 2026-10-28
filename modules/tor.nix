{pkgs, ...}:

{
  services.tor = {
    enable = true;
    openFirewall = true;

    enableGeoIP = false;

    client.enable = true;

    settings = {
      ORPort = 9001;
      ControlPort = 9051;

      AvoidDiskWrites = true;
    };
  };
}
