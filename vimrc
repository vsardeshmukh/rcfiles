" Vimrc file, 
" adopted from http://phuzz.org
" modified by Vivek Sardeshmukh
" evolved over years and years during my grad school

set nocompatible    " use vim defaults

" Vundle and YCM 
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'git://github.com/VundleVim/Vundle.vim'
  Plugin 'git://github.com/Valloric/YouCompleteMe'
  Plugin 'git://github.com/scrooloose/nerdtree'
  Plugin 'git://github.com/majutsushi/tagbar'
  Plugin 'git://github.com/vsardeshmukh/ctags.vim'
  Plugin 'git://github.com/tpope/vim-unimpaired'
  Plugin 'git://github.com/tibabit/vim-templates'
  Plugin 'git://github.com/Konfekt/FastFold'
  "Plugin 'git://github.com/tmhedberg/SimpylFold'
  Plugin 'git://github.com/vim-scripts/genutils.git'
  "Plugin 'git://github.com/vim-scripts/perforce.git'
  Plugin 'git://github.com/vim-scripts/scratch.git'
  "Plugin 'git://github.com/zxqfl/tabnine-vim'
  "Plugin 'git://github.com/bling/vim-bufferline'
  Plugin 'git://github.com/MarcWeber/vim-addon-mw-utils'
  Plugin 'git://github.com/tomtom/tlib_vim'
  "Plugin 'git://github.com/garbas/vim-snipmate'
  Plugin 'git://github.com/altercation/vim-colors-solarized.git'
  "Plugin 'git://github.com/vim-airline/vim-airline'
  "Plugin 'git://github.com/vim-airline/vim-airline-themes'
