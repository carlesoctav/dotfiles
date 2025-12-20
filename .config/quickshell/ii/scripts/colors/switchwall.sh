#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
SHELL_CONFIG_FILE="$XDG_CONFIG_HOME/illogical-impulse/config.json"

set_wallpaper_path() {
    local path="$1"
    if [ -f "$SHELL_CONFIG_FILE" ]; then
        jq --arg path "$path" '.background.wallpaperPath = $path' "$SHELL_CONFIG_FILE" > "$SHELL_CONFIG_FILE.tmp" && mv "$SHELL_CONFIG_FILE.tmp" "$SHELL_CONFIG_FILE"
    fi
}

main() {
    local imgpath=""
    local mode_flag=""
    local type_flag=""
    local noswitch_flag=""

    get_type_from_config() {
        jq -r '.appearance.palette.type' "$SHELL_CONFIG_FILE" 2>/dev/null || echo "scheme-tonal-spot"
    }

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --mode)
                mode_flag="$2"
                shift 2
                ;;
            --type)
                type_flag="$2"
                shift 2
                ;;
            --image)
                imgpath="$2"
                shift 2
                ;;
            --noswitch)
                noswitch_flag="1"
                imgpath=$(jq -r '.background.wallpaperPath' "$SHELL_CONFIG_FILE" 2>/dev/null || echo "")
                shift
                ;;
            *)
                if [[ -z "$imgpath" ]]; then
                    imgpath="$1"
                fi
                shift
                ;;
        esac
    done

    # Determine mode if not set
    if [[ -z "$mode_flag" ]]; then
        current_mode=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null | tr -d "'")
        if [[ "$current_mode" == "prefer-dark" ]]; then
            mode_flag="dark"
        else
            mode_flag="light"
        fi
    fi

    # Get type from config if not set
    if [[ -z "$type_flag" ]]; then
        type_flag="$(get_type_from_config)"
    fi

    # Convert "auto" to default scheme (matugen doesn't support "auto")
    if [[ "$type_flag" == "auto" ]]; then
        type_flag="scheme-tonal-spot"
    fi

    # Prompt for wallpaper if needed
    if [[ -z "$imgpath" && -z "$noswitch_flag" ]]; then
        local start_dir
        start_dir="$(xdg-user-dir PICTURES)/Wallpapers/showcase" 2>/dev/null || start_dir="$(xdg-user-dir PICTURES)/Wallpapers" 2>/dev/null || start_dir="$(xdg-user-dir PICTURES)"
        imgpath="$(nautilus --select "$start_dir" 2>/dev/null & zenity --file-selection --title='Choose wallpaper' --filename="$start_dir/")"
    fi

    if [[ -z "$imgpath" ]]; then
        echo 'Aborted'
        exit 0
    fi

    # Update wallpaper path in config
    set_wallpaper_path "$imgpath"

    # Set GNOME color-scheme and gtk-theme
    if [[ "$mode_flag" == "dark" ]]; then
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        gsettings set org.gnome.desktop.interface gtk-theme ''
        gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
    elif [[ "$mode_flag" == "light" ]]; then
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        gsettings set org.gnome.desktop.interface gtk-theme ''
        gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
    fi

    # Build matugen command
    local matugen_args=(image "$imgpath" -m "$mode_flag")
    [[ -n "$type_flag" ]] && matugen_args+=(-t "$type_flag")

    matugen "${matugen_args[@]}"
}

main "$@"
