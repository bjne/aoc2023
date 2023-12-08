local rank = {}
local r, rank = {"A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"}, {}
for i,v in ipairs(r) do rank[v] = i end

local game = {}
for line in io.lines("7.txt") do
    local hand, b = line:match('(%S+) (%d+)')
    local h = {hand:match('(.)(.)(.)(.)(.)')}
    table.sort(h, function(x,y) return rank[x] < rank[y] end)

    local prev, cnt, score =h[1], {[h[1]] = 1}
    for i=2,5 do cnt[h[i]] = (cnt[h[i]] or 0)+1 end

    local got,AAAAA,AAAAX,AAAKK,AAAXX,AABBX,AAXXX,ABCDE = 0,7,6,5,4,3,2,1
    for _,c in pairs(cnt) do
        if c == 5 then score = AAAAA ; break
        elseif c == 4 then score = AAAAX ; break
        elseif c == 3 then if got == 2 then score=AAAKK; break else got=3 end
        elseif c == 2 then if got == 3 then score=AAAKK; break elseif got==2 then score=AABBX; break else got=2 end end
    end

    if not score then
        if got==3 then score=AAAXX
        elseif got==2 then score=AAXXX
        else
            for i=1,#r do
                if cnt[r[i]] and cnt[r[i+1]] and cnt[r[i+2]] and cnt[r[i+3]] and cnt[r[i+4]] then
                    score = ABCDE
                end
            end
        end
    end

    --for _,card in ipairs(h) do
    --    score = (bit.lshift(score or 0, 4)) + (#r - rank[card])
    --end

    table.insert(game, {score or 0, b, hand})

    -- int handValue = HandType; (i.e. 0 for high card, 7 for Four of a kind, etc.)
    -- for each card
    -- handValue = (handValue << 4) + cardValue  (i.e. 0 for 2, 9 for Jack, etc.)
end

table.sort(game, function(a,b)
    if a[1] == b[1] then
        for i=1,5 do
            if rank[a[3]:sub(i,i)] == rank[b[3]:sub(i,i)] then
            else
                return rank[a[3]:sub(i,i)] > rank[b[3]:sub(i,i)]
            end
        end
    end
    return a[1] < b[1]
end)

local ans1 = 0
for i,g in ipairs(game) do
    --print(ans1, i .. "*" .. g[2])
    ans1 = ans1 + i*g[2]
end

print(ans1)
