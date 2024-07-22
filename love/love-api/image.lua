---@meta
---@module 'love.image'

--- Provides an interface to decode and encode images.
---@class love.image
love.image = {}

--- Creates a new CompressedImageData object.
---@param filename string The filename of the compressed image file.
---@return love.image.CompressedImageData compressedImageData The new CompressedImageData object.
function love.image.newCompressedData(filename) end

--- Creates a new ImageData object.
---@param width number The width of the image.
---@param height number The height of the image.
---@return love.image.ImageData imageData The new ImageData object.
function love.image.newImageData(width, height) end

--- Encodes the ImageData or CompressedImageData object to a specific image format.
---@param data love.image.ImageData The image data to encode.
---@param format love.image.ImageFormat The format to encode the image data to.
---@return string encodedData The encoded image data.
function love.image.encode(data, format) end

--- Reads the header of an image file and retrieves basic information about the image.
---@param filename string The filename of the image file.
---@return love.image.ImageInfo info The image information.
function love.image.getInfo(filename) end

---@class love.image.CompressedImageData
local CompressedImageData = {}

--- Gets the width of the CompressedImageData.
---@return number width The width of the CompressedImageData.
function CompressedImageData:getWidth() end

--- Gets the height of the CompressedImageData.
---@return number height The height of the CompressedImageData.
function CompressedImageData:getHeight() end

---@class love.image.ImageData
local ImageData = {}

--- Gets the width of the ImageData.
---@return number width The width of the ImageData.
function ImageData:getWidth() end

--- Gets the height of the ImageData.
---@return number height The height of the ImageData.
function ImageData:getHeight() end

--- Gets the pixel color at the specified position.
---@param x number The x-coordinate.
---@param y number The y-coordinate.
---@return number r The red component (0-255).
---@return number g The green component (0-255).
---@return number b The blue component (0-255).
---@return number a The alpha component (0-255).
function ImageData:getPixel(x, y) end

--- Sets the pixel color at the specified position.
---@param x number The x-coordinate.
---@param y number The y-coordinate.
---@param r number The red component (0-255).
---@param g number The green component (0-255).
---@param b number The blue component (0-255).
---@param a number The alpha component (0-255).
function ImageData:setPixel(x, y, r, g, b, a) end

--- Encodes the ImageData object to a specific image format.
---@param format love.image.ImageFormat The format to encode the image data to.
---@return string encodedData The encoded image data.
function ImageData:encode(format) end

---@class love.image.ImageInfo
local ImageInfo = {}

--- Gets the width of the image.
---@return number width The width of the image.
function ImageInfo:getWidth() end

--- Gets the height of the image.
---@return number height The height of the image.
function ImageInfo:getHeight() end

--- Gets the format of the image.
---@return love.image.ImageFormat format The format of the image.
function ImageInfo:getFormat() end

---@alias love.image.ImageFormat string
--- The format to encode the image data to.
love.image.ImageFormat = {
    --- PNG format.
    "png",
    --- JPEG format.
    "jpeg",
    --- TGA format.
    "tga",
    --- BMP format.
    "bmp",
}

return love.image
