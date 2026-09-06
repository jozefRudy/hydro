function check --argument-names name actual expected --description "Assert actual = expected, print TAP-style result"
    if test "$actual" = "$expected"
        echo "ok - $name"
    else
        echo "not ok - $name"
        echo "  expected: $expected"
        echo "  actual:   $actual"
        set --global --append failures $name
    end
end
