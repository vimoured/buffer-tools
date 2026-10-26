" Shows the previous buffer in the window, then deletes the current one, so
" the window stays open.
function! buffer_tools#close() abort
  let l:current = bufnr('%')
  let l:skip_bt = ['terminal', 'nofile']
  let l:skip_ft = ['netrw']
  let l:all_bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
  let l:valid_bufs = filter(l:all_bufs,
        \ 'index(l:skip_bt, getbufvar(v:val, "&buftype")) == -1 && ' .
        \ 'index(l:skip_ft, getbufvar(v:val, "&filetype")) == -1')

  " If current is a terminal, idx is -1, so it jumps to the last valid buffer.
  let l:idx = index(l:valid_bufs, l:current)
  let l:target_idx = (l:idx - 1 + len(l:valid_bufs)) % len(l:valid_bufs)

  execute 'buffer ' . l:valid_bufs[l:target_idx]

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
    let l:target = sort(l:bufs, {a, b -> b.lastused - a.lastused})[0].bufnr
  endif
  execute 'buffer ' . l:target
endfunction
