# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/Users/marv/.zsh/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# Shell config
export LANG=en_US.UTF-8

# Neovim
alias v=nvim
alias vim=nvim
export VISUAL=nvim
# export EDITOR="$VISUAL"

# Tmux
alias t=tmux


___MY_VMOPTIONS_SHELL_FILE="${HOME}/.jetbrains.vmoptions.sh"; if [ -f "${___MY_VMOPTIONS_SHELL_FILE}" ]; then . "${___MY_VMOPTIONS_SHELL_FILE}"; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Obsidian
alias oo='cd $HOME/Documents/ObsidianVault/'
# alias or='nvim $HOME/Documents/ObsidianVault/inbox/*.md'
# alias or='nvim $(find "$HOME/Documents/ObsidianVault" -maxdepth 1 -name "*.md" -o -path "$HOME/Documents/ObsidianVault/inbox/*.md")'
# alias or='find "$HOME/Documents/ObsidianVault" -maxdepth 2 \( -name "*.md" -o -path "$HOME/Documents/ObsidianVault/inbox/*.md" \) -print0 | xargs -0 nvim'
alias or='find "$HOME/Documents/ObsidianVault" "$HOME/Documents/ObsidianVault/inbox" -maxdepth 1 -name "*.md" -print0 | xargs -0 nvim'
alias og="/Users/marv/bin/og"
alias ou='cd $HOME/notion-obsidian-sync-zazencodes && node batchUpload.js --lastmod-days-window 5'

# Git
alias gits='git status'
alias gita='git add -u'
gitm() { git commit -m "$1" }
alias gitp='git push'
alias gitu='git commit -m "Update $(date +%F)"'
alias gitq='git add -u && git commit -m "Update $(date +%F)" && git push'
alias gitc='aicommits' # requires aicommits installed (https://github.com/Nutlope/aicommits)

# Dir list, nav
alias pwdy="echo $(pwd) | pbcopy"
alias cl="clear"
alias z="cd"
alias lr="ls -lrt"


alias ls='ls -G'
alias grep='grep'

alias locksleep='pmset displaysleepnow && pmset sleepnow'
alias lock='pmset displaysleepnow'
alias suspend='pmset sleepnow'

# alias zr="cd $(ls -td -- $(pwd)/*/ | head -n 1)"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

bindkey -v

export PATH=$PATH:/Users/marv/.spicetify

source $HOME/.env

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Added by Antigravity
export PATH="/Users/marv/.antigravity/antigravity/bin:$PATH"
export PATH="/opt/homebrew/opt/e2fsprogs/sbin:$PATH"

#AdguardHome
alias adguard='sudo /Applications/AdGuardHome/AdGuardHome'

export PATH="$HOME/.local/bin:$PATH"
export PATH="$(npm prefix -g)/bin:$PATH"


#if there is a session, connect
if [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
  tmux attach || tmux new -s main
fi
export DO_NOT_TRACK=1
