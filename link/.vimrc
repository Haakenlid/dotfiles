"keyboard shortcuts
let mapleader=" "
syntax on
filetype plugin indent on

" Fix ctrp highlight
let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit':  'BrightHighlightOff', }
let python_highlight_all = 1

fun! BrightHighlightOn()
  hi CursorLine ctermfg=15 cterm=bold
endfun

fun! BrightHighlightOff()
  hi CursorLine ctermfg=none cterm=none
endfun


if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal
endif


autocmd BufWritePost * Neomake
autocmd BufWritePost *.elm ElmMake

map <leader>h :ElmErrorDetail<CR>


let g:vdebug_options = {
      \ 'port': 9000,
      \ 'server': '',
      \ 'ide_key': '',
      \ 'debug_file': '/home/haakenlid/vdebug.log',
      \ 'debug_file_level': 2,
      \ }

let g:neomake_python_mypy_maker = {
      \ 'exe': 'mypy',
      \ 'args': ['--ignore-missing-imports'],
      \ 'errorformat': '%f:%l:%m'
      \ }
let g:neomake_python_enabled_makers = ['flake8', 'mypy']
" let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_sh_enabled_makers = []
let g:neomake_open_list = 2 " open location list
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
nmap zn :GitGutterNextHunk<CR>
nmap zp :GitGutterPrevHunk<CR>
let g:elm_format_autosave = 0
let g:elm_setup_keybindings = 0
nmap <leader>h :ElmErrorDetail<CR>
autocmd FileType elm noremap <silent> <buffer> <F8> :ElmFormat<CR>
autocmd FileType python noremap <silent> <buffer> <F8> :lcl <bar> call Autopep8()<CR>

map <C-tab> <silent>:bnext<CR>

" let g:ycm_semantic_triggers = { 'elm' : ['.'] }

" Don't use swap file.
set nobackup
set nowritebackup
set noswapfile

" Printing
set printoptions+=formfeed:y
set printoptions+=header:0
" Splain syntax highlight
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
      \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
      \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)), "name")
      \ . ">"<CR>

" Python
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
autocmd FileType python BracelessEnable +indent +highlight

" let g:lt_height = 5
autocmd FileType qf nmap <buffer> <CR> <CR>:lcl<CR>
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.{tpl,tmpl} set filetype=jinja
set modeline
set modelines=5

" Dynamic quickfix height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$") + 1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" let g:airline_section_x = 'pencil: %{PencilMode()}'
" augroup pencil
"   autocmd!
"   autocmd FileType markdown,mkd,text
"         \ | call pencil#init()
"         \ | call lexical#init()
" augroup END

map! jj <esc>
" imap DD <esc>dd
" imap AA <esc>A
" imap II <esc>I
" imap OO <esc>O
" imap CC <esc>C

imap <c-CR> <esc>o
imap <c-u> <esc>ui
map Q @q
" Ctrl-Q = quit
map <C-Q> :qa!
map! <C-Q> <esc>:qa!
" Ctrl-S = save
"

fun! <SID>Writefile()
  call <SID>StripTrailingWhitespaces()
  w!
endfun

map <silent> <C-S> :call <SID>Writefile()<CR>
imap <silent> <C-S> <esc>:call <SID>Writefile()<CR>
" clear search pattern
map <silent> <leader>/ :let @/=""<CR>

" random color scheme
map <leader>R :colorscheme random<CR>

" save and close buffer
nmap <silent> <leader>x :x<CR>


" Replace word under cursor
nmap <leader>r *N:redraw!<CR>:%s/\<<C-r>=expand('<cword>')<CR>\>//g<left><left>

" leader p => previous buffer
map <leader>p :bp<CR>

" open vimrc with leader V
map <leader>v :call SwitchToWriteableBufferAndExec('e $MYVIMRC')<CR>
autocmd BufRead $MYVIMRC :map <buffer> <leader>v :bp<CR>:so $MYVIMRC<CR>

" javascript linting with prettier
autocmd BufWritePre *.js Neoformat


autocmd FileType javascript,javascript.jsx set formatprg=prettier\ --stdin
      \\ --semi\ false\ --single-quote\ --trailing-comma\ es5
let g:neoformat_try_formatprg = 1




" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1

" Tagbar settings
map <leader>T :TagbarOpenAutoClose<CR>
set tags=tags;,.git/tags;

"sane defaults
colorscheme hken
let previewheight=5

"neovim python programs
" let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

set hidden
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
" set rnu
set nu
set listchars=tab:>-,extends:>,precedes:<
set list
set mouse=a
set backspace=indent,eol,start
set cursorline
set laststatus=2 " Always display the statusline in all windows
" set showtabline=2 " Always display the tabline, even if there is only one tab
" set showtabline=1
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" Splits
set splitbelow " New split goes below
set splitright " New split goes right

" Show absolute numbers in insert mode, otherwise relative line numbers.
" autocmd vimrc InsertEnter * :set norelativenumber
" autocmd vimrc InsertLeave * :set relativenumber

" Make it obvious where 80 characters is
" set textwidth=80
set colorcolumn=-1

