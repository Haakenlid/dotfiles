" https://fortes.com/2017/language-server-neovim/
" LanguageClient plugin
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


" Automatically start language servers.
let g:LanguageClient_autoStart = 1
set completeopt=menu,menuone,preview,longest

" Minimal LSP configuration for JavaScript
" let g:LanguageClient_serverCommands = {}
" if executable('javascript-typescript-stdio')
"   let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
"   " Use LanguageServer for omnifunc completion
"   autocmd FileType javascript setlocal omnifunc=LanguageClient#complete
" else
"   echo "javascript-typescript-stdio not installed!\n"
" endif

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls', '--log-file', expand('$HOME/pyls.log')],
    \ }

let g:LanguageClient_diagnosticsList = "Location"

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> <leader>h :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <leader>gt :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <leader>R :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>f :call LanguageClient#textDocument_formatting()<CR>

let g:LanguageClient_loggingLevel='DEBUG'
let g:LanguageClient_loggingFile=expand('$HOME/languageclient.log')
