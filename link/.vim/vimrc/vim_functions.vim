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
