set -g fish_color_git_clean green
set -g fish_color_git_staged yellow
set -g fish_color_git_dirty red

set -g fish_color_git_added green
set -g fish_color_git_modified blue
set -g fish_color_git_renamed magenta
set -g fish_color_git_copied magenta
set -g fish_color_git_deleted red
set -g fish_color_git_untracked yellow
set -g fish_color_git_unmerged red

set -g fish_prompt_git_status_added 'Ξ'
set -g fish_prompt_git_status_modified '⬤'
set -g fish_prompt_git_status_renamed 'Ꮺ'
set -g fish_prompt_git_status_copied '⇒'
set -g fish_prompt_git_status_deleted '✗'
set -g fish_prompt_git_status_untracked '⚡⚡'
set -g fish_prompt_git_status_unmerged '!'

set -g fish_prompt_git_status_order added modified renamed copied deleted untracked unmerged

function __git_mario_prompt --description 'Write out the git prompt'
    # If git isn't installed, there's nothing we can do
    # Return 1 so the calling prompt can deal with it
    if not command -sq git
        return 1
    end
    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test -z $branch
        return
    end

    #echo -n ' '

    set -l index (git status --porcelain 2>/dev/null|cut -c 1-2|sort -u)

    if test -z "$index"
        set_color $fish_color_git_clean
        echo -n '(♆ '$branch') ✓'
        set_color normal
        return
    end

    set -l gs
    set -l staged

    for i in $index
        if echo $i | grep '^[AMRCD]' >/dev/null
            set staged 1
        end

        # HACK: To allow matching a literal `??` both with and without `?` globs.
        set -l dq '??'
        switch $i
            case 'A '
                set gs added
            case 'M ' ' M'
                set gs modified
            case 'R '
                set gs renamed
            case 'C '
                set gs copied
            case 'D ' ' D'
                set gs deleted
            case "$dq"
                set gs untracked
            case 'U*' '*U' 'DD' 'AA'
                set gs unmerged
        end
    end

    if set -q staged[1]
        set_color $fish_color_git_staged
    else
        set_color $fish_color_git_dirty
    end

    echo -n '(♆ '$branch') ⚡'

    for i in $fish_prompt_git_status_order
        if contains $i in $gs
            set -l color_name fish_color_git_$i
            set -l status_name fish_prompt_git_status_$i

            set_color $$color_name
            echo -n $$status_name
        end
    end

    set_color normal
end


function visual_length --description\
    "Return visual length of string, i.e. without terminal escape sequences"
    # TODO: Use "string replace" builtin in Fish 2.3.0
    printf $argv | perl -pe 's/\x1b.*?[mGKH]//g' | wc -m
end

function echo_color --description\
    "Echo last arg with color specified by earlier args for set_color"
    set s $argv[-1]
    set -e argv[-1]
    set_color $argv
    echo -n $s
    set_color normal
    echo
end

function _append --no-scope-shadowing
    set $argv[1] "$$argv[1]""$argv[2]"
end

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

    # git
    set -l git (__git_mario_prompt)
    if test -n $git
        # Avoid errors from _append when not in git repo
        _append left_prompt (echo_color -b $bg_color -o 00CED1 " $git")
    end

    # right prompt
    set -l right_prompt (echo '')

    # spaces
    set -l left_length (visual_length $left_prompt)
    set -l right_length (visual_length $right_prompt)
    set -l spaces (math "$COLUMNS - $left_length - $right_length")

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
