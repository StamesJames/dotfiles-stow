function setup_opencode -d "Copy opencode setups into the current project based on its type"
    set -l templates_dir ~/.setups/opencode

    set -l type
    if test (count $argv) -ge 1
        set type $argv[1]
        echo "template-init: using explicit '$type'"
    else
        if test -f lakefile -o -f lakefile.lean -o -f lakefile.toml
            set type lean
        else if test -f project.godot
            set type godot
        else if test -f nuxt.config.js -o -f nuxt.config.ts -o -f nuxt.config.mjs -o -f nuxt.config.mts; or _has_dep nuxt
            set type nuxt
        else if test -f vue.config.js -o -f vue.config.ts; or _has_dep vue
            set type vue
        end

        if test -z "$type"
            echo "template-init: could not detect project type in $PWD" >&2
            return 1
        end
        echo "template-init: detected '$type' project"
    end

    set -l src $templates_dir/$type
    if not test -d "$src"
        echo "template-init: no template for '$type' at $src" >&2
        return 1
    end

    set -l conflicts
    for rel in (find "$src" -type f -printf '%P\0' | string split0)
        if test -e "$rel"
            set -a conflicts "$rel"
        end
    end

    if test (count $conflicts) -gt 0
        echo "template-init: refusing to overwrite the following existing files in $PWD:" >&2
        for c in $conflicts
            echo "  $c" >&2
        end
        return 1
    end

    for gitdir in (find "$src" -type d -name .git -prune -printf '%P\0' | string split0)
        echo "template-init: WARNING: template contains a .git directory at $gitdir — it will be copied into your project." >&2
        echo "                    Remove it afterwards with: rm -rf \"$gitdir\"" >&2
    end
    
    if not test -d ".opencode"
      mkdir ".opencode"
    end

    cp -r "$src/." ".opencode"
    echo "template-init: copied $type template into $PWD"
end


function _has_dep -d "Return success if package <name> is listed in the local package.json"
    if not test -f package.json
        return 1
    end
    if command -v jq >/dev/null
        jq -e --arg p "$argv[1]" '.dependencies[$p] // .devDependencies[$p] // empty' package.json >/dev/null
    else
        grep -Eq "\"$argv[1]\"[[:space:]]*:" package.json
    end
end