call vundle#end()
filetype plugin indent on
" Clearcase files
augroup filetypedetect
   au BufNewFile,BufRead *@@/*
    \ if expand("<afile>") =~ '@@' |
    \ exe "doau filetypedetect BufRead " . expand("<afile>:s?@@.*$??") |
    \ endif
augroup END
autocmd BufNewFile,BufRead *@@/* set filetype=cpp
" Perforce files
autocmd BufNewFile,BufRead *@* set filetype=cpp
autocmd BufNewFile,BufRead *.C set filetype=cpp

" Vivek's preferences
set ls=2            " allways show status line 
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set expandtab
set softtabstop=4
set scrolloff=3     " keep 3 lines when scrolling
set showcmd         " display incomplete commands
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set novisualbell    " turn off visual bell
set nobackup        " do not keep a backup file
set number          " show line numbers
set ignorecase      " ignore case when searching
"set noignorecase   " don't ignore case
set title           " show title in console title bar
set ttyfast         " smoother changes
"set ttyscroll=0        " turn off scrolling, didn't work well with PuTTY
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files
"set viminfo='20,<50,s10,h
set tags=./tags,tags
set nocst           "disable cstags 
"set autoindent     " always set autoindenting on
"set smartindent        " smart indent
"set cindent            " cindent
set noautoindent
set nosmartindent
set nocindent  

"spell check
set nospell
"set autowrite      " auto saves changes when quitting and swiching buffer
"set expandtab      " tabs are converted to spaces, use only when required
set sm             " show matching braces, somewhat annoying...
"set nowrap         " don't wrap lines

syntax on           " syntax highlighing

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
syntax enable
set background=light
colorscheme solarized
" ------------------------------------------------------------------
set t_Co=256
"let g:airline_powerline_fonts = 1

filetype plugin on  " vim-latex plugin settings below 
let g:tex_flavor='pdflatex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode $*'  
let g:Tex_ViewRule_pdf='evince' 
let g:Tex_FoldedEnvironments='tikzpicture, column, verbatim,comment,eq,gather,align,figure,table,thebibliography,keywords,abstract,titlepage,solution,proof,algorithm'
let g:Tex_MultipleCompileFormats='pdf, aux'
"disable vim-latex shortcuts
let g:Imap_FreezeImap=1

"if has("gui_running")
"    " See ~/.gvimrc
"    set guifont=Monospace\ 10  " use this font
"    set lines=50       " height = 50 lines
"    set columns=100        " width = 100 columns
"    set background=light   " adapt colors for background
"    set selectmode=mouse,key,cmd
"    set keymodel=
"else
"   colorscheme biogoo    " use this color scheme
"    set background=dark        " adapt colors for background
"endif

if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Filetypes (au = autocmd)
    au FileType helpfile set nonumber      " no line numbers when viewing help
    au FileType helpfile nnoremap <buffer><cr> <c-]>   " Enter selects subject
    au FileType helpfile nnoremap <buffer><bs> <c-T>   " Backspace to go back
    
    " When using mutt, text width=72
    au FileType txt  set textwidth=80
    au FileType tex  set spell
    au FileType mail set textwidth=72
    au FileType cpp,c,C,java,sh,pl,php,asp,tcl,py  set autoindent
    au FileType cpp,c,C,java,sh,pl,php,asp,tcl,py  set list 
    au FileType cpp,c,C,java,sh,pl,php,asp,tcl,py  set listchars=tab:>-
    au FileType cpp,c,C,java,sh,pl,php,asp,tcl,py  set smartindent
    au FileType cpp,c,C,java,sh,pl,php,asp,tcl  set cindent
    au FileType java  set complete=.,w,b,u,t,i
    au FileType cpp,c,C,qel,tcl  set foldmethod=indent 
    "au FileType java  set foldmethod=indent 
    
    autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
    autocmd BufRead *.py set nocindent
    autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
    au FileType py set tabstop=4 
    au FileType py set shiftwidth=4, 
    au FileType py set smarttab 
    au FileType py set expandtab 
    au FileType py set softtabstop=4 
    au FileType py set autoindent   
    au FileType py set foldmethod=indent    
    "au BufRead mutt*[0-9] set tw=72
    
    " Automatically chmod +x Shell and Perl scripts and python 
    au BufWritePost   *.sh             !chmod +x %
    au BufWritePost   *.pl             !chmod +x %
    "au BufWritePost  *.py   !chmod +x %

    " File formats
    au BufNewFile,BufRead  *.pls    set syntax=dosini
    au BufNewFile,BufRead  modprobe.conf    set syntax=modconf
endif
"for .nc files
augroup filetypedetect
  au! BufRead,BufNewFile *nc setfiletype nc
augroup END

" let g:pymode_rope_lookup_project = 0

filetype indent on

au FileType java setlocal tabstop=2
" Keyboard mappings
"turn off highlighted search
map <silent> <C-N> :silent noh<CR> 

map <F6> <Esc>:setlocal spell spelllang=en_gb<CR>
map <F7> <Esc>:setlocal nospell<CR> 
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

" move splits when using mac
nmap ˙ <C-w><Left>
nmap ¬ <C-w><Right>
nmap ˚ <C-w><Up>
nmap ∆ <C-w><Down> 

" ctags.vim setting - to show function name in status bar
let g:ctags_path = '/usr/bin/ctags'
let g:ctags_statusline = 1
let generate_ctags = 1
let g:ctags_regenerate = 0 " disable regeneration
nmap <F2> :CTAGS<CR>
nmap ,t :!(cd %:p:h;ctags *.[cCh])&

set backspace=indent,eol,start 

" nerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif 
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif 
map <C-n> :NERDTreeToggle<CR>

" tagbar
let g:tabgar_ctags_bin = '/grid/common/pkgs/ctags/v5.8/bin' 
nmap <F9> :TagbarToggle<CR>

"""""""""""""""""""" YouCompleteMe """"""""""""""""""""""""""""""""
nnoremap <leader>j :YcmCompleter GoTo<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:Show_diagnostics_ui = 1 "default 1
"will put icons in Vim's gutter on lines that have a diagnostic set.
""Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
"let g:ycm_enable_diagnostic_highlighting = 0
"let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  "where to search for .ycm_extra_conf.py if not found
let g:ycm_confirm_extra_conf = 0 
let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_disable_for_files_larger_than_kb = 0 "default 1000
map <F9> :YcmCompleter FixIt<CR>
"let g:ycm_filetype_whitelist = { '*': 1 }
"let g:ycm_key_invoke_completion = '<C-Space>'
"let g:ycm_use_clangd = "Always"
"let g:ycm_clangd_binary_path = "/grid/common/test/llvm-v7.0.1rh65/bin/clangd"
"let g:ycm_max_diagnostics_to_display = 0
"let g:ycm_always_populate_location_list = 1
""""""""""""""""""""""""""""""""""""""""""""""""""

set clipboard=unnamedplus
set nowrap

"prevent closing last window 
"cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()<=2 ? 'close' : 'q')<CR>
"cabbrev wq <c-r>=(getcmdtype()==':' && getcmdpos()<=2 ? 'write' : 'wq')<CR>

"Perforce
let p4UseVimDiff2 = 1
let g:p4Depot = 'hsv'
let &makeprg = "gmake SYSTRG=64bit install"

"scratch window
let g:scratch_show_command = 'topleft 10split | hide buffer'

"buffers
nnoremap <F5> :buffers<CR>:buffer<Space>

"FastFold
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes = ['x', 'X', 'a', 'A', 'o', 'O', 'c', 'C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

"Cursor line
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
