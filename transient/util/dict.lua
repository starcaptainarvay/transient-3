local dict = {}
function dict.map(tab, f)
    local output = {}

    for k, v in pairs(tab) do
        output[k] = f(v, k)
    end

    return output
end

function dict.filter(tab, f)
    local output = {}

    for k, v in pairs(tab) do
        if f(v, k) then
            output[k] = v
        end
    end

    return output
end

function dict.invert(tab)
    local output = {}

    for k, v in pairs(tab) do
        output[v] = k
    end

    return output
end

function dict.keys(tab)
    local output, i = {}, 1

    for k, _ in pairs(tab) do
        output[i] = k
        i = i + 1
    end

    return output
end

function dict.values(tab)
    local output, i = {}, 1

    for _, v in pairs(tab) do
        output[i] = v
        i = i + 1
    end

    return output
end

return dict