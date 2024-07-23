---@meta
---@module 'love.graphics'

--- Provides an interface to render 2D graphics.
---@class love.graphics
love.graphics = {}

--- Sets the active Canvas.
---@param canvas love.graphics.Canvas The new active Canvas.
function love.graphics.setCanvas(canvas) end

--- Gets the active Canvas.
---@return love.graphics.Canvas canvas The active Canvas.
function love.graphics.getCanvas() end

--- Sets the current color.
---@param r number The red component (0-255).
---@param g number The green component (0-255).
---@param b number The blue component (0-255).
---@param a number The alpha component (0-255).
function love.graphics.setColor(r, g, b, a) end

--- Gets the current color.
---@return number r The red component (0-255).
---@return number g The green component (0-255).
---@return number b The blue component (0-255).
---@return number a The alpha component (0-255).
function love.graphics.getColor() end

--- Draws a point.
---@param x number The x-coordinate.
---@param y number The y-coordinate.
function love.graphics.points(x, y) end

--- Draws a line.
---@param x1 number The x-coordinate of the first point.
---@param y1 number The y-coordinate of the first point.
---@param x2 number The x-coordinate of the second point.
---@param y2 number The y-coordinate of the second point.
function love.graphics.line(x1, y1, x2, y2) end

--- Draws a rectangle.
---@param mode love.graphics.DrawMode The mode to draw the rectangle in.
---@param x number The x-coordinate of the top-left corner.
---@param y number The y-coordinate of the top-left corner.
---@param width number The width of the rectangle.
---@param height number The height of the rectangle.
function love.graphics.rectangle(mode, x, y, width, height) end

--- Draws a circle.
---@param mode love.graphics.DrawMode The mode to draw the circle in.
---@param x number The x-coordinate of the center.
---@param y number The y-coordinate of the center.
---@param radius number The radius of the circle.
function love.graphics.circle(mode, x, y, radius) end

--- Draws an ellipse.
---@param mode love.graphics.DrawMode The mode to draw the ellipse in.
---@param x number The x-coordinate of the center.
---@param y number The y-coordinate of the center.
---@param radiusx number The radius along the x-axis.
---@param radiusy number The radius along the y-axis.
function love.graphics.ellipse(mode, x, y, radiusx, radiusy) end

--- Draws an arc.
---@param mode love.graphics.DrawMode The mode to draw the arc in.
---@param x number The x-coordinate of the center.
---@param y number The y-coordinate of the center.
---@param radius number The radius of the arc.
---@param angle1 number The starting angle.
---@param angle2 number The ending angle.
function love.graphics.arc(mode, x, y, radius, angle1, angle2) end

--- Draws a polygon.
---@param mode love.graphics.DrawMode The mode to draw the polygon in.
---@param ... number The vertices of the polygon.
function love.graphics.polygon(mode, ...) end

--- Draws a text.
---@param text love.graphics.Text The text object to draw.
---@param x number The x-coordinate.
---@param y number The y-coordinate.
function love.graphics.draw(text, x, y) end

--- Sets the background color.
---@param r number The red component (0-255).
---@param g number The green component (0-255).
---@param b number The blue component (0-255).
---@param a number The alpha component (0-255).
function love.graphics.setBackgroundColor(r, g, b, a) end

--- Gets the background color.
---@return number r The red component (0-255).
---@return number g The green component (0-255).
---@return number b The blue component (0-255).
---@return number a The alpha component (0-255).
function love.graphics.getBackgroundColor() end

--- Clears the screen.
---@param r number The red component (0-255).
---@param g number The green component (0-255).
---@param b number The blue component (0-255).
---@param a number The alpha component (0-255).
function love.graphics.clear(r, g, b, a) end

--- Presents the rendered frame.
function love.graphics.present() end

--- Translates the coordinate system.
---@param dx number The translation along the x-axis.
---@param dy number The translation along the y-axis.
function love.graphics.translate(dx, dy) end

--- Rotates the coordinate system.
---@param angle number The rotation angle.
function love.graphics.rotate(angle) end

--- Scales the coordinate system.
---@param sx number The scaling factor along the x-axis.
---@param sy number The scaling factor along the y-axis.
function love.graphics.scale(sx, sy) end

--- Resets the current transformations.
function love.graphics.origin() end

