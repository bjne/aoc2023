local r, concat, ans1, c = {}, table.concat

io.open("6.txt"):read('*all'):gsub("%d+", function(n) r[#r+1] = n end)

local function race(t,d)
    c,t,d = 0, tonumber(t), tonumber(d)
    for b=t-1,1,-1 do if b*(t-b) > d then c = c+1 end end
    return c
end

for i=1,#r/2 do ans1 = (ans1 or 1) * race(r[i], r[i+#r/2]) end

print(ans1, race(concat(r,'', 1, #r/2), concat(r, '', #r/2+1)))
