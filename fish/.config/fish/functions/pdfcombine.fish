function pdfcombine
  if not command -v gs >/dev/null
    echo "ghostscript needs to be installed"
    return 1
  end
  if test (count $argv) -lt 2
    echo "needs at least 2 arguments. first all pdfs to combine then where to combine to"
    return 1
  end
  set -l output $argv[-1]
  set -e argv[-1]
  for file in $argv
    if test ! -f "$file"
      echo "Error: File '$file' does not exist"
      return 1
    end
  end

  gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile="$output" $argv
  echo "Merged PDFs to $output"
end
