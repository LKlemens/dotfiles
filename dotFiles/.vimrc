set nocompatible
syntax on                 " syntax coloring
set background=dark

colorscheme apprentice
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
set term=screen-256color
set clipboard=unnamedplus
set ignorecase
set vb
set undolevels=1000
set listchars=eol:Â¬,tab:>Â·,trail:~,extends:>,precedes:<,space:â–¸
"set list to schow spaces
set wrap
set autoread
set spelllang=en_us
set cursorline
set expandtab               " replace tabs with spaces
set tabstop=2               " how many columns a tab counts for
set shiftwidth=2           " control how many columns text is indented with
set colorcolumn=120
set history=2000              " keep 50 lines of command line history
set title
set hlsearch                " highlight searched text
set incsearch               " do incremental searching
set laststatus=2            " always show status line
set ruler                   " show the cursor position all the time
set showcmd                 " display incomplete commands
set ruler
set smartindent              " automatically inserts one extra level of
set guifont=Monospace\ 8        " set GUI font
set so=5                    " scrolls the text so that there are always at
set nobackup
set sessionoptions-=options
set backspace=indent,eol,start
set tags+=/var/fpwork/$USER/universalTags/tags
set noswapfile
set wildmenu
set wildmode=longest,list,full
set splitright "" Open new split panes to right
set smarttab
set ai "auto indent"
set si "smart indent"
set viminfo^=%

if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif


" " highlight column
highlight ColorColumn ctermbg=darkgray
au CursorHold * checktime
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

"remember the line I was on when I reopen a file
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \ exe "normal! g`\"" |
     \ endif

"delete  redundant whitespaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction`

" autocmd BufWritePre     *.cpp :call TrimWhiteSpace()
" autocmd BufWritePre     *.hpp :call TrimWhiteSpace()
autocmd BufWritePre     *.ttcn3 :call TrimWhiteSpace()
" autocmd BufWinEnter     *.log :set filetype=logreview

" ###########################################################################################

filetype plugin indent on   " automatically finds and load specific plugin
"     or indent file for known files
"


" "#################################
" MAPPINGS
" ######################################
"basic
"move through splits
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"map jk to esc
inoremap jk <Esc>

"quit file
map qq <Esc>:q<CR>

"open vimrc
map vv <Esc>:tabe $MYVIMRC<CR>

"spcace in normal mode
nnoremap <space> i<space><esc>

"change  to ,
let mapleader=','

"file manager from buffer dir
map <leader>v :Lexplore %:p:h<CR>
"from termianl dir
map <leader><space> :Lexplore<CR>
"open quickfix
map <leader>co :cope<CR>
"rename variable/fun etc in file
nnoremap <silent><Leader>R :%s/\<<c-r><c-w>\>//gI<c-f>$F/i


map <leader>w :w<cr>
map <leader>s :sh<CR>
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
map <leader>tt :tabe <CR>

"Highlight more than 2 empty lines
map <leader>l  :/^\n\{3}<CR>
" Stop the highlighting for the 'hlsearch' option
map <leader><cr> :noh<CR>
nnoremap Q @q

"plugins mapping
"Unite
noremap <leader>f <esc>:Unite -no-split buffer file_mru  <CR>
noremap <leader>t <esc>:Unite -no-split gtags/context<CR>
noremap <leader>d <esc>:Unite  gtags/def<cr>
noremap <leader>gr <esc>:Unite -no-split gtags/ref<CR>
nnoremap <leader>y :Unite history/yank<CR>
nnoremap <leader>uq : Unite -no-split qf<cr>
nnoremap <leader>ur :UniteResume<cr>
nnoremap <leader>uo :Unite -no-split outline<cr>
nnoremap <leader>gg :Unite -no-split grep:.::<c-r><c-w><cr>

nnoremap 0 ^
nnoremap ^ 0
vnoremap 0 ^
vnoremap ^ 0


"tags open in vertical split
" map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>


