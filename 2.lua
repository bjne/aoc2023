local task1, ans1, ans2 = {red=12, green=13, blue=14}, 0, 0

for l in io.lines("2.txt") do
    ans1, ans2 = (function()
        local cubes, sum = {}, 1
        for n,c in l:gmatch('(%d+) (%w+)') do
            if tonumber(n) > task1[c] then l="0"..l end
            cubes[c] = (cubes[c] or 0) < tonumber(n) and tonumber(n) or cubes[c]
        end

        for _, n in pairs(cubes) do sum = sum * n end

        return ans1 + tonumber((l:match('%d+'))), ans2 + sum
    end)()
end

print(ans1, ans2)
