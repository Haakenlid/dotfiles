" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Easymotion settings
let g:EasyMotion_do_mapping = 1 " Disable default mappings
map <Leader> <Plug>(easymotion-prefix)

" Bi-directional find motions
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <leader>s <Plug>(easymotion-s)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

call plug#begin('~/.vim/plugged')
  Plug 'easymotion/vim-easymotion'
call plug#end()
