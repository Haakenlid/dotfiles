" CTRL-P settings

" let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit':  'BrightHighlightOff', }
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

" Disable default mapping since we are overriding it with our command
let g:ctrlp_map = ''

" Keyboard shortcuts
nnoremap gpp :call SwitchToWriteableBufferAndExec('CtrlPMixed')<CR>
nnoremap gpc :call SwitchToWriteableBufferAndExec('CtrlPChange')<CR>
nnoremap gpb :call SwitchToWriteableBufferAndExec('CtrlPBuffer')<CR>
nnoremap gpt :call SwitchToWriteableBufferAndExec('CtrlPTag')<CR>
nnoremap gpm :call SwitchToWriteableBufferAndExec('CtrlPMRUFiles')<CR>
" nnoremap gm :call SwitchToWriteableBufferAndExec('CtrlPMRUFiles')<CR>

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

