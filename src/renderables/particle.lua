local function particle(size, position, drawable, color, ...)
    local blendMode = love.graphics.getBlendMode()

    if color then
        love.graphics.setColor(color)
    end
    -- love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.setBlendMode("screen", "premultiplied")
    love.graphics.draw(drawable, position.x, position.y)
    love.graphics.setBlendMode(blendMode)
end

return particle