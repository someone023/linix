{pkgs, ...}: {
  # graphics drivers / HW accel

  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = ["i915.fastboot=1"];
  };
  hardware.cpu.intel.updateMicrocode = true;
  environment.systemPackages = with pkgs; [intel-gpu-tools];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
