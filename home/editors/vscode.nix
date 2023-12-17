{ pkgs, ... }: {

  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.asvetliakov.vscode-neovim
      vscode-extensions.llvm-vs-code-extensions.vscode-clangd
      vscode-extensions.ms-vscode.cpptools
      vscode-extensions.xaver.clang-format
      vscode-extensions.ms-vscode.makefile-tools
      vscode-extensions.twxs.cmake
      vscode-extensions.vspacecode.whichkey
    ];
  };
}
