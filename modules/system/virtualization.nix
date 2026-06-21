{config, pkgs, ...}:
{
  # Enable IOMMU and virtualization kernel modules
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" ];
  boot.kernelModules = [ "kvm-amd" "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" ];

  virtualisation.docker = {
    enable = true;
  };

  # These packages are already installed elsewhere but keep them
  # here because they are important for virtualization kinda... 🫠
  environment.systemPackages = with pkgs; [
    lazydocker
    docker-compose
  ];

  # Enable libvirt and virt-manager
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };
  programs.virt-manager.enable = true;

  # Add your user to the libvirtd group
  users.users.ebeyl.extraGroups = [ "libvirtd" "kvm" "docker" ];


  systemd.tmpfiles.rules = [
    "L+ /var/lib/libvirt/hooks/qemu - - - - /etc/nixos/qemu-hook.sh"
  ];

  # Add GPU rom to nixos and copy it to /etc/vgabios/rtx3060.rom
  environment.etc."vgabios/rtx3060.rom".source = ../../roms/MSI.RTX3060.12288.210122_3.rom;
}
