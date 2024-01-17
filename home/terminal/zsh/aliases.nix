{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with pkgs; {
  nvim = "/home/wasd/nixvim/result/bin/nvim";
  cat = "${getExe bat} --style=plain";
  uuid = "cat /proc/sys/kernel/random/uuid";
  grep = getExe ripgrep;
  wget = "wget --hsts-file=\"${config.xdg.dataHome}/wget-hsts\"";
  fzf = getExe skim;
  untar = "tar -xvf";
  untargz = "tar -xzf";
  MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  du = getExe du-dust;
  ps = getExe procs;
  m = "mkdir -p";
  cd = "z";
  fcd = "cd $(find -type d | fzf)";
  l = "ls -lF --time-style=long-iso --icons";
  sc = "sudo systemctl";
  scu = "systemctl --user ";
  la = "${getExe eza} -lah --tree";
  ls = "${getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
  tree = "${getExe eza} --tree --icons --tree";
  kys = "shutdown now";
  rebuild = "sudo nixos-rebuild switch --flake .#linix";
  mnt = "udisksctl mount -b";
  umnt = "udisksctl unmount -b";
  burn = "pkill -9";
  diff = "diff --color=auto";
  ".." = "cd ..";
  "..." = "cd ../../";
  "...." = "cd ../../../";
  "....." = "cd ../../../../";
  "......" = "cd ../../../../../";
}
