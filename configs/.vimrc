" vim: set ft=vimrc
set nocompatible              " be iMproved

""" vim-plug start """
call plug#begin('~/.vim/plugged')

" General plugins
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Plug 'benekastah/neomake' " neovim replacement for syntastic using neovim's job control functonality
Plug 'benmills/vimux'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'jamessan/vim-gnupg'
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" Ruby and Chef
Plug 'vim-ruby/vim-ruby'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vadv/vim-chef'

" JSON
Plug 'elzr/vim-json'

" Python
Plug 'klen/python-mode', { 'branch': 'develop' }

" Salt Stack
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'saltstack/salt-vim'

" colorschemes
Plug 'danielwe/base16-vim'

" All of your Plugins must be added before the following line
call plug#end()
""" vim-plug end """

" Color scheme setup
set t_Co=256
set bg=dark
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set path+=**
set wildmenu

set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smarttab

set number
set cursorline
set incsearch ignorecase smartcase

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

augroup myfiletypes
  autocmd!
  " autocmd! BufWritePost * Neomake
  " Ruby style.
  autocmd FileType ruby,eruby setlocal filetype=ruby.eruby.chef
  autocmd FileType ruby,eruby,chef,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,chef,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,chef,yaml setlocal colorcolumn=80
  " ?s are keywords
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
  autocmd FileType jinja setlocal ai sw=2 sts=2 et
augroup END

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
" let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

set statusline=%!MyStatusLine()

" Key bind
map nt :tabnew<CR>

let mapleader=","
nmap <leader>v :tabedit $MYVIMRC<CR>


" Let CtrlP show dofiles.
let g:ctrlp_show_hidden = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<cr>"

" Python-mode options
let g:pymode_lint_on_write = 0
let g:pymode_python = 'python3'

" Neomake
" let g:neomake_open_list = 2
" let g:neomake_ruby_enabled_makers = ['rubocop']
" let g:neomake_chef_enabled_makers = ['foodcritic, rubocop']

" Syntastic options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height=6
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_pylint_args = "--disable=C0111,C0103,W0621"

function! MyStatusLine()
    let statusline = ""
    " Filename (F -> full, f -> relative)
    let statusline .= "%f"
    " Buffer flags
    let statusline .= "%( %h%1*%m%*%r%w%) "
    " File format and type
    let statusline .= "(%{&ff}%(\/%Y%))"
    " Left/right separator
    let statusline .= "%="
    " Line & column
    let statusline .= "(%l,%c%V) "
    " Character under cursor (decimal)
    let statusline .= "%03.3b "
    " Character under cursor (hexadecimal)
    let statusline .= "0x%02.2B "
    " File progress
    let statusline .= "| %P/%L"
    return statusline
endfunction
