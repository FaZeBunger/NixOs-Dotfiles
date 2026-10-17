{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # VPN
    openvpn

    # Network & Port Scanning
    nmap
    rustscan

    # Web Enumeration
    gobuster
    feroxbuster
    nikto

    # Password Cracking
    hydra
    john
    hashcat

    # Active Directory, SMB & Windows
    smbclient-ng
    enum4linux-ng

    # Shells & Networking
    rlwrap

    # Exploitation Frameworks
    metasploit
  ];
}
