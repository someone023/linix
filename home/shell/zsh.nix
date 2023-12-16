{ inputs
, config
, pkgs
, lib
, ...
}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "6d059a3634c4880e8c9bb30ae565465601fb5bd2";
          sha256 = "0axhdjvhaw6qw0cdsjai98hhim31baiwgpb10da5ma7zix6b9mfh";
        };
      }
    ];
    autocd = true;
    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      dots = "$HOME/linix";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
    };
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/zsh_history";
    };

    initExtra = ''
      # fix autocomplete
      bindkey "''${key[Up]}" up-line-or-search
      
      # search history based on what's typed in the prompt
      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "^[OA" history-beginning-search-backward-end
      bindkey "^[OB" history-beginning-search-forward-end

      # C-right / C-left for word skips
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

      # C-Backspace / C-Delete for word deletions
      bindkey "^[[3;5~" forward-kill-word
      bindkey "^H" backward-kill-word

      # Home/End
      bindkey "^[[OH" beginning-of-line
      bindkey "^[[OF" end-of-line

      # open commands in $EDITOR with C-e
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^e" edit-command-line

      # case insensitive tab completion
      zstyle ':completion:*' completer _complete _ignored _approximate
      zstyle ':completion:*' list-colors '\'
      zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
      zstyle ':completion:*' verbose true
      _comp_options+=(globdots)

      ${lib.optionalString config.services.gpg-agent.enable ''
        gnupg_path=$(ls $XDG_RUNTIME_DIR/gnupg)
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/$gnupg_path/S.gpg-agent.ssh"
      ''}

      ${lib.optionalString config.programs.kitty.enable ''
        if test -n "$KITTY_INSTALLATION_DIR"; then
          export KITTY_SHELL_INTEGRATION="enabled"
          autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
          kitty-integration
          unfunction kitty-integration
        fi
      ''}
    '';

    shellAliases =
      {
        grep = "grep --color";
        ip = "ip --color";
        l = "eza -la";
        la = "eza -a";
        md = "mkdir -p";
        ppc = "powerprofilesctl";
        pf = "powerprofilesctl launch -p performance";

        us = "systemctl --user";
        rs = "sudo systemctl";
      }
      // lib.optionalAttrs (config.programs.bat.enable == true) { cat = "bat"; };
    shellGlobalAliases = { eza = "eza --icons --git"; };
  };
}
