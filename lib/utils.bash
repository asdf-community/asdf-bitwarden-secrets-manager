#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/bitwarden/sdk"
TOOL_NAME="bitwarden-secrets-manager"
TOOL_TEST="bws --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^bws-v//' | sed 's/^bws-cli-v//'
}

list_all_versions() {
	list_github_tags
}

get_arch_and_environment() {
	local -r environment=$(uname | tr '[:upper:]' '[:lower:]')
	local -r arch=$(arch)

	if [[ $environment == "darwin" ]]; then
		if [[ $arch != "x86_64" ]] && [[ $arch != "aarch64" ]]; then
			echo "macos-universal"
		else
			echo "$(arch)"-apple-"$environment"
		fi
	elif [[ $environment == "linux" ]]; then
		echo "$(arch)"-unknown-"$environment"-gnu
	else
		fail "unknown environment brand for $environment"
	fi
}

get_release_name() {
	local -r version=$1

	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		grep "$version"
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$GH_REPO/releases/download/$(get_release_name "$version")/bws-$(get_arch_and_environment)-$version.zip"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		chmod +x "$install_path/$tool_cmd"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
