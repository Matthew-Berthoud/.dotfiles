set nocompatible

syntax on
colorscheme desert

set number
set relativenumber

" backspace bahind the start of your insert
set backspace=indent,eol,start

" Case sensitive searching
set noignorecase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

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


nnoremap <C-J> <C-w><C-J>
nnoremap <C-K> <C-w><C-H>
nnoremap <C-L> <C-w><C-L>
nnoremap <C-H> <C-w><C-H>

nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
