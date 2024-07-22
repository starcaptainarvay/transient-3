---@meta
---@module 'love.font'

--- Provides an interface to load and use fonts.
---@class love.font
love.font = {}

--- Creates a new Rasterizer.
---@param filename string The filename of the font file.
---@param size number The size of the font.
---@return love.font.Rasterizer rasterizer The new Rasterizer.
function love.font.newRasterizer(filename, size) end

--- Creates a new TrueType Font.
---@param filename string The filename of the TrueType font file.
---@param size number The size of the font.
---@return love.font.Font font The new TrueType Font.
function love.font.newTrueTypeFont(filename, size) end

--- Creates a new BMFont.
---@param filename string The filename of the BMFont file.
---@param imagefilename string The filename of the image file containing the font's glyphs.
---@return love.font.Font font The new BMFont.
function love.font.newBMFont(filename, imagefilename) end

--- Gets the DPI scale factor.
---@return number scale The DPI scale factor.
function love.font.getDPIScale() end

---@class love.font.Rasterizer
local Rasterizer = {}

--- Gets the advance of the glyph.
---@param glyph string The glyph.
---@return number advance The advance of the glyph.
function Rasterizer:getAdvance(glyph) end

--- Gets the height of the Rasterizer.
---@return number height The height of the Rasterizer.
function Rasterizer:getHeight() end

--- Gets the descent of the Rasterizer.
---@return number descent The descent of the Rasterizer.
function Rasterizer:getDescent() end

--- Gets the ascent of the Rasterizer.
---@return number ascent The ascent of the Rasterizer.
function Rasterizer:getAscent() end

--- Gets the bounding box of the glyph.
---@param glyph string The glyph.
---@return number x0 The left coordinate of the bounding box.
---@return number y0 The top coordinate of the bounding box.
---@return number x1 The right coordinate of the bounding box.
---@return number y1 The bottom coordinate of the bounding box.
function Rasterizer:getBoundingBox(glyph) end

--- Gets the kerning between two glyphs.
---@param left string The left glyph.
---@param right string The right glyph.
---@return number kerning The kerning between the glyphs.
function Rasterizer:getKerning(left, right) end

---@class love.font.Font
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

return love.font