" ========================================================================================
" remap movement for wrapped lines being the same as for non-wrapped lines
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" ========================================================================================
" set middle of screen for new searches
nnoremap <silent>n nzz
nnoremap <silent>N Nzz
nnoremap <silent>g* g*zz

nmap <leader>W :call TrimWhiteSpace()<cr>
"move cursor one place left when insert mode
inoremap <c-l> <right>

"source vimrc
nmap <leader>so :so $MYVIMRC<cr>

"go to the begin of line
nnoremap H ^
"go to the end of line
nnoremap L $
nnoremap <Left> :cp<CR>
nnoremap <Right> :cn<CR>
"change dir to current buffer dir
nnoremap <leader>cd :cd %:p:h<CR>
"change dir with fzf
nnoremap <leader>gd :Cd /var/fpwork/$USER/trunk<CR>
"show all windows
nnoremap <leader>we :Window<cr>
"go through results ctags
nnoremap <Down> :ptprev<CR>
nnoremap <Up> :ptnext<CR>

"Svn diff, show changes in file
noremap <F4> :call Svndiff("next")<CR>
noremap <F5> :call Svndiff("clear")<CR>
"get date
inoremap <F6> <C-R>=strftime("%d/%m/%Y")<CR>

nnoremap <leader>gu  :GundoToggle<CR>
"correct indentation
map <leader>at :%!column -t<CR>
"copy from cursor to end line
noremap Y y$
"open hpp/cpp in split
map <leader>h :AV<cr>
"open files fzf
map <C-p> :Files<cr>
map <leader>pp :call CopyPath()<CR>
map <leader>ff :call CopyFileName()<CR>
map <leader>tl :Tlist<CR>
"grep fzf
map <leader>ag :Ag <c-r><c-w><cr>
nnoremap ,; :call ToggleEndChar(';')<CR>
"toggle wrap arguments in function
nnoremap <silent> <leader>ew :ArgWrap<CR>
" go to place of last change
nnoremap g; g;zz

"abbreviations
iabbr /** /************************************************************************
iabbr **/ ************************************************************************/
iabbr //- //-----------------------------------------------------------------------

" path to directory where library can be found
" let g:clang_library_path='/opt/clang/x86_64/2.8-1/lib'
filetype off                  " required
"Plug-vim
call plug#begin()
" All of your Plugins must be added before the following line
" Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'luochen1990/rainbow'
Plug 'sjl/gundo.vim' "version control in vim
Plug 'SirVer/ultisnips' "snippets
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/neoyank.vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/taglist.vim'
Plug 'sk1418/HowMuch'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'wikitopian/hardmode'
Plug 'jrosiek/vim-mark' "Highlight several words in different colors simultaneously
Plug 'bgrohman/vim-bg-sessions'
Plug 'junegunn/limelight.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'yuttie/comfortable-motion.vim' "smooth motion c-d c-b
Plug 'rhysd/clever-f.vim'
Plug 'unblevable/quick-scope' " Vim plugin that highlights which characters to target for f, F and family.

"colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'kristijanhusak/vim-hybrid-material' "colorscheme
Plug 'tyrannicaltoucan/vim-quantum' "colorscheme
Plug 'dikiaap/minimalist' "colorscheme
Plug 'morhetz/gruvbox' "colorscheme

Plug 'nathanaelkane/vim-indent-guides'
Plug 'flyovergu/cu.vim' " convert between camelCase and underscoreCase.
Plug 'vim-scripts/svn_line_history.vim'
Plug 'sickill/vim-pasta' " correct indent when pasting
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'

"textobj
Plug 'kana/vim-textobj-function'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'

Plug 'tpope/vim-repeat' " make dot better
Plug 'wellle/targets.vim' " It expands on the idea of simple commands like di'
Plug 'FooSoft/vim-argwrap'
Plug 'Yggdroot/indentLine' "This plugin is used for displaying thin vertical lines at each indentation level for code indented with spaces
Plug 'zhaocai/GoldenView.Vim' "Always have a nice view for vim split windows
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'andreshazard/vim-logreview'
Plug 'Shougo/neocomplete.vim'

