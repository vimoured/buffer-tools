# buffer-tools

Two buffer commands that work around netrw and terminal buffers, and files that
keep their place:

- A file reopens where the cursor was last time (the `'"` mark), except git
  commit and rebase messages.
- A file that leaves a window and comes back, e.g. with `:BufferAlt`, keeps its
  view: scroll position and cursor.

| Command | `<Plug>` mapping | What it does |
| --- | --- | --- |
| `:BufferClose` | `<Plug>(buffer-tools-close)` | Delete the current buffer but keep the window, showing the previous buffer. Terminal, `nofile` and netrw buffers are skipped. |
| `:BufferAlt` | `<Plug>(buffer-tools-alt)` | Go to the alternate buffer (`:b#`), skipping netrw listings; falls back to the most recently used buffer. |

No keys are bound. For example:

```vim
nmap gb <Plug>(buffer-tools-alt)
nmap <leader>bc <Plug>(buffer-tools-close)
```

## Install

```vim
Plug 'roumail/buffer-tools'
```
