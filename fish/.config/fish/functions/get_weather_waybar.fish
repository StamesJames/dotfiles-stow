function get_weather_waybar
    if ! test -d ~/tmp
        mkdir ~/tmp
    end
    curl wttr.in/\?format=1 >~/tmp/tmp_weather_save.txt 2>/dev/null
    if test -e ~/tmp/tmp_weather_save.txt
        cat ~/tmp/tmp_weather_save.txt
    else
        echo "no data"
    end
end
