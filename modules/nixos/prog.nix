{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    arduino-ide
    python3
    gdb
    clang-tools
    cmake
    codespell
    conan
    cppcheck
    doxygen
    gtest
    lcov
    platformio
    vcpkg
    vcpkg-tool
    stm32cubemx
    vscodium-fhs
  ];
}
