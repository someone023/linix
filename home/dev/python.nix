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
          ]
      ))

      mypy
    ];

    shellAliases = {
      pyp = "PYTHONPATH=. python";
    };
  };
}
