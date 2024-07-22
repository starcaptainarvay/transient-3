---@meta
---@module 'love.math'

--- Provides mathematical functions and data types.
---@class love.math
love.math = {}

--- Compresses a string or data using a specific compression algorithm.
---@param data string|love.data.Data The raw data to compress.
---@param format love.math.CompressedDataFormat The compression format to use.
---@param level number The compression level to use.
---@return love.data.CompressedData compressedData The compressed data.
function love.math.compress(data, format, level) end

--- Decompresses a previously compressed string or data.
---@param data string|love.data.CompressedData The data to decompress.
---@param format love.math.CompressedDataFormat The compression format to use.
---@return love.data.Data decompressedData The decompressed data.
function love.math.decompress(data, format) end

--- Creates a new BezierCurve object.
---@param points table A table of control points.
---@return love.math.BezierCurve curve The new BezierCurve object.
function love.math.newBezierCurve(points) end

--- Creates a new RandomGenerator object.
---@param seed number A seed number.
---@return love.math.RandomGenerator randomGenerator The new RandomGenerator object.
function love.math.newRandomGenerator(seed) end

--- Creates a new Transform object.
---@return love.math.Transform transform The new Transform object.
function love.math.newTransform() end

--- Creates a new 4D vector.
---@param x number The x component.
---@param y number The y component.
---@param z number The z component.
---@param w number The w component.
---@return love.math.Vector4 vector The new 4D vector.
function love.math.newVector4(x, y, z, w) end

--- Creates a new Vec3 object.
---@param x number The x component.
---@param y number The y component.
---@param z number The z component.
---@return love.math.Vec3 vector The new Vec3 object.
function love.math.newVec3(x, y, z) end

--- Creates a new Vec2 object.
---@param x number The x component.
---@param y number The y component.
---@return love.math.Vec2 vector The new Vec2 object.
function love.math.newVec2(x, y) end

--- Gets the value of the number π.
---@return number pi The value of π.
function love.math.getPi() end

---@class love.math.BezierCurve
local BezierCurve = {}

--- Evaluates the Bezier curve at the specified parameter t.
---@param t number The parameter to evaluate the curve at.
---@return number x, number y The coordinates of the point on the curve.
function BezierCurve:evaluate(t) end

--- Gets the control points of the Bezier curve.
---@return table points A table of control points.
function BezierCurve:getControlPoints() end

--- Gets the degree of the Bezier curve.
---@return number degree The degree of the curve.
function BezierCurve:getDegree() end

--- Sets the control points of the Bezier curve.
---@param points table A table of control points.
function BezierCurve:setControlPoints(points) end

--- Translates the Bezier curve.
---@param dx number The translation along the x-axis.
---@param dy number The translation along the y-axis.
function BezierCurve:translate(dx, dy) end

---@class love.math.RandomGenerator
local RandomGenerator = {}

--- Gets a random number between min and max.
---@param min number The minimum value.
---@param max number The maximum value.
---@return number value The random number.
function RandomGenerator:random(min, max) end

--- Gets a random number between 0 and 1.
---@return number value The random number.
function RandomGenerator:random() end

--- Gets a random integer between min and max.
---@param min number The minimum value.
---@param max number The maximum value.
---@return number value The random integer.
function RandomGenerator:randomInt(min, max) end

--- Sets the seed of the RandomGenerator.
---@param seed number The seed value.
function RandomGenerator:setSeed(seed) end

--- Gets the seed of the RandomGenerator.
---@return number seed The seed value.
function RandomGenerator:getSeed() end

---@class love.math.Transform
local Transform = {}

--- Applies the transformation to the specified coordinates.
---@param x number The x coordinate.
---@param y number The y coordinate.
---@return number x, number y The transformed coordinates.
function Transform:apply(x, y) end

--- Inverts the transformation.
---@return love.math.Transform transform The inverted transformation.
function Transform:invert() end

--- Gets the matrix components of the transformation.
---@return number a, number b, number c, number d, number tx, number ty The matrix components.
function Transform:getMatrix() end

