# buffer-tools

Two buffer commands that work around netrw and terminal buffers, and files that
keep their place:

- A file reopens where the cursor was last time (the `'"` mark), except git
  commit and rebase messages.
- A file that leaves a window and comes back, e.g. with `:BufferAlt`, keeps its
  view: scroll position and cursor.

| Command | Mapping | What it does |
| --- | --- | --- |
| `:BufferAlt` | `gb` | Go to the alternate buffer (`:b#`), skipping netrw listings and terminal buffers; falls back to the most recently used buffer, or says `No alternate buffer` when there is none. `gb` works in netrw buffers too. |
| `:BufferClose` | `<Plug>(buffer-tools-close)` | Delete the current buffer but keep the window, showing the most recently used other buffer; terminal, `nofile` and netrw buffers are skipped. With none left to show, the window shows an empty buffer. Unsaved changes are never lost. |

For `:BufferClose`, bind a key yourself, for example:

```vim
nmap <leader>bc <Plug>(buffer-tools-close)
```

## Install

```vim
Plug 'vimoured/buffer-tools'
```

## Tests

Tested by [vim-suite](https://github.com/vimoured/vim-suite), in
`test/buffer-tools.vim`, with the dotfiles that use it. Every pull request runs
it.
