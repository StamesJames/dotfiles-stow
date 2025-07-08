function read_env_from_string
    for line in (echo $argv | string split "\n")
        set parts (string split "=" $line)
        if test (count $parts) -ge 2
            set key (string trim $parts[1])
            set value (string trim $parts[2..-1])

            # Set the environment variable
            set -gx $key $value
        end
    end
end