--- Sets the matrix components of the transformation.
---@param a number The a component.
---@param b number The b component.
---@param c number The c component.
---@param d number The d component.
---@param tx number The tx component.
---@param ty number The ty component.
function Transform:setMatrix(a, b, c, d, tx, ty) end

---@class love.math.Vector4
local Vector4 = {}

--- Gets the components of the vector.
---@return number x, number y, number z, number w The components of the vector.
function Vector4:get() end

--- Sets the components of the vector.
---@param x number The x component.
---@param y number The y component.
---@param z number The z component.
---@param w number The w component.
function Vector4:set(x, y, z, w) end

--- Adds another vector to this vector.
---@param v love.math.Vector4 The other vector.
---@return love.math.Vector4 result The result of the addition.
function Vector4:add(v) end

--- Subtracts another vector from this vector.
---@param v love.math.Vector4 The other vector.
---@return love.math.Vector4 result The result of the subtraction.
function Vector4:subtract(v) end

--- Multiplies this vector by a scalar.
---@param s number The scalar.
---@return love.math.Vector4 result The result of the multiplication.
function Vector4:multiply(s) end

--- Divides this vector by a scalar.
---@param s number The scalar.
---@return love.math.Vector4 result The result of the division.
function Vector4:divide(s) end

--- Gets the length of the vector.
---@return number length The length of the vector.
function Vector4:length() end

--- Normalizes the vector.
---@return love.math.Vector4 result The normalized vector.
function Vector4:normalize() end

---@class love.math.Vec3
local Vec3 = {}

--- Gets the components of the vector.
---@return number x, number y, number z The components of the vector.
function Vec3:get() end

--- Sets the components of the vector.
---@param x number The x component.
---@param y number The y component.
---@param z number The z component.
function Vec3:set(x, y, z) end

--- Adds another vector to this vector.
---@param v love.math.Vec3 The other vector.
---@return love.math.Vec3 result The result of the addition.
function Vec3:add(v) end

--- Subtracts another vector from this vector.
---@param v love.math.Vec3 The other vector.
---@return love.math.Vec3 result The result of the subtraction.
function Vec3:subtract(v) end

--- Multiplies this vector by a scalar.
---@param s number The scalar.
---@return love.math.Vec3 result The result of the multiplication.
function Vec3:multiply(s) end

--- Divides this vector by a scalar.
---@param s number The scalar.
---@return love.math.Vec3 result The result of the division.
function Vec3:divide(s) end

--- Gets the length of the vector.
---@return number length The length of the vector.
function Vec3:length() end

--- Normalizes the vector.
---@return love.math.Vec3 result The normalized vector.
function Vec3:normalize() end

---@class love.math.Vec2
local Vec2 = {}

--- Gets the components of the vector.
---@return number x, number y The components of the vector.
function Vec2:get() end

--- Sets the components of the vector.
---@param x number The x component.
---@param y number The y component.
function Vec2:set(x, y) end

--- Adds another vector to this vector.
---@param v love.math.Vec2 The other vector.
---@return love.math.Vec2 result The result of the addition.
function Vec2:add(v) end

--- Subtracts another vector from this vector.
---@param v love.math.Vec2 The other vector.
---@return love.math.Vec2 result The result of the subtraction.
function Vec2:subtract(v) end

--- Multiplies this vector by a scalar.
---@param s number The scalar.
---@return love.math.Vec2 result The result of the multiplication.
function Vec2:multiply(s) end

--- Divides this vector by a scalar.
---@param s number The scalar.
---@return love.math.Vec2 result The result of the division.
function Vec2:divide(s) end

--- Gets the length of the vector.
---@return number length The length of the vector.
function Vec2:length() end

--- Normalizes the vector.
---@return love.math.Vec2 result The normalized vector.
function Vec2:normalize() end

---@alias love.math.CompressedDataFormat string
--- The format to compress data with.
love.math.CompressedDataFormat = {
    --- Zlib compressed data format.
    "zlib",
    --- Gzip compressed data format.
    "gzip",
    --- LZMA compressed data format.
    "lzma",
    --- Zstandard compressed data format.
    "zstd",
}

return love.math
