{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    ## firmware stuff
    arduino-ide
    python3
    gdb
    clang-tools
    cmake
    codespell
    cppcheck
    doxygen
    gtest
    lcov
    platformio
    vcpkg
    vcpkg-tool
    stm32cubemx
    vscodium-fhs
    
    ## kali stuff
    nmap
    zenmap
    wireshark
    hashcat
    netcat
    thc-hydra
    sqlmap
    burpsuite
    metasploit
    john
    proxychains
  ];
}
