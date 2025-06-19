#!/usr/bin/env bash
# Put this in, e.g., ~/.local/bin/somafzf (and chmod +x it),
# or source it in your ~/.bashrc as a function.

somafzf() {
    if [[ -n $1 ]]; then
        mpv --no-video "https://somafm.com/$1.pls"
        return
    fi

    mapfile -t stations < <(
        curl -s "https://somafm.com/" \
        | grep -oE '/[a-z0-9]+\.pls' \
        | sed -E 's@/([a-z0-9]+)(256|130|64|320|32)\.pls@/\1.pls@g' \
        | sed 's@/@@; s@\.pls@@' \
        | sort -u
    )

    while true; do
        choice=$(printf "%s\n" "${stations[@]}" | fzf --prompt="SomaFM station: ")
        if [[ -z $choice ]]; then
            echo "No station selected."
            return 1
        fi

        mpv --no-video "https://somafm.com/$choice.pls"
        code=$?

        if (( code != 0 )); then
            echo "mpv exited with code $code. Exiting."
            return
        fi
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    somafzf "$@"
fi
