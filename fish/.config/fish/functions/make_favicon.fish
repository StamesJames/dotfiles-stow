function make_favicon
  if test -z "$argv[1]"
      echo "Usage: $argv[0] path/to/image.png"
      exit 1
  end
  set -l INPUT_IMAGE "$argv[1]"
  set -l OUTPUT_DIR "."
  # Lanczos for small sizes
  ffmpeg -i "$INPUT_IMAGE" -vf "scale=16:16:force_original_aspect_ratio=decrease,pad=16:16:(ow-iw)/2:(oh-ih)/2:color=0x00000000" -sws_flags lanczos "$OUTPUT_DIR/favicon-16x16.png"
  ffmpeg -i "$INPUT_IMAGE" -vf "scale=32:32:force_original_aspect_ratio=decrease,pad=32:32:(ow-iw)/2:(oh-ih)/2:color=0x00000000" -sws_flags lanczos "$OUTPUT_DIR/favicon-32x32.png"
  ffmpeg -i "$INPUT_IMAGE" -vf "scale=48:48:force_original_aspect_ratio=decrease,pad=48:48:(ow-iw)/2:(oh-ih)/2:color=0x00000000" -sws_flags lanczos "$OUTPUT_DIR/favicon-48x48.png"
  # default (bicubic) for larger sizes
  ffmpeg -i "$INPUT_IMAGE" -vf "scale=64:64:force_original_aspect_ratio=decrease,pad=64:64:(ow-iw)/2:(oh-ih)/2:color=0x00000000" "$OUTPUT_DIR/favicon-64x64.png"
  ffmpeg -i "$INPUT_IMAGE" -vf "scale=96:96:force_original_aspect_ratio=decrease,pad=96:96:(ow-iw)/2:(oh-ih)/2:color=0x00000000" "$OUTPUT_DIR/favicon-96x96.png"
  ffmpeg -i "$INPUT_IMAGE" -vf "scale=180:180:force_original_aspect_ratio=decrease,pad=180:180:(ow-iw)/2:(oh-ih)/2:color=0x00000000" "$OUTPUT_DIR/favicon-180x180.png"
  ffmpeg -i "$INPUT_IMAGE" -vf "scale=192:192:force_original_aspect_ratio=decrease,pad=192:192:(ow-iw)/2:(oh-ih)/2:color=0x00000000" "$OUTPUT_DIR/favicon-192x192.png"
  ffmpeg -i "$INPUT_IMAGE" -vf "scale=512:512:force_original_aspect_ratio=decrease,pad=512:512:(ow-iw)/2:(oh-ih)/2:color=0x00000000" "$OUTPUT_DIR/favicon-512x512.png"

  ffmpeg -i "$OUTPUT_DIR/favicon-16x16.png" -i "$OUTPUT_DIR/favicon-32x32.png" -i "$OUTPUT_DIR/favicon-48x48.png" -i "$OUTPUT_DIR/favicon-64x64.png" "$OUTPUT_DIR/favicon.ico"
end
