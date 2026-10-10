" netrw maps gb (go to bookmarked directory) in its buffers, shadowing the
" global gb: take it back
nnoremap <buffer> <silent> gb <Cmd>call buffer_tools#alt()<CR>
