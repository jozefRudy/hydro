source (status dirname)/check.fish

set --local here (status dirname)

set --local base (mktemp -d)
set --local cfg $base/fish
mkdir -p $cfg
ln -s (realpath $here/../functions) $cfg/functions
ln -s (realpath $here/../conf.d) $cfg

# conf.d/hydro.fish guards on is-interactive, so run in an interactive child.
# Regression: duration segments must be joined without spaces ("1m46.5s", not "1m 46.5s").
set --local out (
    env HOME=$base XDG_CONFIG_HOME=$base fish -i -c '
        function _hydro_git_branch_hash; end
        set CMD_DURATION 106500
        _hydro_postexec
        echo RES:$_hydro_cmd_duration
    ' 2>/dev/null | string replace --all --regex '\e\[[0-9;? ]*[a-zA-Z]' '' | string replace --filter --regex '^RES:' '' | string trim --right
)

check "duration joined without spaces" "$out" "1m46.5s"

command rm -rf $base
