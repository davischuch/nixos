{
  services.tor = {
    enable = true;
    openFirewall = true;
    relay = {
      enable = true;
      role = "relay";
    };
    settings = {
      ORPort = 9001;
      ControlPort = 9051;
      BandWithRate = "10 Mbytes";
    };
  };
}
