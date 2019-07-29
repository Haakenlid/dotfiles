let g:deoplete#enable_at_startup = 1
inoremap <expr> <tab> pumvisible() ? "<c-n>" : "<tab>"
inoremap <expr> <s-tab> pumvisible() ? "<c-p>" : "<s-tab>"
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/echodoc.vim'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

set pumheight=20
set completeopt=menuone,longest,preview
let g:python3_host_prog = '/usr/local/bin/python3'

" Ctrl-Space: summon FULL (synced) autocompletion
inoremap <silent><expr> <C-Space> deoplete#mappings#manual_complete()

" Escape: exit autocompletion, go to Normal mode
" inoremap <silent><expr> <Esc> pumvisible() ? "<C-e><Esc>" : "<Esc>"

" close preview window
" autocmd InsertLeave * silent! pclose!
set runtimepath+=~/.vim/plugged/deoplete.nvim/

" call deoplete#custom#option({ 'max_list': 40 })
call deoplete#custom#option({ 'async_timeout': 100 })

" call deoplete#custom#option('ignore_sources',
"   \ {'_': ['buffer'], 'javascript': ['LC']})

" call deoplete#custom#source('_', 'matchers', ['deoplete-filter-matcher_full_fuzzy'])
call deoplete#custom#source('_', 'sorters', ['sorter_rank'])

