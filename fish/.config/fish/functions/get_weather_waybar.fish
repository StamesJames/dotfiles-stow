function get_weather_waybar
    curl wttr.in/\?format=1 >~/tmp/tmp_weather_save.txt 2>/dev/null
    cat tmp_weather_save.txt
end
