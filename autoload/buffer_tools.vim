function! s:last_used(bufs) abort
  return sort(a:bufs, {a, b -> b.lastused - a.lastused})[0].bufnr
endfunction

function! buffer_tools#close() abort
  if &buftype ==# '' && &modified
    echo bufname('%') . ' has unsaved changes'
    return
  endif
  let l:current = bufnr('%')
  let l:bufs = filter(getbufinfo({'buflisted': 1}),
        \ 'v:val.bufnr != l:current'
        \ . ' && index(["terminal", "nofile"], getbufvar(v:val.bufnr, "&buftype")) == -1'
        \ . ' && getbufvar(v:val.bufnr, "&filetype") !=# "netrw"')
  if empty(l:bufs)
    hide enew
  else
    execute 'hide buffer ' . s:last_used(l:bufs)
  endif

  " silent!: netrw and terminal buffers complain
  execute 'silent! bdelete! ' . l:current
endfunction

function! s:is_netrw(nr) abort
  return getbufvar(a:nr, '&filetype') ==# 'netrw'
        \ || !empty(getbufvar(a:nr, 'netrw_curdir'))
        \ || bufname(a:nr) =~# 'NetrwTreeListing'
        \ || isdirectory(bufname(a:nr))
endfunction

function! s:is_alt_candidate(nr) abort
  return a:nr > 0 && a:nr != bufnr('%') && bufexists(a:nr) && !s:is_netrw(a:nr)
        \ && getbufvar(a:nr, '&buftype') !=# 'terminal'
endfunction

function! buffer_tools#alt() abort
  let l:target = bufnr('#')
  if !s:is_alt_candidate(l:target)
    let l:bufs = filter(getbufinfo({'buflisted': 1}),
          \ 's:is_alt_candidate(v:val.bufnr)')
    if empty(l:bufs)
      echo 'No alternate buffer'
      return
    endif
    let l:target = s:last_used(l:bufs)
  endif
  execute 'buffer ' . l:target
endfunction
