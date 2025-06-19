# Copy the function into your Fish configuration. For example, in ~/.config/fish/functions/somafzf.fish
function somafzf
    if test -n "$argv"
        mpv --no-video "https://somafm.com/$argv[1].pls"
        return
    end

    set stations (curl -s "https://somafm.com/" \
        | grep -oE '/[a-z0-9]+\.pls' \
        | sed -E 's@/([a-z0-9]+)(256|130|64|320|32)\.pls@/\1.pls@g' \
        | sed 's@/@@; s@\.pls@@' \
        | sort -u)

    while true
        set choice (printf "%s\n" $stations | fzf --prompt="SomaFM station: ")
        if test -z "$choice"
            echo "No station selected."
            return 1
        end

        mpv --no-video "https://somafm.com/$choice.pls"
        and set code 0; or set code $status

        if test $code -ne 0
            echo "mpv exited with code $code. Exiting."
            return
        end
    end
end

