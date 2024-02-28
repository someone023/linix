{
  osConfig,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (osConfig.modules.style.colorScheme) colors;
in {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {LC_ALL = "en_US.UTF-8";};

    history = {
      # share history between different zsh sessions
      share = true;
      # avoid cluttering $HOME with the histfile
      path = "${config.xdg.dataHome}/zsh/zsh_history";
      # saves timestamps to the histfile
      extended = true;
      # optimize size of the histfile by avoiding duplicates
      # or commands we don't need remembered
      save = 1000;
      size = 1000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      ignorePatterns = ["rm *" "pkill *" "kill *"];
    };

    dirHashes = {
      docs = "$HOME/Documents";
      dev = "$HOME/dev";
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

    initExtraFirst = ''
      # set my zsh options, first things first
      source ${./opts.zsh}

      set -k
      export FZF_DEFAULT_OPTS="
      --color gutter:-1
      --color bg:-1
      --color bg+:-1
      --color fg:"#a9b1d6";
      --color fg+:"#c0caf5";
      --color hl:"#41a6b5";
      --color hl+:"#41a6b5";
      --color header:"#41a6b5";
      --color info:"#e0af68";
      --color marker:"#1abc9c";
      --color pointer:"#1abc9c";
      --color prompt:"#e0af68";
      --color spinner:"#1abc9c";
      --color preview-bg:"#1f2335";
      --color preview-fg:"#41a6b5";
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
      xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty|kitty*)
        TERM_TITLE=$'\e]0;%n@%m: %1~\a'
          ;;
      *)
          ;;
      esac
    '';

    shellAliases = with pkgs; {
      # make sudo use aliases
      sudo = "sudo ";

      # nix specific aliases
      cleanup = "sudo nix-collect-garbage --delete-older-than 3d && nix-collect-garbage -d";
      bloat = "nix path-info -Sh /run/current-system";
      curgen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
      gc-check = "nix-store --gc --print-roots | egrep -v \"^(/nix/var|/run/\w+-system|\{memory|/proc)\"";
      repair = "nix-store --verify --check-contents --repair";
      run = "nix run";
      search = "nix search";
      shell = "nix shell";
      build = "nix build $@ --builders \"\"";

      cat = "${lib.getExe bat} --style=plain";
      grep = "${lib.getExe ripgrep}";
      du = "${lib.getExe du-dust}";
      ps = "${lib.getExe procs}";
      mp = "mkdir -p";
      fcd = "cd $(find -type d | fzf)";
      ls = "${lib.getExe eza} -h --git --icons --color=auto --group-directories-first -s extension";
      la = "${lib.getExe eza} -a -h --git --icons --color=auto --group-directories-first -s extension";
      l = "ls -lF --time-style=long-iso --icons";
      # system aliases
      sc = "sudo systemctl";
      jc = "sudo journalctl";
      scu = "systemctl --user ";
      jcu = "journalctl --user";
      tree = "${lib.getExe eza} --tree --icons=always";
      http = "${lib.getExe python3} -m http.server";
      burn = "pkill -9";
      diff = "diff --color=auto";
      killall = "pkill";

      # insteaed of querying some weird and random"what is my ip" service
      # we get our public ip by querying opendns directly.
      # <https://unix.stackexchange.com/a/81699>
      canihazip = "dig @resolver4.opendns.com myip.opendns.com +short";
      canihazip4 = "dig @resolver4.opendns.com myip.opendns.com +short -4";
      canihazip6 = "dig @resolver1.ipv6-sandbox.opendns.com AAAA myip.opendns.com +short -6";

      # faster navigation
      # "lmao"
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
        name = "fast-syntax-highlighting";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "7c390ee3bfa8069b8519582399e0a67444e6ea61";
          sha256 = "sha256-wLpgkX53wzomHMEpymvWE86EJfxlIb3S8TPy74WOBD4=";
        };
      }
    ];
  };
}
