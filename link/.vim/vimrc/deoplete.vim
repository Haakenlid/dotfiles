let g:deoplete#enable_at_startup = 1


inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" Ctrl-Space: summon FULL (synced) autocompletion
inoremap <silent><expr> <M-Space> deoplete#mappings#manual_complete()

" Escape: exit autocompletion, go to Normal mode
" inoremap <silent><expr> <Esc> pumvisible() ? "<C-e><Esc>" : "<Esc>"

augroup deoplete
  autocmd!
  autocmd FileType javascript nnoremap <silent> <buffer> gd :TernDef<CR>
  autocmd FileType python nnoremap <silent> <buffer> gd :TernDef<CR>
augroup END

let g:deoplete#sources#jedi#python_path = 'python3'
let g:deoplete#sources#jedi#show_docstring = 1
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = ""
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = ""

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
Plug 'pbogut/deoplete-elm'
Plug 'Shougo/neco-vim'
Plug 'carlitux/deoplete-ternjs'
