function scale_pdf_to_a4
  if not command -v gs >/dev/null
    echo "ghostscript needs to be installed"
    return 1
  end
  if test (count $argv) -lt 1
    echo "needs 1 input"
    return 1
  end
  set -l output ""
  set -l input ""
  if test (count $argv) -lt 2
    echo "no output name is given. input name is used as output name with scaled suffix"
    set output (string replace -r '\.pdf$' '_scaled.pdf' $argv[-1])
    set input $argv[-1]
  else
    set output $argv[-1]
    set input $argv[-2]
  end
  echo "input: $input"
  echo "output: $output"
  if test ! -e $input
    echo "input file $input does not exist"
    return 1
  end
  if test -e $output
    echo "output file $output already exists. please remove it first or choose a different name"
    return 1
  end
  gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
     -sPAPERSIZE=a4 \
     -dPDFA \
     -dFitPage=true \
     -sOutputFile="$output" "$input"
  echo "scaled $input to $output"
end
