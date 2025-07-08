
if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source
  fish_vi_key_bindings
end

read_env_from_string "$(sops --decrypt ~/secrets/.env)"

### my aliases
alias godot4_3="$HOME/programs/godot/Godot_v4.3-stable_linux.x86_64"
alias godot4_4="$HOME/programs/godot/Godot_v4.4-stable_linux.x86_64"
alias godot4_4_1="$HOME/programs/godot/Godot_v4.4.1-stable_linux.x86_64"

alias godot="godot4_4_1"
alias gvim="nvim --listen 127.0.0.1:6004"
alias vim="nvim"
alias tvim="tmuxp load nvim-term"
alias ls="ls --color=auto"

