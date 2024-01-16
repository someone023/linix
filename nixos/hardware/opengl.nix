{pkgs, ...}: {
  # graphics drivers / HW accel
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      mesa
      #intel-compute-runtime #for OpenCL-based applications
      intel-ocl
      intel-media-driver
    ];
  };
}
