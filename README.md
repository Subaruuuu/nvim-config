## 🚀 Getting Started

- Make a backup of your current Neovim files:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

  or

  ```sh
  # required
  mv ~/.config/nvim{,.bak}

  # optional but recommended
  mv ~/.local/share/nvim{,.bak}
  mv ~/.local/state/nvim{,.bak}
  mv ~/.cache/nvim{,.bak}
  ```

- Clone the starter

  ```sh
  # For pure nvim IDE purpose
  git clone https://github.com/Subaruuuu/nvim-config ~/.config/nvim

  # For "nvim + vscode" IDE purpose
  git clone -b nvim-for-vscode https://github.com/Subaruuuu/nvim-config ~/.config/nvim
  ```

- Remove the `.git` folder, so you can add it to your own repo later

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Start Neovim!

  ```sh
  nvim
  ```

- Run `Lazy` and `mason` before playground
  ```lua
  :Lazy

  or

  :Mason
  ```

- If you want your config back
  ```sh
  rm -rf ~/.config/nvim
  mv ~/.config/nvim.bak ~/.config/nvim
  ```

## NOTE

This branch (`unified`) detects its host at startup and loads the right plugin set on
its own -- no branch switching required.

| | terminal `nvim` | VSCode + [vscode-neovim](https://github.com/vscode-neovim/vscode-neovim) |
|---|---|---|
| detected by | `vim.g.vscode == nil` | `vim.g.vscode` is set |
| plugins | `lua/plugins/common/` + `lua/plugins/nvim/` | `lua/plugins/common/` + `lua/plugins/vscode/` |
| settings | `lua/settings/init.lua` + `nvim.lua` | `lua/settings/init.lua` + `vscode.lua` |

Where to add things:

- **both hosts** -> `lua/plugins/common/` (flash, treesitter, accelerated-jk, mini.*)
- **terminal only** -> `lua/plugins/nvim/` (LSP, cmp, DAP, telescope, statusline, neo-tree, ...)
- **VSCode only** -> `lua/plugins/vscode/`

Note that lazy.nvim's `import` only picks up `*.lua` directly inside the imported
directory plus subdirectories that contain an `init.lua`. That is why
`lua/plugins/nvim/dap/custom.lua` is a plain helper module and not treated as a
plugin spec -- don't add an `init.lua` next to it.

The older `main` (terminal only) and `nvim-for-vscode` (VSCode only) branches are kept
for reference.
