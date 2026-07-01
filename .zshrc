# ~/.zshrc  —  kept deliberately small and readable.
#
# Reads top to bottom. Each section says what it does and why.
# Personal aliases/functions/exports live in the *.zsh files next to this one.
# ---------------------------------------------------------------------------

export DOTFILES="$HOME/.dotfiles"

# ── Personal environment (from the dotfiles repo) ──────────────────────────
# path.zsh    -> PATH additions ($DOTFILES/bin, composer, project-local bins)
# exports.zsh -> EDITOR, LANG, history size, BAT_THEME, STARSHIP_CONFIG, ...
source "$DOTFILES/path.zsh"
source "$DOTFILES/exports.zsh"

# ── Tool PATHs (things installed outside the dotfiles) ─────────────────────
export PATH="$HOME/Library/Application Support/Herd/bin:$PATH"   # Laravel Herd
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"                             # Bun
export PATH="$HOME/.local/bin:$PATH"                            # uv / pipx tools
export PATH="$HOME/.opencode/bin:$PATH"                         # opencode
export PATH="$HOME/.lmstudio/bin:$PATH"                         # LM Studio CLI

# ── Laravel Herd PHP config ────────────────────────────────────────────────
export PHP_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/:$PHP_INI_SCAN_DIR"
export HERD_PHP_74_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/74/"
export HERD_PHP_81_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/81/"
export HERD_PHP_82_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/82/"
export HERD_PHP_83_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/83/"
export HERD_PHP_84_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/84/"
export HERD_PHP_85_INI_SCAN_DIR="$HOME/Library/Application Support/Herd/config/php/85/"

# ── History ────────────────────────────────────────────────────────────────
# Where history lives and how much is kept. (Sizes come from exports.zsh.)
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
setopt SHARE_HISTORY          # share history live across open terminals
setopt HIST_IGNORE_ALL_DUPS   # drop older duplicate commands
setopt HIST_IGNORE_SPACE      # a command starting with a space isn't recorded
setopt HIST_REDUCE_BLANKS     # tidy up whitespace before saving

# ── Completion ─────────────────────────────────────────────────────────────
# Tab-completion. `-C` skips the slow security check for a fast startup.
fpath=(/opt/homebrew/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -C

# ── Node (fnm) ─────────────────────────────────────────────────────────────
# Auto-switches node version when you cd into a project with .nvmrc / .node-version.
eval "$(fnm env --use-on-cd)"

# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ── History autocomplete (the gray "ghost text") ───────────────────────────
# Suggests as you type, based on your history. Press → (right arrow) to accept.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ── Fuzzy finder (fzf) ─────────────────────────────────────────────────────
# Ctrl-R = fuzzy search history · Ctrl-T = find files · Alt-C = cd into dir
source <(fzf --zsh)

# ── Smart directory jumping (zoxide) ───────────────────────────────────────
# `z <part-of-a-dir-name>` jumps to dirs you visit often.
eval "$(zoxide init zsh)"

# ── Prompt (Starship): directory + git branch + git changes ────────────────
eval "$(starship init zsh)"

# ── Personal aliases & functions (from the dotfiles repo) ──────────────────
source "$DOTFILES/aliases.zsh"
source "$DOTFILES/functions.zsh"

# ── Command syntax colours ─────────────────────────────────────────────────
# MUST stay last: valid commands turn green, mistakes turn red.
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
