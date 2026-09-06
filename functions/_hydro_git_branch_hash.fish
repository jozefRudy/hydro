function _hydro_git_branch_hash --description "Print branch(sha), tag(sha), or @sha when HEAD is detached"
    set --local branch (command git branch --show-current 2>/dev/null)

    # branch --show-current exits 0 with empty output on detached HEAD
    if test -z "$branch"
        set branch (command git describe --tags --exact-match HEAD 2>/dev/null)
    end
    if test -z "$branch"
        set branch (
            command git rev-parse --short HEAD 2>/dev/null |
                string replace --regex -- '(.+)' '@$1'
        )
    end

    set --local hash (command git rev-parse --short=7 HEAD 2>/dev/null)
    test -n "$hash" && ! string match --quiet -- '@*' "$branch" && set branch "$branch($hash)"

    echo $branch
end
