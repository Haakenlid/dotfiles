" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_semantic_triggers = { 'elm' : ['.'] }
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_max_num_candidates = 20


" YouCompleteMe shortcuts
nmap <leader>gt :YcmCompleter GoTo<CR>
nmap <leader>gu :YcmCompleter GoToReferences<CR>
nmap <leader>gd :YcmCompleter GetDoc<CR>

let g:ycm_filetype_blacklist = {
      \ 'help' : 1,
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

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
