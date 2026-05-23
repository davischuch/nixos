{pkgs, ...}:

{
  services.tor = {
    enable = true;
    openFirewall = true;
    settings = {
      ORPort = 9001;
      ControlPort = 9051;
      BandWithRate = "10 Mbytes";
    };
  };
}
