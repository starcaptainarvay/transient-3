local Entity    = {}
Entity.__index  = Entity

function Entity.new()
    return setmetatable({}, Entity)
end

return Entity