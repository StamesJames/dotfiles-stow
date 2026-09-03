function oc -d "Run opencode in a hardened rootless podman container"
    argparse --ignore-unknown 'ssh' 'shell' 'h/help' -- $argv
    or return

    if set -q _flag_help
        echo "Usage: oc [--ssh] [--shell] [dir] [opencode-args...]"
        echo
        echo "  dir            project folder mounted at /workspace (default: \$PWD);"
        echo "                 consumed only if the first argument is an existing directory"
        echo "  --ssh          forward the SSH agent socket for git over SSH"
        echo "                 (needs \$SSH_AUTH_SOCK; private keys never enter the container)"
        echo "  --shell        start a shell inside the container instead of opencode"
        echo "  opencode-args  passed through to opencode; prefix with -- if they clash"
        echo "                 with oc's flags (e.g. oc -- --help)"
        echo
        echo "The container is rootless, read-only and capability-less; only the project"
        echo "folder is writable. State persists in ~/.local/share/opencode-sandbox."
        echo "Build or update the image with: oc-build [--refresh]"
        return 0
    end

    set -l image localhost/opencode-sandbox:latest
    if not podman image exists $image
        echo "oc: image $image not found — build it first with: oc-build" >&2
        return 1
    end

    set -l dir $PWD
    set -l opencode_args $argv
    if test (count $opencode_args) -ge 1; and test -d $opencode_args[1]
        set dir (realpath $opencode_args[1])
        set -e opencode_args[1]
    end

    if set -q _flag_ssh; and not set -q SSH_AUTH_SOCK
        echo "oc: --ssh needs SSH_AUTH_SOCK (is the agent running?)" >&2
        return 1
    end

    set -l state $HOME/.local/share/opencode-sandbox
    mkdir -p $state/share $state/state $state/cache

    set -l tz (timedatectl show -p Timezone --value 2>/dev/null)
    if test -z "$tz"
        set tz UTC
    end

    set -l cmd podman run --rm \
        --userns=keep-id \
        --cap-drop=ALL \
        --security-opt no-new-privileges \
        --read-only \
        --tmpfs /tmp:rw,exec,nosuid,nodev,size=1g \
        --pids-limit 512 \
        --memory 8g \
        -e TZ=$tz \
        -v $state/share:/home/dev/.local/share/opencode \
        -v $state/state:/home/dev/.local/state/opencode \
        -v $state/cache:/home/dev/.cache/opencode

    if set -q TERM
        set -a cmd -e TERM=$TERM
    end
    if set -q COLORTERM
        set -a cmd -e COLORTERM=$COLORTERM
    end
    if test -f $HOME/.local/share/opencode/auth.json
        set -a cmd -v $HOME/.local/share/opencode/auth.json:/home/dev/.local/share/opencode/auth.json
    end
    if test -f $HOME/.config/opencode/opencode.jsonc
        set -a cmd -v (dirname (realpath $HOME/.config/opencode/opencode.jsonc)):/home/dev/.config/opencode:ro
    end
    # if test -f $HOME/.gitconfig
    #     set -a cmd -v $HOME/.gitconfig:/home/dev/.gitconfig:ro
    # end
    if set -q _flag_ssh
        set -a cmd -v $SSH_AUTH_SOCK:/run/ssh-agent.sock -e SSH_AUTH_SOCK=/run/ssh-agent.sock
        if test -f $HOME/.ssh/known_hosts
            set -a cmd -v $HOME/.ssh/known_hosts:/home/dev/.ssh/known_hosts:ro
        end
    end

    set -a cmd -v $dir:/workspace -w /workspace

    if test -t 0; and test -t 1
        set -a cmd -it
    else if not test -t 0
        set -a cmd -i
    end
    if set -q _flag_shell
        set -a cmd --entrypoint /bin/sh
    end

    set -a cmd $image $opencode_args
    $cmd
end
