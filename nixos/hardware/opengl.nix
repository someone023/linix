{
  pkgs,
  lib,
  ...
}: {
  # graphics drivers / HW accel
  hardware.opengl = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        mesa
        #intel-compute-runtime #for OpenCL-based applications
        intel-ocl
        intel-media-driver
      ];
    };

    enableRedistributableFirmware = lib.mkDefault true;
  };
}