--- Applies a transformation matrix.
---@param matrix love.math.Transform The transformation matrix.
function love.graphics.applyTransform(matrix) end

--- Pushes the current coordinate system transformation onto the transformation stack.
---@param stackType love.graphics.StackType The type of stack operation to perform.
function love.graphics.push(stackType) end

--- Pops the top coordinate system transformation from the transformation stack.
---@param stackType love.graphics.StackType The type of stack operation to perform.
function love.graphics.pop(stackType) end

--- Sets the scissor rectangle.
---@param x number The x-coordinate of the top-left corner of the scissor rectangle.
---@param y number The y-coordinate of the top-left corner of the scissor rectangle.
---@param width number The width of the scissor rectangle.
---@param height number The height of the scissor rectangle.
function love.graphics.setScissor(x, y, width, height) end

--- Gets the current scissor rectangle.
---@return number x The x-coordinate of the top-left corner of the scissor rectangle.
---@return number y The y-coordinate of the top-left corner of the scissor rectangle.
---@return number width The width of the scissor rectangle.
---@return number height The height of the scissor rectangle.
function love.graphics.getScissor() end

--- Creates a new Font.
---@param filename string The filename of the font file.
---@param size number The size of the font.
---@return love.graphics.Font font The new Font.
function love.graphics.newFont(filename, size) end

--- Creates a new Image.
---@param filename string The filename of the image file.
---@return love.graphics.Image image The new Image.
function love.graphics.newImage(filename) end

--- Creates a new Canvas.
---@param width number The width of the Canvas.
---@param height number The height of the Canvas.
---@return love.graphics.Canvas canvas The new Canvas.
function love.graphics.newCanvas(width, height) end

--- Creates a new Quad.
---@param x number The x-coordinate of the top-left corner of the quad.
---@param y number The y-coordinate of the top-left corner of the quad.
---@param width number The width of the quad.
---@param height number The height of the quad.
---@param sw number The width of the texture.
---@param sh number The height of the texture.
---@return love.graphics.Quad quad The new Quad.
function love.graphics.newQuad(x, y, width, height, sw, sh) end

--- Creates a new Shader.
---@param code string The shader code.
---@return love.graphics.Shader shader The new Shader.
function love.graphics.newShader(code) end

--- Sets or resets a Shader as the current pixel effect or vertex shaders. All drawing operations until the next love.graphics.setShader will be drawn using the Shader object specified.
---@param shader love.graphics.Shader? The new shader.
function love.graphics.setShader(shader) end

--- Gets the current Shader. Returns nil if none is set.
---@return love.graphics.Shader? shader The currently active Shader, or nil if none is set.
function love.graphics.getShader() end

--- Creates a new Text.
---@param font love.graphics.Font The Font object to use.
---@param text string The initial text.
---@return love.graphics.Text text The new Text.
function love.graphics.newText(font, text) end

--- Gets the width in pixels of the window.
---@return number width
function love.graphics.getWidth() end

--- Gets the height in pixels of the window.
---@return number height
function love.graphics.getHeight() end

---@class love.graphics.Canvas
local Canvas = {}

--- Gets the width of the Canvas.
---@return number width The width of the Canvas.
function Canvas:getWidth() end

--- Gets the height of the Canvas.
---@return number height The height of the Canvas.
function Canvas:getHeight() end

--- Gets the dimensions of the Canvas.
---@return number width The width of the Canvas.
---@return number height The height of the Canvas.
function Canvas:getDimensions() end

--- Sets the filter mode for the Canvas.
---@param min love.graphics.FilterMode The filter mode used when scaling the canvas down.
---@param mag love.graphics.FilterMode The filter mode used when scaling the canvas up.
function Canvas:setFilter(min, mag) end

--- Gets the filter mode for the Canvas.
---@return love.graphics.FilterMode min The filter mode used when scaling the canvas down.
---@return love.graphics.FilterMode mag The filter mode used when scaling the canvas up.
function Canvas:getFilter() end

--- Generates a new Image from the contents of the Canvas.
---@return love.graphics.Image image The new Image.
function Canvas:newImageData() end

---@class love.graphics.Font
local Font = {}

--- Sets the filter mode for the Font.
---@param min love.graphics.FilterMode The filter mode used when scaling the font down.
---@param mag love.graphics.FilterMode The filter mode used when scaling the font up.
function Font:setFilter(min, mag) end

