local function rect(size, pos, line_width, color)
    -- local pos, size = unpack(dim)

    if color then
        love.graphics.setColor(unpack(color))
    end

    love.graphics.setLineWidth(line_width)
    love.graphics.rectangle("line", pos.x, pos.y, size.x, size.y)
end

return rect