"unite
Plug 'Shougo/neomru.vim' "mru plugin for unite
Plug 'Shougo/unite.vim'
Plug 'hewes/unite-gtags'
Plug 'Shougo/unite-outline'
Plug 'sgur/unite-qf' " unite quickfix
Plug 'ervandew/supertab'
" Plug 'maralla/completor.vim'
" NeoBundle 'movitto/vim-vsearch'    "moze sie przydac
call plug#end()            " required

let &path.="src/include,/usr/include/AL,/usr/include/c++/4.4.7,/home/$USER/gnuglobal/6.5.2/bin,/var/fpwork/$USER/trunk/C_Test/**,/var/fpwork/$USER/trunk/C_Application/**,/var/fpwork/$USER/trunk/lteDo/I_Interface/Application_Env/**,/var/fpwork/$USER/trunk/lteDo/I_Interface/Private/**,,"
set makeprg=make\ -C\ ../build\ -j9

"Easy motion
"maping easy search and easy motion
nmap s <Plug>(easymotion-overwin-f2)
map  z/ <Plug>(easymotion-sn)
let g:EasyMotion_smartcase = 1

let Tlist_WinWidth = 50

"UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

"netrw
let g:netrw_sort_by='time'
let g:netrw_sort_direction='reverse'
let g:netrw_liststyle = 3

"completor
" let g:completor_clang_binary = '/opt/clang/x86_64/2.8-1/lib'
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

let g:rainbow_active = 1

"golden view
let g:goldenview__enable_default_mapping = 0

"hardmode
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

"bookmarks
let g:bookmark_sign = '>>'
let g:bookmark_annotation_sign = '##'
let g:bookmark_auto_save_file = '/tmp/my_bookmarks'
let g:bookmark_highlight_lines = 1

"indent
let g:indentLine_color_term = 239
let g:mwDefaultHighlightingPalette = 'maximum'
let g:mwDefaultHighlightingNum = 25

"Unite
let g:neoyank#limit=500


autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)

  nmap <silent><buffer><expr> Enter unite#do_action('switch')
  nmap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
  nmap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
  nmap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

  imap <silent><buffer><expr> Enter unite#do_action('switch')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
  imap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

  map <buffer> <C-p> <Plug>(unite_toggle_auto_preview)

  nnoremap <ESC> :UniteClose<cr>
endfunction

call unite#custom#profile('default', 'context', {
\   'direction': 'topleft',
\   'vertical_preview': 1,
\   'winheight': 45
\ })

let g:unite_source_grep_command='ag'
let g:unite_source_grep_recursive_opt=''
let g:unite_source_grep_default_opts =
  \ '-i --smart-case --nogroup --nocolor --ignore-dir={.git, .cabal-sandbox, .stack-work}'
" end unite

nnoremap + @@
" Neocomplete
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" switch buffers fast
nnoremap <S-Left>  :bp<cr>
nnoremap <S-Right> :bp<cr>

"" Create window splits easier.
" nnoremap <silent> -- <C-w>v

" saves effort of going to beginning of word
nnoremap yw yiw
nnoremap cw ciw
nnoremap dw diw
"gundo
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_close_on_revert = 1

"colorscheme
let g:cpp_concepts_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

"Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L


if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif


"svndiff
let g:svndiff_autoupdate = 1
let g:svndiff_one_sign_delete = 1

filetype indent on

"nerd comments
" let g:NERDDefaultAlign = 'left'
" let g:NERDSpaceDelims = 1
" let g:NERDCompactSexyComs = 1

"tabularize
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a, :Tabularize /,<CR>
  nmap <Leader>a, :Tabularize /,<CR>
endif

"auto source vimrc
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

"add semicolon on the end
function! ToggleEndChar(charToMatch)
    s/\v(.)$/\=submatch(1)==a:charToMatch ? '' : submatch(1).a:charToMatch
endfunction

"lightline
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'filename' ], [ 'bufferline' ] ],
  \  }
  \ }

