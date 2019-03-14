#-----------------------------------------------------------------------
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l bg_color 000000

    #-------------------------------------------------------------------
    if not test $last_status -eq 0
        set right_prompt_fg_color red
    else
        set right_prompt_fg_color 94bac5
    end

    #-------------------------------------------------------------------
    if not set -q __fish_prompt_char
        switch (id -u)
            case 0
                set __fish_prompt_char '⚡⚡ '
            case '*'
            set __fish_prompt_char 'λ '
        end
    end

    #-------------------------------------------------------------------
    # user
    set -l left_prompt (echo_color -b $bg_color -o 00ffff (whoami))

    # at sign
    _append left_prompt (echo_color -b $bg_color 77ee00 '@')

    # host
    # set __fish_prompt_hostname (hostname|cut -d . -f 1)
    _append left_prompt (echo_color -b $bg_color -o 77ee00 (hostname))

    # colon
    _append left_prompt (echo_color -b $bg_color -o cccccc ':')

    # working directory (toggle b/t implementations, if needed)
    # _append left_prompt (echo_color -b $bg_color -o aaff7f (prompt_pwd))
    #
    _append left_prompt (echo_color -b $bg_color -o 0000FF (echo $PWD | sed -e "s|^$HOME|~|"))


    # right prompt
    set -l right_prompt (echo '')

    # spaces
    #set -l left_length (visual_length $left_prompt)
    #set -l right_length (visual_length $right_prompt)
    # set -l spaces (math "$COLUMNS - $left_length - $right_length")

    #-------------------------------------------------------------------
    # display first line
    echo  # blank line
    echo -n $left_prompt
    echo -n $git_prompt
    set_color -b $bg_color
    printf "%-"$spaces"s" " "
    echo $right_prompt

    # prompt character
    set_color -b $bg_color -o ff0000
    echo -n $__fish_prompt_char
    set_color normal
    echo -n " "
end