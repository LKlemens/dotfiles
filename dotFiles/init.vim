syntax on                 " syntax coloring
colorscheme apprentice
set background=dark
"''''''''''''''''''
" SETS
" '''''''''''''''''

"boost your vim
set timeoutlen=1000
set lazyredraw
set ttyfast

set ttimeoutlen=0
set autoindent
set dictionary=dict
set showmatch
set matchtime=10
set relativenumber
set nu
set hidden
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
set noswapfile
set sessionoptions-=options
set backspace=indent,eol,start
set tags=/tagsC/tags
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

autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"delete whitespaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction`

autocmd BufWritePre     *.c :call TrimWhiteSpace()
autocmd BufWritePre     *.h :call TrimWhiteSpace()
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
map     <S-Insert>      <MiddleMouse>
map!    <S-Insert>      <MiddleMouse>
noremap <leader>ws :w !sudo tee %
"Unite
noremap <leader>f <esc>:Unite buffer file_mru  <CR>
noremap <leader>t <esc>:Unite gtags/context<CR>
noremap <leader>d <esc>:Unite gtags/def
noremap <leader>r <esc>:Unite gtags/ref
nnoremap <F2> :ta#<CR>
nnoremap <F3> :tabe#<CR>
inoremap <F5> <C-R>=strftime("%d/%m/%Y")<CR>
"keys
imap jk <Esc>
imap qq <Esc>:q<CR>
map qq <Esc>:q<CR>
map vv <Esc>:tabe $MYVIMRC<CR>
nnoremap <space> i<space><esc>
" nnoremap <silent><Leader>R :%s/<c-r><c-w>//gI<c-f>$F/i
nnoremap <silent><Leader>R :%s/\<<c-r><c-w>\>//gI<c-f>$F/i
"Plugins
"
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
map <C-p> :Files ~<CR>
map <leader>tl :Tlist<CR>
map <leader>hh :A<cr>
map <silent> <leader><cr> :noh<cr>
map <leader>tm :tabmove
map <leader>to :tabonly<cr>
map 0 ^
nnoremap ,; :call ToggleEndChar(';')<CR>


vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"DEOPLETE CONFIGURATION
let g:deoplete#enable_at_startup = 1

"DEOPLETE CLANG OPTIONS
let g:deoplete#sources#clang#libclang_path="/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header="/usr/include/c++/6.3.1"

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
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'flazz/vim-colorschemes'
Plug 'wincent/command-t'
Plug 'Shougo/unite.vim'
Plug 'hewes/unite-gtags'
Plug 'Shougo/neoyank.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'w0rp/ale'
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-fugitive'
Plug 'zchee/deoplete-clang'
Plug  'Shougo/neoinclude.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'vim-scripts/Conque-GDB'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()            " required
filetype plugin indent on    " required

"let &path.="src/include,/usr/include/AL,/var/fpwork/lukaszcz/trunk/C_Test/**,/var/fpwork/lukaszcz/trunk/C_Application/C_Application/SC_MAC_PS_WMP/**,/var/fpwork/lukaszcz/trunk/lteDo/**,,"
set makeprg=make\ -C\ ../build\ -j9
let &path.="/usr/bin/xclip,/usr/include/c++/6.3.1"
" set runtimepath+=/.vim/bundle/vim-snippets/snippets/cpp.snippets

"C-h woks now !
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

let g:netrw_liststyle = 3
let g:rainbow_active = 1


let g:tmux_navigator_save_on_switch = 2 "tmux save on switch
" set rtp+=/home/reed/.local/lib/python3.6/site-packages/powerline/bindings/vim
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'

let g:gundo_close_on_revert = 1

set statusline+=%#warningmsg#
set statusline+=%*


let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

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
"add semicilon on end of line
function! ToggleEndChar(charToMatch)
    s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
endfunction
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

let g:fzf_history_dir = '~/.local/share/fzf-history'


"lightline config
let g:lightline                  = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.tabline          = {}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let g:lightline = {
      \ 'active': {
      \   'left': [ [  'mode', 'paste' ], [ 'fugitive', 'filename' ]],
      \   'right': [['percent', 'lineinfo'],]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v' 
      \},
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'tabline': {
      \ 'left': [ [ 'tabs' ] ]
      \},
      \ 'mode_map':{
      \ 'n' :     '  NORMAL',
      \ 'i' :     '  INSERT',
      \ 'R' :     ' REPLACE',
      \ 'v' :     ' VISUAL',
      \ 'V' :     ' V-LINE',
      \ "\<C-v>": ' V-BLOCK',
      \ 'c' :     ' COMMAND',
      \ 's' :     ' SELECT',
      \ 'S' :     ' S-LINE',
      \ "\<C-s>": ' S-BLOCK',
      \ 't': ' TERMINAL',
      \},
      \ }
" \   'bufferline': '%{bufferline#refresh_status()} %{g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after}'
function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return ""
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

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
