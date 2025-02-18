### my exports
export PATH="$HOME/programs/godot:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
eval "$(batman --export-env)"

### my aliases
alias godot="$HOME/programs/godot/Godot_v4.3-stable_linux.x86_64"
alias gvim="nvim --listen 127.0.0.1:6004"
alias vim="nvim"
alias tvim="tmuxp load nvim-term"

### auto generated suff
# Lines configured by zsh-newuser-install
eval "$(starship init zsh)"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt inc_append_history

bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

