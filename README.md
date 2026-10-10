# buffer-tools

Two buffer commands that work around netrw and terminal buffers, and files that
keep their place:

- A file reopens where the cursor was last time (the `'"` mark), except git
  commit and rebase messages.
- A file that leaves a window and comes back, e.g. with `:BufferAlt`, keeps its
  view: scroll position and cursor.

| Command | Mapping | What it does |
| --- | --- | --- |
| `:BufferAlt` | `gb` | Go to the alternate buffer (`:b#`), skipping netrw listings; falls back to the most recently used buffer. `gb` works in netrw buffers too. |
| `:BufferClose` | `<Plug>(buffer-tools-close)` | Delete the current buffer but keep the window, showing the previous buffer. Terminal, `nofile` and netrw buffers are skipped. |

For `:BufferClose`, bind a key yourself, for example:

```vim
nmap <leader>bc <Plug>(buffer-tools-close)
```

## Install

```vim
Plug 'roumail/buffer-tools'
```
