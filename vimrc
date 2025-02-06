" RESOURCES:
" How to Do 90% of What Plugins Do (With Just Vim): https://www.youtube.com/watch?v=XA2WjJbmmoM

" Disable vi compatibility, enter the modern era
set nocompatible

" Syntax highlighting and relative line numbers for easy jumping to correct location
syntax on
color default
set number
set relativenumber

" More natural behavior with tabs
set shiftwidth=4
set tabstop=4
set autoindent
set expandtab

" don't expand tabs to spaces for Go files
autocmd FileType go setlocal noexpandtab

" Show the line and column position of cursor.
set ruler

" Show matching words during a search.
set showmatch

" Highlight matching words while searching for text.
set hlsearch

" Will recursively search directories for filenames for file-related command
set path+=**

" List of matches that you can ^n and ^p through to make choice
set wildmenu

" Ignore things when showing autocomplete options
set wildignore+=**/vendor/**    " php with composer
set wildignore+=**/tags         " ctags
set wildignore+=**/node_modules/**
set wildignore+=**/react/** "quality of life for flathat project, don't include the submodule

" Shows current filename in all modes
set laststatus=2

" Vim will know when file changes on disk.
" If you save and it's like yo your buffer changed,
" you can pull in the new verison with `:checktime`
" This is helpful when you run `go fmt` in another terminal tab, for example.
set autoread

