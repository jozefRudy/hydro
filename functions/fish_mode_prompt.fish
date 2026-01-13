function fish_mode_prompt
    # Cursor shape indicates mode:
    # - Insert: bar
    # - Normal: block
    # - Replace: underline
    # - Visual: block (same as normal)
    switch $fish_bind_mode
        case default
            echo -en "\e[2 q" # block
        case insert
            echo -en "\e[6 q" # bar
        case replace replace_one
            echo -en "\e[4 q" # underline
        case visual
            echo -en "\e[2 q" # block
    end
end
