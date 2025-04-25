local function rect(size, pos, line_width, line_color, fill_color)
    -- local pos, size = unpack(dim)

    if fill_color then
        love.graphics.setColor(unpack(fill_color))
    end

    love.graphics.rectangle("fill", pos.x, pos.y, size.x, size.y)

    if line_width then
        if line_color then
            love.graphics.setColor(unpack(line_color))
        end

        love.graphics.setLineWidth(line_width)
        love.graphics.rectangle("line", pos.x, pos.y, size.x, size.y)
    end
end

return rect