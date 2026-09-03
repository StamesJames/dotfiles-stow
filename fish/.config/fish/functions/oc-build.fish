function oc-build -d "Build the opencode sandbox image from ~/.setups/opencode-container"
    argparse 'refresh' -- $argv
    or return

    set -l file ~/.setups/opencode-container/Containerfile
    if not test -f $file
        echo "oc-build: $file not found (stow the templates package first)" >&2
        return 1
    end

    if set -q _flag_refresh
        set -l base ghcr.io/anomalyco/opencode:latest
        podman pull $base
        or return 1
        set -l digests (string match -r 'sha256:[0-9a-f]{64}' -- (podman image inspect --format '{{.RepoDigests}}' $base))
        if not set -q digests[1]
            echo "oc-build: could not resolve digest of $base" >&2
            return 1
        end
        set -l digest $digests[1]
        for d in $digests
            if podman manifest inspect $base@$d 2>/dev/null | string match -q "*image.index*"
                set digest $d
                break
            end
        end
        set -l real (realpath $file)
        sed -i "s|^FROM ghcr.io/anomalyco/opencode@sha256:[0-9a-f]*\$|FROM ghcr.io/anomalyco/opencode@$digest|" $real
        echo "oc-build: re-pinned base image to $digest"
    end

    podman build -t localhost/opencode-sandbox:latest (dirname (realpath $file))
end
