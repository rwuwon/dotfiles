if status is-interactive
  # Commands to run in interactive sessions can go here
  set -g fish_greeting # Suppress greeting
  uname -a
  set PATH ~/scripts /usr/sbin $PATH

  # Stop abbreviated paths:
  set -g fish_prompt_pwd_dir_length 0

  set EDITOR vim
  set VISUAL vim

  #set MANPATH $HOME/.nix-profile/share/man /nix/var/nix/profiles/default/share/man /usr/share/man
  # Use bat/batcat as pager for man pages - https://kszenes.github.io/blog/2024/Manpager/
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"  # Use if formatting is wonky:
  # Run this once in fish and it should set.
  abbr --add -- - 'cd -' # Use this one from version 2.5.0 onwards
  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias .....='cd ../../../..'
  alias ......='cd ../../../../..'

  # Short aliases
  alias bc='bc -l'
  alias bt='btop'
  alias l 'ls -alh --group-directories-first'
  alias la 'ls -alh --group-directories-first'
  alias l. 'ls -d .*'
  alias ld 'ls -d */'
  alias ll 'ls -l --group-directories-first'
  alias lll='ls -lahrt --time-style=long-iso --group-directories-first'
  alias less='less -i'
  alias t='tmux a; or tmux'
  alias ddd='tmux detach'
  alias s='sudo -i'
  alias sd='sudo'
  alias cp='cp -vi'
  alias mv='mv -vi'
  alias md='mkdir -p'
  alias yt-dlp='yt-dlp --no-mtime'

  alias dfh='df -h'
  alias f='fish'
  alias ggg='echo "cd ~/dotfiles/ && git pull:" && cd ~/dotfiles/ && gl && echo "cd ~/nix/ && git pull:" && cd ~/nix/ && gl'
  alias glll='echo "cd ~/dotfiles/ && git pull:" && cd ~/dotfiles/ && gl && echo "cd ~/nix/ && git pull:" && cd ~/nix/ && gl'
  #alias ho='sudo nixos-rebuild switch --flake .'
  #alias hov='sudo nixos-rebuild -v switch --flake .'
  alias nv="nvim -p"
  alias nvd="nvim -d"
  alias vi="vim -p"
  alias vim="vim -p"
  alias vimd="nvim -d"
  alias vimdiff="nvim -d"

  # oh-mh-zsh git aliases
  alias g=git
  alias ga='git add'
  alias gc='git commit -v'
  alias 'gc!'='git commit -v --amend'
  alias gca='git commit -v -a'
  alias 'gca!'='git commit -v -a --amend'
  alias gcam='git commit -a -m'
  alias gd='git diff'
  alias gdca='git diff --cached'
  alias gdct='git describe --tags `git rev-list --tags --max-count=1`'
  alias gdcw='git diff --cached --word-diff'
  alias gdt='git diff-tree --no-commit-id --name-only -r'
  alias gdw='git diff --word-diff'
  alias ghh='git help'
  alias gl='git pull'
  alias glg='git log --stat'
  alias glgg='git log --graph'
  alias glgga='git log --graph --decorate --all'
  alias glgm='git log --graph --max-count=10'
  alias glgp='git log --stat -p'
  alias glo='git log --oneline --decorate'
  alias globurl='noglob urlglobber '
  alias gp='git push'
  alias gpd='git push --dry-run'
  alias gpv='git push -v'
  alias gst='git status'
end
