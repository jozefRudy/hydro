#!/usr/bin/env fish
# Run all tests: fish tests/run.fish

set --local failed
for t in (status dirname)/*.test.fish
    fish $t; or set --append failed $t
end

set --local n (count $failed)
test $n -eq 0 || echo "# $n test file(s) failed: $failed"
exit $n
