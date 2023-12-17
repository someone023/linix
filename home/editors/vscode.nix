{ pkgs, ... }: {

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [
      rustup
      zlib
      openssl.dev
      pkg-config

      cmake
      clang
      clang-tools
      lldb

    ]);
  };
}
