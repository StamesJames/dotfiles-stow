#!/usr/bin/env fish

if test "$STAMES_LAPTOP_KEYBOARD_ENABLED" -eq 1
  set -U STAMES_LAPTOP_KEYBOARD_ENABLED 0
  hyprctl keyword '$LAPTOP_KB_ENABLED' "false" -r
else
  set -U STAMES_LAPTOP_KEYBOARD_ENABLED 1
  hyprctl keyword '$LAPTOP_KB_ENABLED' "true" -r
end

