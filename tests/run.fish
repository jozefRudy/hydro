#!/usr/bin/env fish
# Run all tests: fish tests/run.fish

set --local pass 0
set --local fail 0

for t in (status dirname)/*.test.fish
    set --local lines (fish $t | string split \n)
    printf '%s\n' $lines
    set pass (math $pass + (count (string match -- 'ok - *' -- $lines)))
    set fail (math $fail + (count (string match -- 'not ok - *' -- $lines)))
end

echo "# pass $pass, fail $fail"
exit $fail
