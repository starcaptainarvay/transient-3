local function particle(size, position, drawable, ...)
    love.graphics.draw(drawable, position.x, position.y)
end

return particle