--- Gets the filter mode for the Font.
---@return love.graphics.FilterMode min The filter mode used when scaling the font down.
---@return love.graphics.FilterMode mag The filter mode used when scaling the font up.
function Font:getFilter() end

--- Gets the width of the specified text.
---@param text string The text.
---@return number width The width of the text.
function Font:getWidth(text) end

--- Gets the height of the Font.
---@return number height The height of the Font.
function Font:getHeight() end

--- Gets the ascent of the Font.
---@return number ascent The ascent of the Font.
function Font:getAscent() end

--- Gets the descent of the Font.
---@return number descent The descent of the Font.
function Font:getDescent() end

--- Gets the baseline of the Font.
---@return number baseline The baseline of the Font.
function Font:getBaseline() end

--- Gets the line height of the Font.
---@return number lineheight The line height of the Font.
function Font:getLineHeight() end

--- Sets the line height of the Font.
---@param height number The new line height.
function Font:setLineHeight(height) end

--- Gets the DPI scale factor.
---@return number scale The DPI scale factor.
function Font:getDPIScale() end

---@class love.graphics.Image
local Image = {}

--- Sets the filter mode for the Image.
---@param min love.graphics.FilterMode The filter mode used when scaling the image down.
---@param mag love.graphics.FilterMode The filter mode used when scaling the image up.
function Image:setFilter(min, mag) end

--- Gets the filter mode for the Image.
---@return love.graphics.FilterMode min The filter mode used when scaling the image down.
---@return love.graphics.FilterMode mag The filter mode used when scaling the image up.
function Image:getFilter() end

--- Gets the width of the Image.
---@return number width The width of the Image.
function Image:getWidth() end

--- Gets the height of the Image.
---@return number height The height of the Image.
function Image:getHeight() end

--- Gets the dimensions of the Image.
---@return number width The width of the Image.
---@return number height The height of the Image.
function Image:getDimensions() end

---@class love.graphics.Quad
local Quad = {}

--- Gets the viewport of the Quad.
---@return number x The x-coordinate of the top-left corner of the Quad.
---@return number y The y-coordinate of the top-left corner of the Quad.
---@return number width The width of the Quad.
---@return number height The height of the Quad.
function Quad:getViewport() end

--- Sets the viewport of the Quad.
---@param x number The x-coordinate of the top-left corner of the Quad.
---@param y number The y-coordinate of the top-left corner of the Quad.
---@param width number The width of the Quad.
---@param height number The height of the Quad.
function Quad:setViewport(x, y, width, height) end

---@class love.graphics.Shader
local Shader = {}

--- Sends a value to the Shader.
---@param name string The name of the uniform variable to send the value to.
---@param value any The value to send to the uniform variable.
function Shader:send(name, value) end

--- Gets whether the Shader has a uniform variable with the specified name.
---@param name string The name of the uniform variable.
---@return boolean has Whether the Shader has a uniform variable with the specified name.
function Shader:hasUniform(name) end

--- Gets the names of the active uniforms in the Shader.
---@return table names A table containing the names of the active uniforms.
function Shader:getUniformNames() end

---@class love.graphics.Text
local Text = {}

--- Adds text to the Text object.
---@param text string The text to add.
function Text:add(text) end

--- Sets the text of the Text object.
---@param text string The new text.
function Text:set(text) end

--- Clears the text of the Text object.
function Text:clear() end

--- Gets the width of the Text object.
---@return number width The width of the Text object.
function Text:getWidth() end

--- Gets the height of the Text object.
---@return number height The height of the Text object.
function Text:getHeight() end

---@alias love.graphics.DrawMode string
--- The mode to draw an object in.
love.graphics.DrawMode = {
    --- Draw the outline of the shape.
    "line",
    --- Draw the shape filled in.
    "fill",
}

---@alias love.graphics.FilterMode string
--- The filter mode used when scaling an image.
love.graphics.FilterMode = {
    --- Linear filtering.
    "linear",
    --- Nearest-neighbor filtering.
    "nearest",
}

---@alias love.graphics.StackType string
--- The type of stack operation to perform.
love.graphics.StackType = {
    --- Transform stack.
    "transform",
    --- All stack.
    "all",
}

return love.graphics
