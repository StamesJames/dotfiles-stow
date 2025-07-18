function make_filename_lowercase_no_ws
    for filename in $argv
        set lc_filename (string lower "$filename")
        set lc_no_ws_filename (string replace -a -- " " "-" "$lc_filename")
        set lc_no_ws_us_filename (string replace -a -- "_" "-" "$lc_no_ws_filename")
        set new_filename (string replace -r -a -- "--+" "-" "$lc_no_ws_us_filename")
        if test -e $new_filename
            echo "file $new_filename allready exists"
        else
            mv $filename $new_filename
            echo $new_filename
        end
    end
end
