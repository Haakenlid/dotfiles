" https://fortes.com/2017/language-server-neovim/
" LanguageClient plugin
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
" let g:LanguageClient_hasSnippet = 0

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls', '--log-file', expand('$HOME/pyls.log')],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ 'javascript.jsx': ['jsconfig.json'],
\ }

let g:LanguageClient_diagnosticsList = "Location"

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> <leader>h :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>gt :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>R :call LanguageClient#textDocument_rename()<CR>

let g:LanguageClient_loggingLevel='WARN'
let g:LanguageClient_loggingFile=expand('$HOME/languageclient.log')
