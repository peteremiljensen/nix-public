#!/usr/bin/env bash
set -euo pipefail
shopt -s inherit_errexit

export cache=peteremiljensen
export GUM_SPIN_SHOW_ERROR=true

spin() {
	local title=$1
	shift

	echo $@
	exit 2

	gum spin \
		--spinner dot \
		--title "$title" \
		--show-output \
		-- bash -c "
      set -euox pipefail
      shopt -s inherit_errexit

      $@
        "
}

get_packages() {
	nix eval --read-only --quiet --quiet --json .#apps |
		jq -r '
      to_entries
      | map(.value | keys)
      | flatten
      | unique
      | map(".#\(.)")
      | .[]
    '
}

push_inputs() {
	nix flake archive --quiet --quiet --json |
		jq -r '.path, (.inputs | to_entries[].value.path)' |
		cachix push "$cache"
}

push_runtime() {
	nix build \
		--quiet \
		--quiet \
		--quiet \
		--no-link \
		--print-out-paths $1 | cachix push "$cache"
}

export -f get_packages push_inputs push_runtime

declare packages
packages="$(spin "Reading flake packages..." get_packages)"

# spin "Pushing flake inputs..." push_inputs

gum conform
spin "Pushing runtime closure..." push_runtime "${packages[@]}"