set dictionary="/usr/dict/words"

function! <SID>StripTrailingWhitespaces()
    " save search pattern
    let search = @/
    " save cursor position
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    " reset cursor position and search
    let @/ = search
    call cursor(l, c)
endfun

autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

nmap <leader>S :call <SID>StripTrailingWhitespaces()<CR>

if ! has('gui_running')
    " this makes insert mode commands such as jj possible
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=300
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" YouCompleteMe settings
nmap <leader>gd :YcmCompleter GoTo<CR>
nmap <leader>gu :YcmCompleter GoToReferences<CR>
nmap <leader>gr :YcmCompleter RefactorRename<space><C-r>=expand('<cword>')<CR>

nmap gi /import<CR>:let @/ = ""<CR>

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_python_binary_path = "python3"
let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_min_num_identifier_candidate_chars = 2


let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'rst' : 1,
      \ 'unite' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}

" Easymotion settings
let g:EasyMotion_do_mapping = 1 " Disable default mappings
map <Leader> <Plug>(easymotion-prefix)

" Bi-directional find motions
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <leader>s <Plug>(easymotion-s)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

"
" " These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" RIV settings
let g:riv_fold_auto_update = 0

" NERDTree settings
let NERDTreeShowHidden = 1
map <silent> <leader>n :NERDTreeFind<CR>
autocmd FileType nerdtree,'' noremap <buffer> <silent> <leader>n :NERDTreeToggle<CR>
autocmd FileType nerdtree silent! unmap <buffer> <c-j>
autocmd FileType nerdtree silent! unmap <buffer> <c-k>

autocmd StdinReadPre * let s:std_in=1
let NERDTreeIgnore=['.git$', '.pyc$', '__pyc__', '__pycache__']

" Inactive splits background color hack
" Dim inactive windows using 'colorcolumn' setting
" This tends to slow down redrawing, but is very useful.
" Based on https://groups.google.com/d/msg/vim_use/IJU-Vk-QLJE/xz4hjPjCRBUJ
" XXX: this will only work with lines containing text (i.e. not '~')
function! s:DimInactiveWindows()
  for i in range(1, tabpagewinnr(tabpagenr(), '$'))
    let l:range = ""
    if i != winnr()
      if &wrap
        " HACK: when wrapping lines is enabled, we use the maximum number
        " of columns getting highlighted. This might get calculated by
        " looking for the longest visible line and using a multiple of
        " winwidth().
        let l:width=256 " max
      else
        let l:width=winwidth(i)
      endif
      let l:range = join(range(1, l:width), ',')
    endif
    call setwinvar(i, '&colorcolumn', l:range)
  endfor
endfunction

" JSX settings
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*

" CtrlP
" Use this function to prevent CtrlP opening files inside non-writeable
" buffers, e.g. NERDTree
function! SwitchToWriteableBufferAndExec(command)
    let c = 0
    let wincount = winnr('$')
    " Don't open it here if current buffer is not writable (e.g. NERDTree)
    while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
        exec 'wincmd w'
        let c = c + 1
    endwhile
    exec a:command
endfunction

" CTRL-P settings
nnoremap <C-p> :call SwitchToWriteableBufferAndExec('CtrlPLastMode')<CR>
nnoremap gb :call SwitchToWriteableBufferAndExec('CtrlPBuffer')<CR>
nnoremap <leader>t :call SwitchToWriteableBufferAndExec('CtrlPTag')<CR>
nnoremap gm :call SwitchToWriteableBufferAndExec('CtrlPMRUFiles')<CR>

" Disable default mapping since we are overriding it with our command
let g:ctrlp_map = ''

" let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=20
" let g:ctrlp_reuse_window='nerdtree'
let g:ctrlp_lazy_update=1
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_extensions = ['tag']
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -lS --ignore=".git" --hidden --nocolor -g ""'
endif

""" Emmet config
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_next_key='<M-j>'
let g:user_emmet_prev_key='<M-k>'

""" Ultisnips config
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsJumpForwardTrigger="<C-j>"
" let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsListSnippets="<M-s>"
let g:UltiSnipsExpandTrigger="<M-e>"
let g:UltiSnipsUsePythonVersion=3

" let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"

" let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" let g:UltiSnipsSnippetDirectories=[]

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
"
" https://github.com/junegunn/vim-plug
" Reload .vimrc and :PlugInstall to install plugins.

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --tern-complete
  endif
endfunction


call plug#begin('~/.vim/plugged')
Plug 'sbdchd/neoformat'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'guns/xterm-color-table.vim'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mickaobrien/vim-stackoverflow'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'reedes/vim-lexical'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'SirVer/ultisnips'
Plug 'tell-k/vim-autopep8'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-sensible'
Plug 'tweekmonster/braceless.vim'
Plug 'Valloric/ListToggle'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elmcast/elm-vim'
" Plug 'joonty/vdebug'
" Plug 'hynek/vim-python-pep8-indent'
" Plug 'davidhalter/jedi-vim'
" Plug 'honza/vim-snippets'
" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-unimpaired'
" Plug 'tpope/vim-vinegar'
call plug#end()
