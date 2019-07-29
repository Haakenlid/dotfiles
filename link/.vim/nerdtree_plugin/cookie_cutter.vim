if exists('g:loaded_cookie_cutter')
    finish
endif
let g:loaded_cookie_cutter = 1

function! CookieCutter(node)
  if executable('cookiecutter') != 1
    echoerr "cookiecutter program is not installed"
    return
  endif
  let l:path = a:node.path
  if l:path.isDirectory ==# 0
      let l:path = l:path.getParent()
  endif
  let l:dir = l:path.str({'format': 'Cd'})
  let l:name=input('dir: ' . l:dir . ' component name? ')
  if l:name ==# ''
    return
  endif
  execute '!cookiecutter --no-input --output-dir ' . l:dir . ' component component=' . l:name
  normal R
  execute 'NERDTreeFind ' . l:dir  . '/' . l:name
  normal O
endfunction

call NERDTreeAddKeyMap({
       \ 'key': 'K',
       \ 'override': 1,
       \ 'callback': 'CookieCutter',
       \ 'quickhelpText': 'cookie cutter in directory',
       \ 'scope': 'Node' })

