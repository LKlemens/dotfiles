syntax on                 " syntax coloring
colorscheme apprentice
set background=dark
"''''''''''''''''''
" SETS
" '''''''''''''''''
set autoindent
set dictionary=dict
set showmatch
set matchtime=10
set relativenumber
set nu
set hidden
set statusline=[%n]\ %<%F\ \ \ [%M%R%H%W%Y][%{&ff}]\ \ %=\ line:%l/%L\ col:%c\ \ \ %p%%\ \ \ @%{strftime(\"%H:%M:%S\")}
set clipboard+=unnamedplus
set ignorecase
set vb
set undolevels=1000
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:▸
"set list to schow spaces
"set lbr
set autoread
set spelllang=en_us
set cursorline
set expandtab               " replace tabs with spaces
set tabstop=2               " how many columns a tab counts for
set shiftwidth=2           " control how many columns text is indented with
set colorcolumn=120
set history=700              " keep 50 lines of command line history
set hlsearch                " highlight searched text
set incsearch               " do incremental searching
set laststatus=2            " always show status line
set ruler                   " show the cursor position all the time
set showcmd                 " display incomplete commands
set ruler
set smartindent              " automatically inserts one extra level of
" set guifont=Hack-BoldItalic\ for\ Powerline

set so=5                    " scrolls the text so that there are always at
set tags=/var/fpwork/lukaszcz/ftk4/tags
set noswapfile
set sessionoptions-=options
set backspace=indent,eol,start
set tags=/var/fpwork/lukaszcz/ftk4/tags
set noswapfile
set wildmenu

if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif

" " highlight column
highlight ColorColumn ctermbg=darkgray
au CursorHold * checktime
let mapleader=','
function! EnhanceCppSyntax()
  syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
  hi def link cppFuncDef Special
endfunction
autocmd Syntax cpp call EnhanceCppSyntax()

" " highlight ExtraWhitespace at end of line, remove them at save buffer
" ######################
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction`

autocmd BufWritePre     *.cpp :call TrimWhiteSpace()
autocmd BufWritePre     *.hpp :call TrimWhiteSpace()
autocmd BufWritePre     *.ttcn3 :call TrimWhiteSpace()
" ###########################################################################################

filetype plugin indent on   " automatically finds and load specific plugin
"     or indent file for known files
"
" tab hint
"set wildchar=<TAB> wildmenu wildmode=full
set wildcharm=<C-Z>
"  nnoremap <TAB> :b <C-Z>
"
" "#################################
" KLAWISZOLOGIA
" ######################################
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map      <F4> :call Switch_HPP_CPP()<CR>
" calling function for switching cpp-hpp

map     <S-Insert>      <MiddleMouse>
map!    <S-Insert>      <MiddleMouse>
noremap <leader>ws :w !sudo tee %
"Unite
noremap <leader>f <esc>:Unite buffer file_mru  <CR>
noremap <leader>t <esc>:Unite gtags/context<CR>
noremap <leader>d <esc>:Unite gtags/def
noremap <leader>r <esc>:Unite gtags/ref
"map     q :q<CR>
nnoremap <F2> :ta#<CR>
nnoremap <F3> :tabe#<CR>
inoremap <F5> <C-R>=strftime("%d/%m/%Y")<CR>
"keys
imap jj <Esc>
imap qq <Esc>:q<CR>
imap qw <Esc>:qw<CR>
map qq <Esc>:q<CR>
map qw <Esc>:qw<CR>
map vv <Esc>:tabe $MYVIMRC<CR>
nnoremap <space> i<space><esc>
"Plugins
nnoremap <F7> :GundoToggle<CR>
nnoremap <C-y> :Unite history/yank<CR>
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>v :Vex<CR>
map <leader><space> :vs .<CR>
nmap <silent> <leader>s :set spell!<CR>
map <leader>w :w<cr>
map <leader>h :sh<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
map <leader>tt :tabe <CR>
map <leader>l  :/^\n\{3}<CR>
map <leader>a= :Tabularize /=<CR>
map <leader>a. :Tabularize /\.<CR>
map <leader>a, :Tabularize /\,<CR>
map <leader>a9 :Tabularize /(<CR>
map <leader>at :!column -t<CR>
vmap <leader>em :call ExtractMethod()<CR>
nnoremap Q @q
map <Right> :tabn<CR>
map <Left> :tabp<CR>
map <up> :bn<CR>
map <Down> :bp<CR>

filetype off                  " required
" set the runtime path to include Vundle and initialize
call plug#begin()
" All of your Plugins must be added before the following line
Plug 'rentalcustard/exuberant-ctags'
Plug 'scrooloose/nerdcommenter'
Plug 'luochen1990/rainbow'
Plug 'sjl/gundo.vim'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/neomru.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'flazz/vim-colorschemes'
Plug 'wincent/command-t'
Plug 'Shougo/unite.vim'
Plug 'kien/ctrlp.vim'
Plug 'hewes/unite-gtags'
Plug 'Shougo/neoyank.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-fugitive'
call plug#end()            " required
filetype plugin indent on    " required

"let &path.="src/include,/usr/include/AL,/var/fpwork/lukaszcz/trunk/C_Test/**,/var/fpwork/lukaszcz/trunk/C_Application/C_Application/SC_MAC_PS_WMP/**,/var/fpwork/lukaszcz/trunk/lteDo/**,,"
set makeprg=make\ -C\ ../build\ -j9

let &path.="/usr/bin/xclip"
" set runtimepath+=/.vim/bundle/vim-snippets/snippets/cpp.snippets
let g:lightline                  = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.tabline          = {}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

let g:netrw_liststyle = 3
let g:rainbow_active = 1

" set rtp+=/home/reed/.local/lib/python3.6/site-packages/powerline/bindings/vim
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'
let g:gundo_close_on_revert = 1
let g:ctrlp_max_files=0
let g:ctrlp_match_window = 'results:100'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set statusline+=%#warningmsg#
set statusline+=%*


let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
  endif

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

filetype indent on

let g:unite_source_gtags_project_config = { '_':                   { 'treelize': 1 } }

let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" extract method
function! ExtractMethod() range
  let name = inputdialog("Name of new method:")
  '<
  exe "normal! O\<BS>void " . name ."()\<CR>{\<Esc>"
  '>
  exe "normal! oreturn ;\<CR>}\<Esc>k"
  s/return/\/\/ return/ge
  normal! j%
  normal! kf(
  exe "normal! yyPi// = \<Esc>wdwA;\<Esc>"
  normal! ==
  normal! j0w
endfunction




let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['bufferline'] ],
      \   'right': [['percent', 'lineinfo']]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v',
      \   'bufferline': '%{bufferline#refresh_status()} %{g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after}'
      \},
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

  function! LightlineReadonly()
    return &readonly ? '' : ''
  endfunction
  function! LightlineFugitive()
    if exists('*fugitive#head')
      let branch = fugitive#head()
      return branch !=# '' ? ''.branch : ''
    endif
    return ''
  endfunction
