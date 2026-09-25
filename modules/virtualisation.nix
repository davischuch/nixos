# seen in this blog post: https://crescentro.se/posts/windows-vm-nixos/
{
  users,
  pkgs,
  ...
}:

{
  # Set up virtualisation
  virtualisation.libvirtd = {
      enable = true;

      # Enable TPM emulation (for Windows 11)
      qemu = {
        swtpm.enable = true;
      };
  };

  # Enable USB redirection
  virtualisation.spiceUSBRedirection.enable = true;

  # Allow VM management
  users.groups.libvirtd.members = [ "davi" ];
  users.groups.kvm.members = [ "davi" ];

  # Enable VM networking and file sharing
  environment.systemPackages = with pkgs; [
      # ... your other packages ...
      gnome-boxes # VM management
      dnsmasq # VM networking
      phodav # (optional) Share files with guest VMs
  ];
}
