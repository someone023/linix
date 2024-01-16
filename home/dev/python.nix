{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # Python
      (python3.withPackages (
        ps:
          with ps; [
            # Misc
            pip
            setuptools
            dbus-python
          ]
      ))
    ];
  };
}
