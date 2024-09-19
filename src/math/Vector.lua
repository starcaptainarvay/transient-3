local Vector = {}

local VECTOR_TYPE_SYMBOL = 'Transient.Vector'

function Vector.new(x, y)
    return setmetatable({
        type = VECTOR_TYPE_SYMBOL,
        x = x,
        y = y
    }, Vector)
end

-- vector addition:
function Vector.__add(a, b)
    return Vector.new(a.x + b.x, a.y + b.y)
end

-- vector subtraction:
function Vector.__sub(a, b)
    return Vector.new(a.x - b.x, a.y - b.y)
end

-- multiplication of a vector by a scalar:
function Vector.__mul(a, b)
    if type(a) == "number" then
        return Vector.new(b.x * a, b.y * a)
    elseif type(b) == "number" then
        return Vector.new(a.x * b, a.y * b)
    elseif type(a) == "table" and type(b) == "table" and a.type == VECTOR_TYPE_SYMBOL and b.type == VECTOR_TYPE_SYMBOL then
        return Vector.new(a.x * b.x, a.y * b.y)
    else
        error("Can only multiply vector by scalar.")
    end
end

-- dividing a vector by a scalar:
function Vector.__div(a, b)
    if type(b) == "number" then
        return Vector.new(a.x / b, a.y / b)
    else
        error("Invalid argument types for vector division.")
    end
end

-- vector equivalence comparison:
function Vector.__eq(a, b)
    return a.x == b.x and a.y == b.y
end

-- vector not equivalence comparison:
function Vector.__ne(a, b)
    return not Vector.__eq(a, b)
end

-- unary negation operator:
function Vector.__unm(a)
    return Vector.new(-a.x, -a.y)
end

-- vector < comparison:
function Vector.__lt(a, b)
    return a.x < b.x and a.y < b.y
end

-- vector <= comparison:
function Vector.__le(a, b)
    return a.x <= b.x and a.y <= b.y
end

-- vector value string output:
function Vector.__tostring(v)
    return "(" .. v.x .. ", " .. v.y .. ")"
end

return Vector
