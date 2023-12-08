local lr, map, paths, step1, step2 = {}, {}, {}, 0, 1

for line in io.lines("8.txt") do
    if #lr==0 then
        line:gsub(".", function(k) lr[#lr+1]=k=='L' and 1 or 2 end)
    elseif #line > 0 then
        local from, l, r = line:match('^(%S+)[^(]+%(([^,]+), ([^)]+)%)')
        map[from] = {l,r}
        if from:sub(-1) == "A" then paths[#paths+1] = from end
    end
end

local function walk(path, step)
    return path=="ZZZ" and step or walk(map[path][lr[step%#lr+1]], step + 1)
end

local function gcd(a, b)
    return a == 0 and b or gcd(b % a, a)
end

for _,path in ipairs(paths) do
    local step=0

    while path:sub(-1) ~= "Z" do
        path, step = map[path][lr[step%#lr+1]], step+1
    end

    step2 = step * step2 / gcd(step2, step)
end

print(walk("AAA", 0), step2)
