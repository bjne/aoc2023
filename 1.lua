local ans1, ans2, num = 0, 0, {"one","two","three","four","five","six","seven","eight","nine"}

for l in io.lines("1.txt") do
    ans1 = ans1 + tonumber(l:match('(%d)')..l:match('(%d)%D*$'))
    for n, p in pairs(num) do l = l:gsub(p, "%1"..n.."%1") end
    ans2 = ans2 + tonumber(l:match('(%d)')..l:match('(%d)%D*$'))
end

print(ans1, ans2)
