local function point(size, pos, point_size)
    love.graphics.setPointSize(point_size or size.magnitude)
    love.graphics.points(pos.x, pos.y)
end

return point