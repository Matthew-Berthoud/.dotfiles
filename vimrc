" RESOURCES:
" How to Do 90% of What Plugins Do (With Just Vim): https://www.youtube.com/watch?v=XA2WjJbmmoM

" Disable vi compatibility, enter the modern era
set nocompatible

" Syntax highlighting and relative line numbers for easy jumping to correct location
syntax on
set number
set relativenumber

" More natural behavior with tabs
set shiftwidth=4
set tabstop=4
set autoindent
set expandtab

" Show the line and column position of cursor.
set ruler

" Show matching words during a search.
" set showmatch

" Highlight matching words while searching for text.
" set hlsearch

" Will recursively search directories for filenames for file-related command
set path+=**

" List of matches that you can ^n and ^p through to make choice
set wildmenu

" Shows current filename in all modes
set laststatus=2

