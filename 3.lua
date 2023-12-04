local lines, gears, ans1, ans2 = {}, {}, 0, 0

for line in io.lines("3.txt") do table.insert(lines, line) end

for l, line in ipairs(lines) do
    for i, n, j in line:gmatch("()(%d+)()") do
        i, j = math.max(i-1, 1), math.min(j, #line)
        if line:sub(i, j):match('[^%d%.]')
            or l>1 and lines[l-1]:sub(i, j):match('[^%d%.]')
            or l<#lines and lines[l+1]:sub(i, j):match('[^%d%.]') then
            ans1 = ans1 + tonumber(n)
        end

        for ln=-1,1 do
            for x in (lines[l+ln] or ""):sub(i, j):gmatch("()*") do
                local idx = (l+ln)*#lines+x+i-1
                gears[idx] = gears[idx] or {}
                table.insert(gears[idx], n)
            end
        end
    end
end

for _, v in pairs(gears) do ans2 = ans2 + (#v == 2 and v[1]*v[2] or 0) end

print(ans1, ans2)
