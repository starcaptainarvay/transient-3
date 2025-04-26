local function particle(size, position, drawable, color, ...)
    if color then
        love.graphics.setColor(color)
    end
    love.graphics.draw(drawable, position.x, position.y)
end

return particle