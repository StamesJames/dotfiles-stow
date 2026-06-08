function nmtui
  set -l palette (cat ~/.config/nmtui/palette | tr -d '/n')
  NEWT_COLORS=$palette command nmtui
end
