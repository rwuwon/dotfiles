alias l="ls -lah --time-style=long-iso --group-directories-first $argv"
alias ll="ls -lh --time-style=long-iso --group-directories-first $argv"
alias mv="mv -i"
#alias -='cd -'     # deprecated
abbr -a -- - 'cd -' # Use this one from version 2.5.0 onwards
set PATH ~/scripts /usr/local/bin /usr/sbin $PATH

# x11-vim for +clipboard
alias vi='vimx'
alias vim='vimx'
