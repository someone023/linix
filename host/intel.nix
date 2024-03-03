{pkgs, ...}: {
  # graphics drivers / HW accel

  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = ["i915"];
  };
  hardware.cpu.intel.updateMicrocode = true;
  environment.systemPackages = with pkgs; [intel-gpu-tools];
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
    ];
  };
}
