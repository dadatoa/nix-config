{ ... }:
{
  ###
  ### Xen project boot options
  ###
  boot.kernelParams = [
    "intel_iommu=on"
    ### hide pci device from dom0 to be abble to pass it on anther damain
    ### use ```lspci -k``` command on dom0 to get the pci address
    ### run ```xl pci-available-list``` to list all pci devices adresses available for domUs
    # "xen-pciback.hide=(03:00.0)"
    ];

  boot.initrd.systemd.enable = true; ## for booting xen 
  boot.initrd.kernelModules = [ 
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];
  ############################
  ############################
  ############################


  virtualisation.xen = {
    enable = true;
    boot.builderVerbosity = "info"; # Adds a handy report that lets you know which Xen boot entries were created.
    boot.params = [
      "vga=ask"
      "dom0=pvh" # Uses the PVH virtualisation mode for the Domain 0, instead of PV.
    ];
    dom0Resources = {
      memory = 1024; # Only allocates 1GiB of memory to the Domain 0, with the rest of the system memory being freely available to other domains.
      maxVCPUs = 2; # Allows the Domain 0 to use, at most, two CPU cores.
    };
  };
}
