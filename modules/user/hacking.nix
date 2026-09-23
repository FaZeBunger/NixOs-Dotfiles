{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
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
    smbclient
    enum4linux-ng
    impacket

    # Shells & Networking
    openbsd-netcat
    rlwrap

    # Exploitation Frameworks
    metasploit
  ];
}
