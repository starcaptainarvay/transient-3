local function rect(line_width, dim)
    local pos, size = unpack(dim)

    love.graphics.setLineWidth(line_width)
    love.graphics.rectangle("line", pos.x, pos.y, size.x, size.y)
end

return rect