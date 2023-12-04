local ans1, ans2, copy = 0, 0, {}

for line in io.lines("4.txt") do
    local card, numbers, win = tonumber(line:match('(%d+):')), {}
    for n in (line:match('|(.+)')):gmatch('(%d+)') do
        numbers[n] = true
    end

    for w in (line:match(':([^|]+)|')):gmatch('(%d+)') do
        win = (win or -1) +  (numbers[w] and 1 or 0)
    end

    if win>-1 then
        ans1 = ans1 + 2^win

        for n=card+1,card+1+win do
            copy[n] = (copy[n] or 0) + ((copy[card] or 0) + 1)
        end
    end

    ans2 = ans2 + ((copy[card] or 0) + 1)
end

print(ans1, ans2)
