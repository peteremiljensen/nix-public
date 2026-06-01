#!/usr/bin/env fish

set -gx cache peteremiljensen
set -gx GUM_SPIN_SHOW_ERROR true
set -gx GUM_SPIN_SHOW_STDOUT true

function log
    set -l text $argv[1]
    set -f log_level $argv[2]
    if test (count $argv) -lt 2
        set -f log_level info
    end

    # set -e argv[1]
    # set -e argv[1]

    gum log "$text" -l "$log_level" >&2; or exit $status
end

function pipecheck --no-scope-shadowing
    set -l last_pipestatus $pipestatus
    set -l last_status $status
    for s in $last_pipestatus
        test $s -gt 0; and exit $s
    end
end

function spin_fn
    set -l title $argv[1]
    set -l fn_name $argv[2]
    set -l fn_args $argv[3..]
    # set -e argv[1]
    # set -e argv[1]

    gum spin \
        --spinner dot \
        --title "$title" \
        -- fish $(status filename) "$fn_name" $fn_args; or exit $status
end

function packages
    nix eval --read-only --quiet --quiet --json .#apps |
        jq -cr 'to_entries|map(.value | keys)|flatten|unique|.[]'
    pipecheck
end

function push_inputs
    nix flake archive --quiet --quiet --quiet --json |
        jq -r '.path,(.inputs|to_entries[].value.path)' |
        cachix push $cache >&2
    pipecheck
end

function push_runtime
    test (count $argv) -eq 0
    and log "missing packages as input" error
    and exit 1

    set -l pkgs $argv

    printf '.#%s'\n $pkgs[1..] | xargs nix build \
        --quiet \
        --quiet \
        --quiet \
        --no-link \
        --print-out-paths | \
        string collect | read -zla paths
    pipecheck

    cachix push $cache $paths[1..]; or exit $status
end

if test (count $argv) -gt 0; and set -lx fn $argv[1]; and functions -q "$fn"
    $fn $argv[2..]
    exit 0
end

spin_fn "Pushing flake inputs..." "push_inputs"

set -l package_list (spin_fn "Reading flake packages..." "packages")
gum confirm "Pushing packages: $(echo $package_list | string join ' ')"; or exit $status
spin_fn "Pushing runtime closure..." push_runtime $package_list
