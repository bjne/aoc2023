local game, valuation = {{},{}}
local AAAAA,AAAAX,AAABB,AAAXX,AABBX,AAXXX,ABCDE = 7,6,5,4,3,2,1

for line in io.lines("7.txt") do
    local hand, bid, cnt = {line:match('(.)(.)(.)(.)(.)')}, line:match('(%d+)$'), {}
    for c=1,5 do cnt[hand[c]] = (cnt[hand[c]] or 0)+1 end

    for task=1,2 do
        local J, got, score = task == 2 and cnt.J

        for card, c in pairs(cnt) do if task==1 or card~="J" then
            if c == 5 then score = AAAAA ; break
            elseif c == 4 then score = AAAAX ; break
            elseif c == 3 then if got == 2 then score=AAABB; break else got=3 end
            elseif c == 2 then if got == 3 then score=AAABB; break elseif got==2 then score=AABBX; break else got=2 end end
        end end

        if not score then
            if got==3 then
                if J==2 then score=AAAAA
                elseif J==1 then score=AAAAX
                else score=AAAXX end
            elseif got==2 then
                if J==3 then score=AAAAA
                elseif J==2 then score=AAAAX
                elseif J==1 then score=AAAXX
                else score=AAXXX end
            elseif J then
                if J>=4 then score=AAAAA
                elseif J==3 then score=AAAAX
                elseif J==2 then score=AAAXX
                elseif J==1 then score=AAXXX end
            else score=ABCDE end
        elseif J then
            if score==AABBX then score=AAABB
            elseif score==AAAAX then score=AAAAA end
        end

        table.insert(game[task], {score or 0, bid, hand})
    end
end

local ranking = function(a,b)
    if a[1] == b[1] then for i=1,5 do
        local va, vb = valuation:find(a[3][i]), valuation:find(b[3][i])
        if va ~= vb then return va > vb end
    end end

    return a[1] < b[1]
end

local ans={0,0}
for task=1,2 do
    valuation = task==2 and "AKQT98765432J" or "AKQJT98765432"

    table.sort(game[task], ranking)
    for i,g in ipairs(game[task]) do
        ans[task] = ans[task] + i*g[2]
    end
end

print(table.concat(ans, "\t"))
