source (status dirname)/check.fish
set --local here (status dirname)

set --local repo (mktemp -d)
command git -C $repo init -q -b main
command git -C $repo commit -q --allow-empty -m init

# _hydro_prompt computes git info in a `fish --private --command` subshell;
# conf.d/hydro.fish guards on is-interactive, so run it in an interactive child.
# Regression: function call in the subshell command string must not carry a `$`
# (variable expansion, empty output) and must survive parent-side quoting.
set --local out (
    env HYDRO_CONF=$here/../conf.d/hydro.fish HYDRO_REPO=$repo fish -i -c '
        source $HYDRO_CONF
        cd $HYDRO_REPO
        _hydro_prompt
        sleep 2
        echo RES:$$_hydro_git
    ' 2>/dev/null | string replace --all --regex '\e\[[0-9;? ]*[a-zA-Z]' '' | string replace --filter --regex '^RES:' '' | string trim --right
)

check "subshell sets branch uvar with hash" \
    "$out" \
    "main("(command git -C $repo rev-parse --short=5 HEAD)")"

command rm -rf $repo

check_summary
