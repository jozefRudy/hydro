source (status dirname)/check.fish
source (status dirname)/../functions/_hydro_git_branch_hash.fish

set --global repo (mktemp -d)

function setup_repo
    command git -C $repo init -q -b main
    command git -C $repo commit -q --allow-empty -m init
    cd $repo
end

function teardown_repo
    cd (dirname $repo)
    command rm -rf $repo
end

setup_repo
check "branch includes short hash" \
    (_hydro_git_branch_hash) \
    "main("(command git -C $repo rev-parse --short=7 HEAD)")"

command git -C $repo checkout -q --detach HEAD
check "detached HEAD prints @hash without duplication" \
    (_hydro_git_branch_hash) \
    "@"(command git -C $repo rev-parse --short HEAD)

command git -C $repo tag v1.0
command git -C $repo checkout -q v1.0
check "tag checkout prints tag(hash)" \
    (_hydro_git_branch_hash) \
    "v1.0("(command git -C $repo rev-parse --short=7 HEAD)")"

teardown_repo
