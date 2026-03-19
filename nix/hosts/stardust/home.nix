{ config, pkgs, lib, ... }:
# https://nixos-and-flakes.thiscute.world/best-practices/accelerating-dotfiles-debugging
# https://www.foodogsquared.one/posts/2023-03-24-managing-mutable-files-in-nixos/
let
  dotfiles = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles";
in
{
  xdg.configFile = {
# Use only for testing. Beware of "recursion"!
# Switch between systems by first commenting out BOTH sections
#    fish.source = "${dotfiles}/fish";
#    tmux.source = "${dotfiles}/tmux";
#    vim.source = "${dotfiles}/vim";
  };

  targets.genericLinux.enable = true;
  #nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "io";
  home.homeDirectory = "/home/io";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    bat
    btdu
    cpufetch
    deno
    emoji-picker
    fastfetch
    #ghostty
    hello
    #kitty
    links2
    #man
    newsboat
    nix
    nix-output-monitor
    trippy
    viu
    yt-dlp

    # Previously via Flatpak:
    anki
    bitwarden-desktop
    joplin-desktop
    #musescore   # Run with: nixGL mscore
    signal-desktop
    stellarium
    telegram-desktop

    # CTF
    cyberchef
    stegseek

    # Unfree Packages
    #hello-unfree
    #zoom-us

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
  ];

#  nixpkgs.config.allowUnfreePredicate = pkg:
#    builtins.elem (lib.getName pkg) [
#      # Add additional package names here
#      "hello-unfree"
#      "zoom-us"
#    ];

#  { nixpkgs.config.allowUnfreePredicate = pkg:
#    builtins.elem (lib.getName pkg) [
#      "example-unfree-package"
#  ];
#  }


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".bash_aliases".text = ''
      alias f='fish'
      '';
    #".vimrc".source = /home/${config.home.username}/nix/dotfiles/vim/vimrc;
    ".vim/myfiletypes.vim".source = /home/${config.home.username}/nix/dotfiles/vim/myfiletypes.vim;
    ".config/tmux/tmux.conf".source = /home/${config.home.username}/dotfiles/tmux/tmux.conf;
    ".config/fish/config.fish".source = /home/${config.home.username}/dotfiles/fish/config.fish;
    ".config/fish/conf.d/grc.fish".source = /home/${config.home.username}/dotfiles/fish/grc.fish;
    ".config/fish/functions/fish_prompt.fish".source = /home/${config.home.username}/dotfiles/fish/fish_prompt.fish;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/io/etc/profile.d/hm-session-vars.sh
  #
#  home.sessionVariables = {
#    # EDITOR = "emacs";
#  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      nerdtree
      vim-airline
      vim-indent-guides
      vim-nix
      vim-sensible
    ];
    settings = { ignorecase = true; };
    extraConfig = ''
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Mar 25
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Default leader key is \ but let's add space to that
" https://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim
nnoremap <SPACE> <Nop>
let mapleader = " "

"nnoremap <Leader>s :source $MYVIMRC
nnoremap <Leader>s :source /home/io/dotfiles/vim/vimrc

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
"  syntax on
"  set hlsearch
"endif
syntax enable   " This is simpler.
set hlsearch

filetype indent plugin on

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " Use 50/72 for git
  " Use gq<motion> to reformat
  "
  "autocmd FileType text setlocal textwidth=78
  autocmd FileType text setlocal textwidth=0

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit


" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
"set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
"filetype indent plugin on

" Enable syntax highlighting
"syntax on

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
" Read :h 22.4
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
"set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
"set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
"set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
"set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
"set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Always display full path
" This interferes with row/col display. Do not use.
"set statusline+=%F

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" unnamed unnamedplus autoselect autoselectplus
" unnamed for mac, unnamedplus for linux
"set clipboard=unnamed
set clipboard=unnamedplus

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number
set relativenumber

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F9> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F9>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set softtabstop=2
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
set shiftwidth=2
set tabstop=2


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>
" Enter is snappier and better:
nnoremap <silent> <Backspace> :nohls<CR>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Use list mode to show spaces, tabs and carriage returns  and end of lines
"set wrap linebreak nolist
" Keep words together
set linebreak

nmap <Leader>W :set wrap<CR>
nmap <Leader>w :set nowrap<CR>

so $HOME/.vim/myfiletypes.vim

"nmap <C-i> <C-^>
nmap <Leader><Tab> :bn<CR>  " Because <Tab> interferes with <C-i>
nmap <S-Tab> :bp<CR>
"nmap <M-w> :bd<CR>

nmap <Leader>j gt
nmap <Leader>k gT

nmap <Left> <C-W>h
nmap <Down> <C-W>j
nmap <Up> <C-W>k
nmap <Right> <C-W>l
nmap <S-Left> <C-W><
nmap <S-Down> <C-W>-
nmap <S-Up> <C-W>+
nmap <S-Right> <C-W>>

" Ctrl-movement keys are better for window switching
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

"spacebar=page down; shift+spacebar=page up
"nnoremap <Space> <C-d>
"nnoremap <S-Space> <C-u>

"------------------------------------------------------------
" Spell Checking
" Trailing <Esc> because <CR> sets :nohls in previous section
nnoremap <F7> :setlocal spell spelllang=en_au<CR><Esc>
" a to maintain insert mode.
inoremap <F7> <Esc>:setlocal spell spelllang=en_au<CR>a
" <S-F7> doesn't work in CLI vim; only gvim. Using F8 for compatibility.
nnoremap <F2> :set nospell<CR>
inoremap <F2> <Esc>:set nospell<CR>a

"------------------------------------------------------------
" Colorschemes

set background=dark
"set background=light
"colorscheme sorbet
colorscheme retrobox

nmap <Leader>c :set background=light<CR>:colorscheme retrobox<CR>
nmap <Leader>C :set background=dark<CR>:colorscheme retrobox<CR>

"------------------------------------------------------------
"nmap <F12> :set syntax=python<CR>
"nnoremap <F5> "=strftime("%c")<CR>P
"inoremap <F5> <C-R>=strftime("%c")<CR>
"nnoremap <F5> "=strftime("%FT%T%z")<CR>P
nmap <Leader>t "=strftime("%FT%T%z")<CR>P
inoremap <F5> <C-R>=strftime("%FT%T%z")<CR>

"------------------------------------------------------------
" Set title caps for line - see :h gu
" map <F4> :s/\v<(.)(\w*)/\u\1\L\2/g
set scrolloff=5                         " Keep 5 lines below and above the cursor
set t_Co=256
"set smartindent
" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" I always forget: Ctrl+a for increment (ADD), Ctrl+x for subtract (X).
" The help file will not say increment!

set colorcolumn=+1

"au BufNewFile,BufRead *.py
"    \ set foldmethod=indent

" nnoremap <F10> :!python3 %<CR>

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

let g:indent_guides_enable_on_vim_startup = 1

" Show tabs and trailing characters as - and ·
set listchars=tab:->,trail:·
set list
nmap <Leader>l :set nolist<CR>
nmap <Leader>L :set list<CR>

" https://dev.to/iggredible/debugging-in-vim-with-vimspector-4n0m
" https://github.com/puremourning/vimspector

" Tips & Tricks
" Write to read-only file:
" :w !sudo tee %
    '';
    };

# Don't use this as it interferes with home.file above
# Or just use ~/.config/fish/conf.d/config.fish
#  programs.fish = {
#    enable = true;
#    interactiveShellInit = ''
#      set fish_greeting # Disable greeting
#    '';
#  };
}
