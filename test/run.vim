" Headless tests, from the repository's root:
"   vim -Nu NONE -i NONE -Es -S test/run.vim
" Prints one line per test and exits non-zero when one fails; TEST=<pattern>
" in the environment runs the tests whose names match.
set nocompatible hidden
execute 'set runtimepath^=' . fnameescape(expand('<sfile>:p:h:h'))
execute 'source' fnameescape(expand('<sfile>:p:h:h') . '/plugin/buffer_tools.vim')

let s:tmp = resolve(tempname())
let s:out = []

function! s:reset() abort
  silent! only!
  silent! %bwipeout!
  call delete(s:tmp, 'rf')
  call mkdir(s:tmp, 'p')
  execute 'cd' fnameescape(s:tmp)
endfunction

function! s:test_gb_skips_a_terminal_alternate() abort
  edit a.txt
  terminal ++curwin sleep 60
  edit b.txt
  normal gb
  call assert_equal('a.txt', bufname('%'))
endfunction

function! s:test_gb_with_only_a_terminal_left() abort
  terminal ++curwin sleep 60
  edit a.txt
  call assert_equal("\nNo alternate buffer", execute('normal gb'))
  call assert_equal('a.txt', bufname('%'))
endfunction

let s:failed = 0
let s:prefix = expand('<SID>') . 'test_'
let s:names = []
for s:line in split(execute('function'), "\n")
  if stridx(s:line, 'function ' . s:prefix) == 0
    call add(s:names, matchstr(s:line, '^function \zs[^(]\+'))
  endif
endfor
for s:name in s:names
  let s:label = matchstr(s:name, 'test_\zs\w\+')
  if !empty($TEST) && s:label !~# $TEST
    continue
  endif
  call s:reset()
  let v:errors = []
  try
    call call(s:name, [])
  catch
    call add(v:errors, v:exception . ' @ ' . v:throwpoint)
  endtry
  if empty(v:errors)
    call add(s:out, 'ok   ' . s:label)
  else
    let s:failed += 1
    call add(s:out, 'FAIL ' . s:label)
    call extend(s:out, map(copy(v:errors), '"     " . v:val'))
  endif
endfor
call add(s:out, s:failed ? s:failed . ' failed' : 'all passed')
call writefile(s:out, '/dev/stdout')
call delete(s:tmp, 'rf')
execute 'cquit' (s:failed ? 1 : 0)
