" Vundle requirements
set nocompatible    " be iMproved, required
filetype off        " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " vundle manages vundle, required
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree.git'
Plugin 'haya14busa/incsearch.vim'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'udalov/kotlin-vim'
Plugin 'tpope/vim-sleuth'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-fugitive'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
call vundle#end()   " required
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" file type association
au BufNewFile,BufRead *.gradle setf groovy

" Editor styling
let g:enabled_bold_font = 1
let g:enabled_italic_font = 1
let g:airline_theme = "hybrid"
set background=dark
colorscheme hybrid_material

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set number

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")


  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
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


" http://www.makeuseof.com/tag/5-things-need-put-vim-config-file/
" handle indentation
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set autoindent
set textwidth=80

set hidden


" http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR>
"
map <C-n> :NERDTreeToggle<CR>

" set backup dir to still generate backup and swp files but in dedicated dir
" https://stackoverflow.com/questions/607435/why-does-vim-save-files-with-a-extension
"
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
