local function map(t, f)
    local t2 = {}
    for i, v in pairs(t) do
        t2[i] = f(v, i)
    end
    return t2
end

return {
    map = map
}