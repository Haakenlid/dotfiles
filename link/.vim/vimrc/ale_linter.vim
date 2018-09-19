" config for asynchronous linter ALE
" Asynchronous linting/fixing for Vim and Language Server Protocol (LSP) integration
" https://github.com/w0rp/ale

Plug 'w0rp/ale'
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'json': ['prettier'],
\   'scss': ['prettier'],
\   'python': ['yapf'],
\   'javascript': ['prettier'],
\}

let g:ale_linters = {
\   'python': ['pyls'],
\   'javascript': ['eslint'],
\}

let g:ale_javascript_flow_use_respect_pragma=0 " use flow everywhere
let g:ale_completion_enabled = 1
let g:ale_python_pyls_executable='python -m pyls'
let g:ale_javascript_prettier_options=
      \'--semi false --single-quote --trailing-commma always'

inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"


" Vim airline integration
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always=1
let g:ale_cursor_detail=0 " show error in preview window
let g:ale_fix_on_save=1
let g:ale_open_list=0
let g:ale_lint_on_enter=1


" Ale fix buffer
nnoremap <silent> <leader>ff :ALEFix<CR>
nnoremap <silent> <leader>gt :ALEGoToDefinition<CR>
nnoremap <silent> <leader>hh :ALEHover<CR>

" Error detail
nnoremap <silent> <leader>dd :ALEDetail<CR>
