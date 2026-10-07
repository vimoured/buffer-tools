# buffer-tools

Two buffer commands that work around netrw and terminal buffers.

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
