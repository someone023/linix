{
  pkgs,
  config,
  ...
}:{
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # utils
    file
    du-dust
    duf
    fd
    ripgrep

    # file managers
    ranger
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };
    btop.enable = true;
    eza.enable = true;
    ssh.enable = true;

  };
}
