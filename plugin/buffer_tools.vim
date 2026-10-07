" buffer-tools: close a buffer without closing its window, and switch to the
" alternate buffer, skipping netrw and terminal buffers.
if exists('g:loaded_buffer_tools')
  finish
endif
let g:loaded_buffer_tools = 1

command! BufferClose call buffer_tools#close()
command! BufferAlt call buffer_tools#alt()

" <Plug> mappings; no keys are bound here (see README)
nnoremap <silent> <Plug>(buffer-tools-close) <Cmd>call buffer_tools#close()<CR>
nnoremap <silent> <Plug>(buffer-tools-alt) <Cmd>call buffer_tools#alt()<CR>
