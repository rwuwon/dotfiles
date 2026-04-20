set nocompatible

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" Default leader key is \ but let's add space to that
" https://stackoverflow.com/questions/446269/can-i-use-space-as-mapleader-in-vim
nnoremap <SPACE> <Nop>
let mapleader = " "
inoremap jk <esc>

" Don't use Ex mode, use Q for formatting
map Q gq

"nmap <F12> :set syntax=python<CR>
"syntax enable

"filetype indent plugin on
set laststatus=2
set confirm
set cmdheight=2
set number
set cc=80
set scrolloff=5     " Keep 5 lines below and above the cursor
set t_Co=256
set ignorecase
set smartcase
set relativenumber
set softtabstop=2
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent
set linebreak
set colorcolumn=+1
set clipboard=unnamedplus
set backup      " keep a backup file (restore to previous version)
set undofile    " keep an undo file (undo changes after closing)
set backupdir=/tmp

nnoremap <Leader>s :source $HOME/nix/dotfiles/nvim/init.vim<CR>


nmap <Leader>l :set list!<CR>:set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»<CR>
nmap <Leader>n :set number!<CR>:set relativenumber!<CR>
nmap <Leader>w :set nowrap!<CR>
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
nmap <Leader>p :set clipboard=unnamedplus<CR>
nmap <Leader>P :set clipboard=unnamed<CR>

nmap <Leader><Tab> :bn<CR>  " Because <Tab> interferes with <C-i>
nmap <S-Tab> :bp<CR>
nmap <Leader>j gt
nmap <Leader>k gT

nmap <Leader>t "=strftime("%FT%T%z")<CR>P
inoremap <F5> <C-R>=strftime("%FT%T%z")<CR>

"https://vimtricks.wiki/posts/hex-edit-with-xxd
"Always open binary files with vim -b or :set binary to prevent Vim from adding a trailing newline or converting line endings"
"Convert to hex:
nmap <Leader>h :%!xxd<CR>
"Write back to binary:
nmap <Leader>H :%!xxd -r

noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

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

" Window switching
nmap <Left> <C-W>h
nmap <Down> <C-W>j
nmap <Up> <C-W>k
nmap <Right> <C-W>l
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l

" Resize
nmap <S-Left> <C-W><
nmap <S-Down> <C-W>-
nmap <S-Up> <C-W>+
nmap <S-Right> <C-W>>

" Spell Checking - Test: color colour
nnoremap <F7> :setlocal spell!<CR>:setlocal spelllang=en_au<CR><Esc>
inoremap <F7> <Esc>:setlocal spell!<CR>:setlocal spelllang=en_au<CR>a

" Set title caps for line - see :h gu
map <F4> :s/\v<(.)(\w*)/\u\1\L\2/g
" Colorschemes
set notermguicolors
"set background=dark
set background=light
colorscheme retrobox

" Map Space-c to toggle between light and dark
" https://jnrowe.github.io/articles/tips/Toggling_settings_in_vim.html
function! Switch_background()
    if &background == "light"
        set background=dark
    else
        set background=light
    endif
endfunction
map <Leader>c :call Switch_background()<CR>

" See also nvim.nix for plugins
"call plug#begin()
"  Plug 'ctrlpvim/ctrlp.vim'
"  Plug 'will133/vim-dirdiff'
"  Plug 'ibhagwan/fzf-lua'
"  Plug 'lukas-reineke/indent-blankline.nvim'
"  Plug 'nvim-lualine/lualine.nvim'
"  Plug 'jeffkreeftmeijer/neovim-sensible'
"  Plug 'm4xshen/autoclose.nvim'
"  Plug 'nvim-tree/nvim-tree.lua'
"  Plug 'farmergreg/vim-lastplace'
"  Plug 'LnL7/vim-nix/'
"call plug#end()

" Tips & Tricks
" -------------
" Write to read-only file:
" :w !sudo tee %
"
" Ctrl-a/x for increment/decrement
" Visual select, ctrl-g, numerical list
"
" Reverse order of lines:
" :g/^/m0
" https://vim.fandom.com/wiki/Reverse_order_of_lines

" -------------------
" Start of lua config
" -------------------
lua << END
-- nvim-tree:
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("autoclose").setup({
  keys = {
    ["("] = { escape = false, close = true, pair = "()" },
    ["["] = { escape = false, close = true, pair = "[]" },
    ["{"] = { escape = false, close = true, pair = "{}" },

    [">"] = { escape = true, close = false, pair = "<>" },
    [")"] = { escape = true, close = false, pair = "()" },
    ["]"] = { escape = true, close = false, pair = "[]" },
    ["}"] = { escape = true, close = false, pair = "{}" },

    ['"'] = { escape = true, close = true, pair = '""' },
    ["'"] = { escape = true, close = false, pair = "''" },
    ["`"] = { escape = true, close = true, pair = "``" },
  },
  options = {
    disabled_filetypes = { "text" },
    disable_when_touch = false,
    touch_regex = "[%w(%[{]",
    pair_spaces = false,
    auto_indent = true,
    disable_command_mode = false,
  },
})

-- indent-blankline
require("ibl").setup()

---@type nvim_tree.config
local config = {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
require("nvim-tree").setup(config)

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'powerline_dark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    --lualine_a = {'mode'},
    lualine_a = {
    {
      'filename',
      file_status = true,      -- Displays file status (readonly status, modified status)
      newfile_status = false,  -- Display new file status (new file means no write after created)
      path = 3,                -- 0: Just the filename
                               -- 1: Relative path
                               -- 2: Absolute path
                               -- 3: Absolute path, with tilde as the home directory
                               -- 4: Filename and parent dir, with tilde as the home directory

      shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                               -- for other components. (terrible name, any suggestions?)
                               -- It can also be a function that returns
                               -- the value of `shorting_target` dynamically.
      symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for newly created file before first write
      }
    }
  },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

END
