function oc-build -d "Build the opencode sandbox image from ~/.setups/opencode-container"
    argparse 'refresh' -- $argv
    or return

    set -l file ~/.setups/opencode-container/Containerfile
    if not test -f $file
        echo "oc-build: $file not found (stow the templates package first)" >&2
        return 1
    end

    set -l real (realpath $file)

    if set -q _flag_refresh
        set -l tmp (mktemp -d)
        if not curl -fsSL -o $tmp/release.json https://api.github.com/repos/anomalyco/opencode/releases/latest
            rm -rf $tmp
            echo "oc-build: could not query latest opencode release" >&2
            return 1
        end
        set -l matches (cat $tmp/release.json | string match -r '"tag_name": "(v[^"]+)"')
        set -l tag $matches[2]
        if not set -q tag[1]
            rm -rf $tmp
            echo "oc-build: could not resolve latest opencode release tag" >&2
            return 1
        end
        if not curl -fsSL -o $tmp/opencode.tar.gz \
                https://github.com/anomalyco/opencode/releases/download/$tag/opencode-linux-x64.tar.gz
            rm -rf $tmp
            echo "oc-build: could not download opencode $tag tarball" >&2
            return 1
        end
        set -l shasum (sha256sum $tmp/opencode.tar.gz | string split ' ')
        set -l sha $shasum[1]
        rm -rf $tmp
        sed -i -E \
            -e "s|^ARG OPENCODE_VERSION=.*\$|ARG OPENCODE_VERSION=$tag|" \
            -e "s|^ARG OPENCODE_SHA256=.*\$|ARG OPENCODE_SHA256=$sha|" \
            $real

        set -l base archlinux:base-devel
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
        sed -i -E "s|^FROM docker.io/library/archlinux:base-devel@sha256:[0-9a-f]{64}.*\$|FROM docker.io/library/archlinux:base-devel@$digest|" $real
        echo "oc-build: re-pinned opencode to $tag, archlinux base to $digest"
    end

    podman build -t localhost/opencode-sandbox:latest (dirname $real)
end
