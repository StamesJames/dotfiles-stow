function obfuscate_image --description "Obfuscate an image to prevent AI recognition"
  if test (count $argv) -lt 1
    echo "Error: No input provided"
    echo "Usage: obfuscate_image <image_file>"
    return 1
  end
  if not test -f "$argv[1]"
    echo "Error: File '$argv[1]' does not exist."
    echo "Usage: obfuscate_image <image_file>"
    return 1
  end
  if not command -v magick >/dev/null
    echo "Error: ImageMagick not installed."
    return 1
  end

  set -l input $argv[1]
  echo "obfuscating: $input"
  set -l output "anon_"(string split -r -m1 . $input)[1]".jpg"
  echo "to: $output"

  echo "start obfuscation..."
  magick "$input" \
    -attenuate 0.1 +noise Gaussian \
    -sampling-factor 4:2:0 \
    -define jpeg:dct-method=float \
    -unsharp 0x5 \
    -brightness-contrast -1x2 \
    -strip \
    -quality 90 \
    "$output"

  # magick "$input" \
  #   -scale 25% -scale 400% \
  #   -attenuate 0.5 +noise Gaussian \
  #   -strip \
  #   -quality 80 \
  #   "$output"

  echo "Saved obfuscated image to: $output"

end


