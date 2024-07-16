local bucket = {}
bucket.__index = bucket

function bucket.new(_next)
    local _bucket = setmetatable({ contents = {} }, bucket)

    local function cell_fn(...)
        _bucket:set(...)

        return _next, ...
    end

    return _bucket, cell_fn
end

function bucket.get(self)
    return unpack(self.contents)
end

function bucket.set(self, ...)
    self.contents = {...}
end

return bucket