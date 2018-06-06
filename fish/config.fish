set PATH ~/scripts /usr/local/bin /usr/sbin $PATH

#alias -='cd -'     # deprecated
# Run this once in fish and it should set.
# abbr --add -- - 'cd -' # Use this one from version 2.5.0 onwards

# bash version: export GPG_TTY=$(tty)
export GPG_TTY=(tty)
export GPGKEY=10F5EEB0

# x11-vim for +clipboard
alias vi='vimx'
alias vim='vimx'

alias l='ls -lah --time-style=long-iso --group-directories-first $argv'
alias ll='ls -lh --time-style=long-iso --group-directories-first $argv'
alias lll='ls -lahrt --time-style=long-iso $argv'
alias l.='ls -d .* --time-style=long-iso'

alias mv='mv -i'

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
# https://news.ycombinator.com/item?id=11071754
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
