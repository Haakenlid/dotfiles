call plug#begin('~/.vim/plugged')
source ~/.vim/vimrc/basic_options.vim
source ~/.vim/vimrc/plugin_options.vim
source ~/.vim/vimrc/vim_functions.vim
source ~/.vim/vimrc/keyboard_shortcuts.vim
source ~/.vim/vimrc/language_server.vim
source ~/.vim/vimrc/deoplete.vim

" source ~/.vim/vimrc/youcompleteme.vim
" source ~/.vim/vimrc/ale_linter.vim

" Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-vinegar'

" Plug 'plytophogy/vim-virtualenv'
Plug 'junegunn/vim-peekaboo'
Plug 'SirVer/ultisnips'
Plug 'Valloric/ListToggle'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'elmcast/elm-vim'
Plug 'guns/xterm-color-table.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'reedes/vim-lexical'
Plug 'scrooloose/nerdtree'
Plug 'sjl/strftimedammit.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tweekmonster/braceless.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" reset autocommands
aug rcgroup
  au!
aug END

" vimrc stuff
command! Sourcevimrc so $MYVIMRC | echo 'sourced '.$MYVIMRC
" open vimrc with leader V
autocmd rcgroup BufRead $MYVIMRC :map <buffer> <leader>v :bp<CR>:so $MYVIMRC<CR>



" FZF keyboard shortcuts
nmap <silent> <leader><leader>b :Buffers<cr>
nmap <silent> <leader><leader>A :Ag!<cr>
nmap <silent> <leader><leader>a :Ag!<cr>
nmap <silent> <leader><leader>f :Files<cr>
nmap <silent> <leader><leader>h :Helptags<cr>
nmap <silent> <leader><leader>m :History<cr>
nmap <silent> <leader><leader>s :Snippets<cr>
nmap <silent> <leader><leader>t :Tags<cr>
nmap <silent> <leader><leader>l :Lines<cr>
nmap <silent> <leader><leader>g :GGrep<cr>
" inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'right': '15%'})
" inoremap <expr> <c-x><c-l> fzf#vim#complete#line()
" inoremap <expr> <c-x><c-l> fzf#vim#complete#line()
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

" Ag with preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Buffergator config
let g:buffergator_autoupdate=1
let g:buffergator_sort_regime='mru'
let g:buffergator_display_regime='basename'
let g:buffergator_suppress_keymaps=1
nnoremap <leader>b :BuffergatorToggle<cr>

" Autopairs config
let g:AutoPairsFlyMode = 0  " fly mode closes brackets
let g:AutoPairsMultilineClose = 0  " fly mode closes brackets
let g:AutoPairsShortcutFastWrap = '<M-w>'  " wrap following
autocmd rcgroup Filetype vim let b:AutoPairs = {'{':'}', '(':')', '<':'>', '''':''''}
" https://github.com/jiangmiao/auto-pairs/issues/187
" autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">

" Python
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79
autocmd rcgroup FileType python BracelessEnable +indent +highlight

" let g:lt_height = 5
autocmd rcgroup FileType qf nmap <silent> <buffer> <CR> <CR>:lcl<CR>
autocmd rcgroup FileType qf nmap <silent> <buffer> <ESC> :q<CR>
autocmd rcgroup BufNewFile,BufReadPost *.md set filetype=markdown

" Dynamic quickfix height
autocmd rcgroup FileType qf call AdjustWindowHeight(3, 10)

" Elm stuff
let g:elm_format_autosave = 0
let g:elm_setup_keybindings = 0
augroup elmkeys
  autocmd!
  autocmd FileType elm nmap <buffer> <leader>e :ElmErrorDetail<CR>
  autocmd FileType elm nmap <buffer> <leader>d :ElmShowDocs<CR>
  autocmd FileType elm nmap <buffer> <leader>b :ElmBrowseDocs<CR>
augroup END


let g:jsx_ext_required = 0

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#languageclient#enabled = 0

" Tagbar settings
autocmd rcgroup FileType tagbar nmap <silent> <buffer> <ESC> :q<CR>

let g:previewheight=5

augroup prewrite
  autocmd!
  " change class to className in jsx
  autocmd BufWritePre *.js,*.jsx sil! %s/class=/className=/
augroup END

augroup insertmode
  " Adjust timeouts for 'jj' insert mode command
  autocmd!
  autocmd InsertEnter * set timeoutlen=300
  autocmd InsertLeave * set timeoutlen=1000
augroup END


" NERDTree settings
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeMapOpenVSplit = '<c-v>'
let g:NERDTreeMapPreviewVSplit = 'gv'

let g:NERDTreeIgnore=[
      \'\.[^.]*cache$',
      \'\.git$', '\.pyc$', '__pyc__', '__pycache__', '__snapshots__']
augroup NerdTree
  autocmd!
  autocmd FileType nerdtree,'' noremap <buffer> <silent> <leader>n :NERDTreeToggle<CR>
  autocmd FileType nerdtree silent! unmap <buffer> <c-j>
  autocmd FileType nerdtree silent! unmap <buffer> <c-k>
augroup END

""" Emmet config
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_next_key='<M-j>'
let g:user_emmet_prev_key='<M-k>'
let g:user_emmet_settings = {'html':{'empty_element_suffix': ' />'}}

""" Ultisnips config
let g:UltiSnipsExpandTrigger='<nop>'
let g:UltiSnipsListSnippets='<M-s>'
let g:UltiSnipsExpandTrigger='<M-e>'
let g:UltiSnipsUsePythonVersion=3

" let g:UltiSnipsJumpForwardTrigger="<C-j>"
" let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" let g:UltiSnipsSnippetDirectories=[]
" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" let g:ulti_expand_or_jump_res = 0

" vim-sneak
" let g:sneak#label = 1
" nmap s <Plug>SneakLabel_s
" nmap S <Plug>SneakLabel_S
