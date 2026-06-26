function get_weather_waybar
    if ! test -d ~/tmp
        mkdir ~/tmp
    end
    if string match -q "*-dt" $hostname
      curl wttr.in/köln\?format=1 >~/tmp/tmp_weather_save.txt 2>/dev/null
    else
      curl wttr.in/\?format=1 >~/tmp/tmp_weather_save.txt 2>/dev/null
    end
    if test -e ~/tmp/tmp_weather_save.txt
        cat ~/tmp/tmp_weather_save.txt
    else
        echo "no data"
    end
end