function! CopyFileName()
  let @+=expand('%:t')
endfunction

function! CopyPath()
  let @+=expand('%:p')
endfunction

" stop arrow keys from typing A B C D
map OA <up>
map OB <Down>
map OD <left>
map OC <right>


"bold functions scheme
" let g:enable_bold_font = 1

"arwrap
let g:argwrap_line_prefix = ''



"FZF
" let g:fzf_files_options =
"    \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
" Files with preview
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('right'), <bang>0)

"ag with preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:wrap', '?'),
  \                 <bang>0)

let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~100%' }

" change dir through fzf
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'cd'}))

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"end fzf

" Set vim to save the file on focus out.
au FocusLost * :wa
"==========================================================================="
" Redraw screen every time when focus gained
au FocusGained * :redraw!"==========================================================================="


function! CorrectCppMacrosInCtagFile()
  normal! gg
  while search('^SUBSEQUENCE	\|SUBDATA	\/var\/fpwork', "W")
    if getline('.') !~ 'define'
      normal! 0diWf(wyi(0PF,dwi_
    endif
  endwhile
  normal! gg
  set noignorecase
  while search('^TC_VARIATION	\|^SEQUENCE	\/var\/fpwork\|^INHERIT_TESTCASE	\|^CA_TESTCASE	\|^INHERIT_CHECK	
            \\|^INHERIT_SEQUENCE	\|^TESTCASE	\|^MESSAGES	\/var\/fpwork\|^MESSAGE	\/var\/fpwork\|^AAEU_PROCESS	
            \\|^CHECK	\|^TC_MAIN	\|^CHANNEL	\|^THREAD	\/var\/fpwork\|::SEQUENCE	\/var\/fpwork
            \\|::MESSAGE	\/var\/fpwork\|::MESSAGES	\/var\/fpwork\|::THREAD	\/var\/fpwork', "W")
    if getline('.') !~ 'define'
      normal! 0diWf(wye0P
    endif
  endwhile
  normal! gg
  while search('^SendMsg	\|^RecvMsg	', "W")
    normal! 0diwf^wwye0P
  endwhile
  normal! gg
  while search('^TEST	\|^TEST_F	\|^TEST_P	', "W")
    if getline('.') !~ '#define\|# define'
      normal! 0diwf(wwwye0P
    endif
  endwhile
  set ignorecase
endfunction

" function! ExpandCMacro()
"   "get current info
"   let l:macro_file_name = "__macroexpand__" . tabpagenr()
"   let l:file_row = line(".")
"   let l:file_name = expand("%")
"   let l:file_window = winnr()
"   "create mark
"   execute "normal! Oint " . l:macro_file_name . ";"
"   execute "w"
"   "open tiny window ... check if we have already an open buffer for macro
"   if bufwinnr( l:macro_file_name ) != -1
"     execute bufwinnr( l:macro_file_name) . "wincmd w"
"     setlocal modifiable
"     execute "normal! ggdG"
"   else
"     execute "bot 10split " . l:macro_file_name
"     execute "setlocal filetype=cpp"
"     execute "setlocal buftype=nofile"
"     nnoremap <buffer> q :q!<CR>
"   endif
"   "read file with gcc
"   silent! execute "r!gcc -E " . l:file_name
"   "keep specific macro line
"   execute "normal! ggV/int " . l:macro_file_name . ";$\<CR>d"
"   execute "normal! jdG"
"   "indent
"   execute "%!indent -st -kr"
"   execute "normal! gg=G"
"   "resize window
"   execute "normal! G"
"   let l:macro_end_row = line(".")
"   execute "resize " . l:macro_end_row
"   execute "normal! gg"
"   "no modifiable
"   setlocal nomodifiable
"   "return to origin place
"   execute l:file_window . "wincmd w"
"   execute l:file_row
"   execute "normal!u"
"   execute "w"
  "highlight origin line
"   let @/ = getline('.')
" endfunction

set viminfo+=!  " Save and restore global variables.
