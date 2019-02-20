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

function! ExpandSnippetOrReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --tern-complete
  endif
endfunction

function! DisableLint()
  " isable linting and formatting
  NeomakeDisable
  let g:neoformat_enabled_python = []
  let g:neoformat_enabled_javascript = []
  echom 'Disabled all linting'
endfunction

function! WrapMove(action)
  "Git gutter previous wrap around
  let line = line('.')
  execute a:action
  if line('.') == line
    "=~? case insensitive regex match
    if a:action =~? "next"
      " forward search
      normal gg
    else
      " backward search
      normal G
    endif
    execute a:action
  endif
  normal zz
endfunction

function! StripTrailingWhitespaces()
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

function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$") + 1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

function! BrightHighlightOn()
  hi CursorLine ctermfg=15 cterm=bold
endfunction

function! BrightHighlightOff()
  hi CursorLine ctermfg=none cterm=none
endfunction

function! s:ShowMaps()
  let old_reg = getreg("a")          " save the current content of register a
  let old_reg_type = getregtype("a") " save the type of the register as well
try
  redir @a                           " redirect output to register a
  " Get the list of all key mappings silently, satisfy "Press ENTER to continue"
  silent map | call feedkeys("\<CR>")
  silent map! | call feedkeys("\<CR>")
  redir END                          " end output redirection
  vnew                               " new buffer in vertical window
  put a                              " put content of register
  set ft=vim                         " syntax highlighting
  " Sort on 4th character column which is the key(s)
  " %!sort -k1.4,1.4
finally                              " Execute even if exception is raised
  call setreg("a", old_reg, old_reg_type) " restore register a
endtry
endfunction
com! ShowMaps call s:ShowMaps()      " Enable :ShowMaps to call the function

" Redirect ex command to new tap
function! Redir(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified ft=vim
    silent put=message
  endif
endfunction

function! LargeFile()
   " no syntax highlighting etc
   set eventignore+=FileType
   " save memory when other file is viewed
   setlocal bufhidden=unload
   " is read-only (write with :w new_filename)
   setlocal buftype=nowrite
   " no undo possible
   setlocal undolevels=-1
   " display message
   autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

command! -nargs=+ -complete=command Redir call Redir(<q-args>)
