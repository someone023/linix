{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {LC_ALL = "en_US.UTF-8";};

    history = {
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      share = true;
      save = 10000;
      size = 10000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      ignorePatterns = ["rm *" "pkill *" "kill *"];
    };

    dirHashes = {
      docs = "$HOME/Documents";
      dev = "$HOME/Dev";
      dots = "$HOME/linix";
      dl = "$HOME/Downloads";
    };

    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zmodload zsh/complist
      compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
      _comp_options+=(globdots)

      # Group matches and describe.
      zstyle ':completion:*' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' rehash true

      # open commands in $EDITOR
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^e" edit-command-line

      zstyle ':completion:*' menu yes select # search
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'

      # Fuzzy match mistyped completions.
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric

      # Don't complete unavailable commands.
      zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

      # Array completion element sorting.
      zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

      # Colors
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # Jobs id
      zstyle ':completion:*:jobs' numbers true
      zstyle ':completion:*:jobs' verbose true

      # Sort completions
      zstyle ":completion:*:git-checkout:*" sort false
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:files' sort false

      # fzf-tab
      zstyle ':fzf-tab:complete:_zlua:*' query-string input
      zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
      zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
      zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
      zstyle ':fzf-tab:*' switch-group ',' '.'
    '';

    initExtra = ''
      # set my zsh options, first things first
      # TODO: apparently there is a module option to do what I'm doing? gotta test the efficiency.
      source ${./opts.zsh}

      set -k
      export FZF_DEFAULT_OPTS="
      --color gutter:-1
      --color bg:-1
      --color bg+:-1

      --color fg:#a9b1d6
      --color fg+:#c0caf5
      --color hl:#41a6b5
      --color hl+:#41a6b5
      --color header:#41a6b5
      --color info:#e0af68
      --color marker:#1abc9c
      --color pointer:#1abc9c
      --color prompt:#e0af68
      --color spinner:#1abc9c
      --color preview-bg:#1f2335
      --color preview-fg:#41a6b5

      --prompt ' '
      --pointer ''
      --layout=reverse
      -m --bind ctrl-space:toggle,pgup:preview-up,pgdn:preview-down
      "

      zmodload zsh/zle
      zmodload zsh/zpty
      zmodload zsh/complist

      # Colors
      autoload -Uz colors && colors

      # Autosuggest
      ZSH_AUTOSUGGEST_USE_ASYNC="true"

      # Vi mode
      bindkey -v

      # Use vim keys in tab complete menu:
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history

      bindkey "^A" vi-beginning-of-line
      bindkey "^E" vi-end-of-line

      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
      xterm*|rxvt*|Eterm|aterm|kterm|gnome*|wezterm|kitty*)
        TERM_TITLE=$'\e]0;%n@%m: %1~\a'
          ;;
      *)
          ;;
      esac
    '';

    shellAliases = with pkgs; {
      # make sudo use aliases
      sudo = "sudo ";
      cd = "z";
      cleanup = "sudo nix-collect-garbage --delete-older-than 1d && nix-collect-garbage -d";
      bloat = "nix path-info -Sh /run/current-system";
      curgen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      repair = "nix-store --verify --check-contents --repair";
      run = "nix run $@";
      shell = "nix shell $@";
      # quality of life aliases
      cat = "${lib.getExe bat} --style=plain";
      grep = "${lib.getExe ripgrep}";
      du = "${lib.getExe du-dust}";
      ps = "${lib.getExe procs}";
      fcd = "cd $(find -type d | fzf)";
      ls = "${lib.getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      l = "ls -lF --time-style=long-iso --icons";
      sc = "sudo systemctl";
      jc = "sudo journalctl";
      scu = "systemctl --user ";
      jcu = "journalctl --user";
      la = "${lib.getExe eza} -lah --tree";
      tree = "${lib.getExe eza} --tree --icons --tree";
      diff = "diff --color=auto";
      vim = "neovide";
      killall = "pkill";

      # faster navigation
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";
    };

    plugins = with pkgs; [
      {
        name = "zsh-nix-shell";
        src = zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "forgit"; # i forgit :skull:
        file = "share/forgit/forgit.plugin.zsh";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "forgit";
          rev = "aa85792ec465ceee254be0e8e70d8703c7029f66";
          sha256 = "sha256-PGFYw7JbuYHOVycPlYcRItElcyuKEg2cGv4wn6In5Mo=";
        };
      }
      {
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "7c390ee3bfa8069b8519582399e0a67444e6ea61";
          sha256 = "sha256-wLpgkX53wzomHMEpymvWE86EJfxlIb3S8TPy74WOBD4=";
        };
      }
      {
        name = "zsh-autopair";
        file = "zsh-autopair.plugin.zsh";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
    ];
  };
}
