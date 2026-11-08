# buffer-tools

Switch and close buffers without tripping over netrw and terminal buffers, and
keep each file's place: files reopen where the cursor was, and keep their view
when they leave a window and come back.

**Vim or Neovim:** tested on Vim 9.1 and newer. It's plain Vimscript, so it may
work on Neovim, but that's untested.

## Install

```vim
Plug 'vimoured/buffer-tools'
```

## Use

| Command | Mapping | What it does |
| --- | --- | --- |
| `:BufferAlt` | `gb` | Go to the alternate buffer, skipping netrw and terminal buffers; else the most recently used buffer. |
| `:BufferClose` | `<Plug>(buffer-tools-close)` | Delete the current buffer and keep the window, showing the most recently used other buffer. Refuses while a file has unsaved changes. |

`gb` is bound for you. Bind `:BufferClose` yourself, for example:

```vim
nmap <leader>bc <Plug>(buffer-tools-close)
```

## Tests

The specs in [vim-suite](https://github.com/vimoured/vim-suite) define what it
does: `test/buffer-tools.vim`.
