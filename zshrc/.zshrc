# load alias and vars
[ -f "$XDG_CONFIG_HOME/zsh/alias" ] && source "$XDG_CONFIG_HOME/zsh/alias"
[ -f "$XDG_CONFIG_HOME/zsh/vars" ] && source "$XDG_CONFIG_HOME/zsh/vars"

# load modules
zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

# cmp opts
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # dorce . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion
zstyle :compinstall filename "$HOME/.zshrc"

# main opts
setopt append_history inc_append_history share_history
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # add a / instead of trailing space when dir is autocompleted
setopt no_case_glob no_case_match # make cmp case insensitice
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # dont't autoclean blanklines
stty stop undef # disable accidental ctrl s

# History setting
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME/zsh_history"

# fzf setup
source <(fzf --zsh) # allow fzf history widget

# keybindings
bindkey -v

# launch starship prompt
eval "$(starship init zsh)"

# batinit
eval "$(batman --export-env)"

# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
