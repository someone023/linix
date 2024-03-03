{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-gpu-intel
  ];
  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = [];

    extraModprobeConfig = ''
      options i915 enable_fbc=1 enable_guc=2
      options snd_hda_intel enable=0,1 power_save=1 power_save_controller=Y
    '';
  };

  hardware.cpu.intel.updateMicrocode = true;
  environment.systemPackages = with pkgs; [intel-gpu-tools];
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
    ];
  };
}
