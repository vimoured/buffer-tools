" buffer-tools: close a buffer without closing its window, and switch to the
" alternate buffer, skipping netrw and terminal buffers. Files keep their
" cursor position and view.
if exists('g:loaded_buffer_tools')
  finish
endif
let g:loaded_buffer_tools = 1

command! BufferClose call buffer_tools#close()
command! BufferAlt call buffer_tools#alt()

" <Plug> mappings; no keys are bound here (see README)
nnoremap <silent> <Plug>(buffer-tools-close) <Cmd>call buffer_tools#close()<CR>
nnoremap <silent> <Plug>(buffer-tools-alt) <Cmd>call buffer_tools#alt()<CR>

augroup buffer_tools
  autocmd!
  " Keep a file's view (scroll position and cursor) when it leaves a window
  " and comes back, e.g. after :BufferAlt
  autocmd BufWinLeave * if &buftype ==# '' | let b:buffer_tools_view = winsaveview() | endif
  autocmd BufWinEnter * if &buftype ==# '' && exists('b:buffer_tools_view')
        \ | call winrestview(b:buffer_tools_view) | endif
  " Reopen a file where the cursor was last time ('" mark), except git commit
  " and rebase messages, which are new each time
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$')
        \ && &filetype !~# '^git\%(commit\|rebase\)$'
        \ | execute 'normal! g`"' | endif
augroup END
