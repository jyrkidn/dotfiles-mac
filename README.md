<p align="center"><img src="art/banner-2x.png"></p>

# Dotfiles

My personal macOS dotfiles: shell configuration, aliases, functions, a Homebrew
package list, and macOS defaults. Cloning this repo and running one script sets
up a new Mac the way I like it.

The shell setup is intentionally small and readable — plain `zsh` with a few
Homebrew plugins, **no framework** (oh-my-zsh was removed). You should be able to
open [`.zshrc`](./.zshrc) and understand every line.

## What you get

A terminal with three things, and nothing you have to think about:

| Feature | Provided by | How to use it |
| --- | --- | --- |
| **History autocomplete** (gray "ghost text") | `zsh-autosuggestions` | Start typing; press **→** (right arrow) to accept |
| **Prompt: directory + git branch + git changes** | [Starship](https://starship.rs) | Always visible |
| **Command syntax colours** | `zsh-syntax-highlighting` | Valid commands turn green, mistakes red |

Plus a few quality-of-life extras:

- **`fzf`** — `Ctrl-R` fuzzy history search · `Ctrl-T` find files · `Alt-C` cd into a directory
- **`zoxide`** — `z <part-of-a-dir-name>` jumps to directories you visit often
- **`fnm`** — automatically switches Node version when you `cd` into a project with a `.nvmrc` / `.node-version`
- **Laravel Herd** — local PHP dev; the `a`, `c`, `p`/`pf` aliases run through it

## Repository structure

| File / dir | What it does |
| --- | --- |
| [`.zshrc`](./.zshrc) | Main shell config. Symlinked to `~/.zshrc`. Loads everything below, in order. Read it top to bottom. |
| [`path.zsh`](./path.zsh) | `$PATH` additions (dotfiles `bin/`, Composer, project-local `node_modules/.bin` & `vendor/bin`). |
| [`exports.zsh`](./exports.zsh) | Environment variables: `EDITOR`, `LANG`, history size, `BAT_THEME`, `STARSHIP_CONFIG`. |
| [`aliases.zsh`](./aliases.zsh) | Shortcuts for git, Laravel/Herd, Composer, Docker, Ghostty, etc. |
| [`functions.zsh`](./functions.zsh) | Shell functions: `commit`, `p`/`pf`/`pg` (Pest/PHPUnit), `up`, `db`, `tag`, … |
| [`starship.toml`](./starship.toml) | Prompt configuration (the light-theme variant is `starship.toml.light`). |
| [`Brewfile`](./Brewfile) | Every Homebrew formula & cask to install (`brew bundle`). |
| [`fresh.sh`](./fresh.sh) | One-shot bootstrap for a new Mac (see setup below). |
| [`.macos`](./.macos) | Hundreds of `defaults write` macOS tweaks. Review before running. |
| [`.mackup.cfg`](./.mackup.cfg) | [Mackup](https://github.com/lra/mackup) config — syncs app settings via iCloud. |
| [`.gitignore_global`](./.gitignore_global) | Global gitignore patterns. |
| `bin/phpunit-or-pest` | Prints `pest` or `phpunit` depending on the project; used by the test functions. |
| `bin/setup` | Scaffolds a fresh Laravel project in `~/Sites` (clone, `.env`, migrate, npm). |
| `*.itermcolors` | iTerm2 colour schemes. |
| `art/` | README banner images. |

### How the shell loads

`~/.zshrc` runs its sections in this order (kept explicit on purpose):

1. Source `path.zsh` and `exports.zsh` (your env)
2. Tool `PATH`s (Herd, Bun, `.local/bin`, opencode, LM Studio)
3. Laravel Herd PHP config
4. History options (`HISTFILE`, `SHARE_HISTORY`, dedupe)
5. Completion (`compinit -C`, cached for fast startup)
6. `fnm` (Node) + Bun completions
7. `zsh-autosuggestions` (ghost-text history autocomplete)
8. `fzf`, then `zoxide`
9. `starship` prompt
10. Source `aliases.zsh` and `functions.zsh`
11. `zsh-syntax-highlighting` — **must be last**

## Setting up a new Mac

1. Update macOS to the latest version.
2. Clone this repo to `~/.dotfiles`:

   ```zsh
   git clone git@github.com:jyrkidn/dotfiles-mac.git ~/.dotfiles
   ```

3. Run the bootstrap script:

   ```zsh
   ~/.dotfiles/fresh.sh
   ```

   This installs Homebrew, everything in the [`Brewfile`](./Brewfile) (including
   the shell tools above), symlinks `~/.zshrc` → this repo, creates `~/Sites`,
   and applies the [`.macos`](./.macos) defaults.

4. Open **Herd** once to finish its PHP setup: `open -a Herd`.
5. Restore synced app settings with Mackup: `mackup restore`.
6. Restart to finalise, then open a new terminal.

> 💡 If you clone somewhere other than `~/.dotfiles`, update `$DOTFILES` on
> [line 8 of `.zshrc`](./.zshrc#L8).

### Just the shell (no full setup)

Already have a Mac and only want the shell config:

```zsh
brew install starship zsh-autosuggestions zsh-syntax-highlighting zsh-completions fnm fzf zoxide
git clone git@github.com:jyrkidn/dotfiles-mac.git ~/.dotfiles
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
```

Then open a new terminal.

## Customising

- **Aliases / functions** → edit [`aliases.zsh`](./aliases.zsh) / [`functions.zsh`](./functions.zsh); they're sourced by `.zshrc`.
- **`$PATH`** → [`path.zsh`](./path.zsh).
- **Prompt** → [`starship.toml`](./starship.toml) (see the [Starship docs](https://starship.rs/config/)).
- **Packages** → add to the [`Brewfile`](./Brewfile), then `brew bundle --file ~/.dotfiles/Brewfile`.
- Reload the shell after edits with `reloadshell` (alias for `source ~/.zshrc`).

## Credits

Originally based on [driesvints/dotfiles](https://github.com/driesvints/dotfiles).
Banner by [Caneco](https://twitter.com/caneco). Thanks to everyone who
open-sources their dotfiles.
