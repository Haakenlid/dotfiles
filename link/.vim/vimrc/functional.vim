function! Sorted(l)
  let new_list = deepcopy(a:l)
  call sort(new_list)
  return new_list
endfunction

function! Reversed(l)
  let new_list = deepcopy(a:l)
  call reverse(new_list)
  return new_list
endfunction

function! Append(l, val)
  let new_list = deepcopy(a:l)
  call add(new_list, a:val)
  return new_list
endfunction

function! Assoc(l, i, val)
  let new_list = deepcopy(a:l)
  let new_list[a:i] = a:val
  return new_list
endfunction

function! Pop(l, i)
  let new_list = deepcopy(a:l)
  call remove(new_list, a:i)
  return new_list
endfunction

function! Test()
  let ll = [3, 6, 7, 8, 0, 223]
  echo ll
  echo Sorted(ll)
  echo Reversed(ll)
  echo Append(ll, 500)
  echo Assoc(ll, 1, 55)
  echo Pop(ll, -1)
endfun

fun! Mapped(fn, l)
  let new_list = deepcopy(a:l)
  call map(new_list, string(a:fn) . '(v:val)')
  return new_list
endfun

fun! Filtered(fn, l)
  let new_list = deepcopy(a:l)
  call filter(new_list, string(a:fn) . '(v:val)')
  return new_list
endfun

" let mylist = [[1, 2], [3, 4]]
" echo Mapped(function("Reversed"), mylist)
let mylist = [[1, 2], [], [], [3, 4]]
echo Filtered(function('len'), mylist)


" call Test()
