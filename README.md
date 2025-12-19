# Modern Vim IDE Configuration

> A modernized, high-performance Vim environment that transforms standard Vim into a lightweight IDE. This configuration is optimized for Python, TypeScript/React, and Ansible development, replacing 15 years of legacy configuration with a streamlined setup using `vim-plug`.

---

## Features

* **Plugin Management:** Handled via [vim-plug](https://github.com/junegunn/vim-plug).
* **Intellisense (LSP):** Full code completion, "Go to Definition," and error checking via [CoC](https://github.com/neoclide/coc.nvim).
    * Includes support for Python, TypeScript, JSON, and YAML.
* **Fuzzy Finding:** Instantly find files, buffers, and text using `fzf`.
* **Git Integration:** Visual indicators for added/modified/removed lines in the gutter.
* **Status Bar:** Clean, informative status line using `vim-airline` (Tomorrow Night theme).
* **Smart Indentation:**
    * **Python:** 4 spaces.
    * **JS/TS/Web/YAML:** 2 spaces.
    * **Ansible:** Enhanced Jinja2/YAML detection to prevent indentation errors.
* **Whitespace Management:** Automatically trims trailing whitespace on save (cursor position preserved).

## Prerequisites

To get the full functionality (specifically the Intelligence/LSP features), the target machine needs:

1.  **Vim** (Version 8.1 or higher recommended).
2.  **Node.js** (Required for CoC).
    * *Debian/Ubuntu:* `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash && nvm install --lts`
3.  **Ripgrep** (Optional, but recommended for super-fast text searching).
    * *Debian/Ubuntu:* `sudo apt-get install ripgrep`

## Installation

### 1. Clone the Repository
```bash
git clone [https://github.com/yourusername/vim-files.git](https://github.com/yourusername/vim-files.git) ~/vim-files
```

### 2. Deploy Files

You can either copy the files or symlink them (symlinking is recommended to keep the repo in sync).

**Option A: Symlink (Recommended)**

```bash
# Back up existing config
mv ~/.vim ~/.vim.bak && mv ~/.vimrc ~/.vimrc.bak

# Link new config
ln -s ~/vim-files/.vim ~/.vim && ln -s ~/vim-files/.vimrc ~/.vimrc
```

**Option B: Copy**

```bash
cp -r ~/vim-files/.vim ~/ && cp ~/vim-files/.vimrc ~/
```

### 3. "Hydrate" the Plugins

Run these commands in your terminal to install the plugins and language servers without needing to open the editor interactively:

```bash
# 1. Install Plugins (Auto-pairs, Airline, Polyglot, CoC, FZF, etc.)
vim +PlugInstall +qall

# 2. Install Language Servers (Python, TS, YAML, JSON)
vim +"CocInstall -sync coc-json coc-yaml coc-pyright coc-tsserver coc-snippets" +qall
```
---

## Cheat Sheet

### 🧠 Intelligence (CoC)
| Key | Action |
| :--- | :--- |
| `<Tab>` / `<S-Tab>` | Cycle through autocomplete suggestions. |
| `<Enter>` | Confirm selection. |
| `gd` | **Go to Definition** (jump to source). |
| `gy` | Go to Type Definition. |
| `gr` | Go to References (where is this used?). |
| `K` | Show **Documentation** (hover). |

### 🔍 Navigation (FZF)
| Key | Action |
| :--- | :--- |
| `<Ctrl-P>` | Fuzzy find **files** by name. |
| `<Ctrl-B>` | Fuzzy find open **buffers**. |
| `<Ctrl-F>` | Fuzzy find **text** inside files (requires Ripgrep). |

### 🛠 Editing & Utility
| Key | Action |
| :--- | :--- |
| `gc` | Toggle comment (Visual Mode selection). |
| `gcc` | Toggle comment (Current line). |
| `~` / `+` | Git modification markers in the left gutter. |
| `:TrimWhitespace` | Runs automatically on save. |

---

## Themes

The configuration defaults to **Tomorrow-Night-Bright**. Two fallback themes are included in `.vim/colors` if you prefer them:
* `herald.vim` (Good contrast, but comments can be dark).
* `desert_evening.vim` (A modified version of the classic Desert).

To change the theme, edit .vimrc:

```vim
" Edit .vimrc to change the theme:
colorscheme herald
" OR
colorscheme desert_evening
```
