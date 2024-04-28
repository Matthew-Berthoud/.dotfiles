set nocompatible

syntax on
" colorscheme desert
set termguicolors
colorscheme catppuccin_frappe

set number
set relativenumber

" backspace bahind the start of your insert
set backspace=indent,eol,start

" Case sensitive searching
set noignorecase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Status bar enabled, even with one window open
set laststatus=2

" Normal mode reminders to use correct motions
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" Insert mode reminders to use correct motions
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" my tabbing config
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set smarttab

" matching curly brace if you hit enter after one
inoremap {<CR> {<CR>}<Esc>O
