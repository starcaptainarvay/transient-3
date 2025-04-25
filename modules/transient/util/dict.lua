local dict = {}

function dict.echo(o, n)
    local t = {}

    for i=1, n do
        table.insert(t, o)
    end

    return t
end

function dict.flat(t)
    local output = {}

    for _, v in pairs(t) do
        if type(v) == "table" then
            for _, v2 in pairs(v) do
                table.insert(output, v2)
            end
        else
            table.insert(output, v)
        end
    end

    return output
end

function dict.fullflat(t)
    local output = {}

    for _, v in pairs(t) do
        if type(v) == "table" then
            for _, v2 in pairs(v) do
                table.insert(output, dict.fullflat(v2))
            end
        else
            table.insert(output, v)
        end
    end

    return output
end

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

function dict.reduce(tab, f)
    local output = {}

    for k, v in pairs(tab) do
        if output[k] == nil then
            output[k] = v
        else
            output[k] = f(output[k], v)
        end
    end

    return output
end

return dict