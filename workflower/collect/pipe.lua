local pipe = {}

function pipe.new(_next, fn)
    local function cell_fn(...)
        fn(...)

        return _next, ...
    end

    return cell_fn
end

return pipe