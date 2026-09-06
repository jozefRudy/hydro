function check --argument-names name actual expected --description "Assert actual = expected, print TAP-style result"
    if test "$actual" = "$expected"
        echo "ok - $name"
        set --global pass_count (math $pass_count + 1)
    else
        echo "not ok - $name"
        echo "  expected: $expected"
        echo "  actual:   $actual"
        set --global --append failures $name
    end
end

function check_summary --description "Print pass/fail counts and exit nonzero on failure"
    set --query pass_count || set --global pass_count 0
    set --local n (count $failures)
    echo "# pass $pass_count, fail $n"
    exit $n
end
