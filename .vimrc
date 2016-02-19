set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdcommenter'
Plugin 'aperezdc/vim-template'
Plugin 'steffanc/cscopemaps.vim'
Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" YouCompleteMe Options
let g:ycm_autoclose_preview_window_after_completion=1
let g:ymc_global_ymc_extra_conf = '/home/nick/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:syntastic_c_checkers=['make']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*gbar

" vim-airline
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Plugin DoxygenToolkit
let g:DoxygenToolkit_briefTag_pre=""
let g:DoxygenToolkit_paramTag_pre="@param[] "
let g:DoxygenToolkit_returnTag="@returns   "


" enable mouse usage in _a_ll modes
set mouse=a

" change autocomplete
set wildmode=longest,list,full
set wildmenu

" syntax highlighting
syntax enable

" highlitght the delimiter which matches the one under the cursor
set showmatch

" highlight search results
set hlsearch

" auto indentation
set autoindent
filetype indent plugin on

" use the colorscheme adapted to dark backgrounds
set background=dark
set t_Co=256
if &diff
   colorscheme monokai
else
   colorscheme jellybeans
endif


" If doing a diff. Upon writing changes to file, automatically update the
" differences
"autocmd BufWritePost * if &diff == 1 | diffupdate | endif

set tabstop=3
set softtabstop=3
set shiftwidth=3
" expand the tab character into spaces
set expandtab

" Fix the backspace key
"set bs=2

" display line numbers
set number

"set cursorline
"set cursorcolumn
"highlight CursorLine term=underline cterm=underline

" handy status line
" set statusline=%f%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=%03.3b]\ [Line=%04l/%04.8L]\ [Col=%04v]\ [%p%%]
" set statusline+=%{fugitive#statusline()} 
" set laststatus=2

"set showtabline=2

" Incremental search
set incsearch
" Ignore case
set ignorecase
set smartcase

" Indentation options
set cino+=(0

set viminfo='10,\"100,:20,%,n~/.viminfo

" Map auto completion
imap <C-Space> <C-X><C-O>

" CSCOPE Autoload module 
function! LoadCscope()
   let db = findfile("cscope.out", ".;")
   if (!empty(db))
      let path = strpart(db, 0, match(db, "/cscope.out$"))
      set nocscopeverbose " suppress 'duplicate connection' error
      exe "cs add " . db . " " . path
      set cscopeverbose
   endif
endfunction
au BufEnter /* call LoadCscope()

" vimdiff to ignore all whitespaces
set diffopt+=iwhite
set diffexpr=DiffW()
function DiffW()
   let opt = ""
   if &diffopt =~ "icase"
      let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
      let opt = opt . "-w " " vim uses -b by default
   endif
   silent execute "!diff -a --binary " . opt .
            \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction

