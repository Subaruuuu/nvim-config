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
  git clone https://github.com/Subaruuuu/nvim-config ~/.config/nvim
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
