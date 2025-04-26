local function rect(size, pos, line_width, line_color, fill_color)
    -- local pos, size = unpack(dim)

    local blendMode = love.graphics.getBlendMode()
    love.graphics.setBlendMode("lighten", "premultiplied")

    if fill_color then
        love.graphics.setColor(unpack(fill_color))
        love.graphics.rectangle("fill", pos.x, pos.y, size.x, size.y)
    end

    if line_width and line_width ~= 0 then
        if line_color then
            love.graphics.setColor(unpack(line_color))
        end

        love.graphics.setLineWidth(line_width)
        love.graphics.rectangle("line", pos.x, pos.y, size.x, size.y)
    end
    love.graphics.setBlendMode(blendMode)
end

return rect