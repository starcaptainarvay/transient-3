---@meta

---@module 'love.data'

--- Provides functionality for creating and transforming data.
---@class love.data
love.data = {}

--- Computes the message digest of a string using the specified algorithm.
---@param hashFunction love.data.HashFunction The hash algorithm to use.
---@param string string The input string.
---@param seed number Optional seed value used by certain algorithms.
---@return string hash The resulting message digest string.
function love.data.hash(hashFunction, string, seed) end

--- Decodes a Data object or a byte slice of it into a string using the specified format.
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param data love.data.Data The encoded data to decode.
---@param offset number The offset from the beginning of the data to start decoding.
---@param size number The number of bytes to decode, or nil to decode until the end of the data.
---@param format love.data.DataFormat The format of the encoded data.
---@return string decodedData The decoded data.
function love.data.decode(containerType, data, offset, size, format) end

--- Encodes a string or Data object into a different format.
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param data string|love.data.Data The data to encode.
---@param format love.data.DataFormat The format to encode the data into.
---@return string|love.data.Data encodedData The encoded data.
function love.data.encode(containerType, data, format) end

--- Creates a new Data object containing a copy of the specified byte slice of an existing Data object or string.
---@param data string|love.data.Data The source data.
---@param offset number The offset from the beginning of the data to copy.
---@param size number The number of bytes to copy, or nil to copy until the end of the data.
---@return love.data.Data copiedData The copied Data object.
function love.data.newByteData(data, offset, size) end

--- Creates a new Data object containing the specified string.
---@param string string The string to create the Data object from.
---@return love.data.Data data The new Data object.
function love.data.newByteData(string) end

--- Compresses a string or Data object using the specified algorithm.
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param data string|love.data.Data The data to compress.
---@param format love.data.CompressedDataFormat The compression algorithm to use.
---@param level number The compression level to use (0-9 for zlib, 1-22 for zstd).
---@return string|love.data.CompressedData compressedData The compressed data.
function love.data.compress(containerType, data, format, level) end

--- Decompresses a string or Data object.
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param data string|love.data.CompressedData The data to decompress.
---@param format love.data.CompressedDataFormat The compression algorithm used to compress the data.
---@return string|love.data.Data decompressedData The decompressed data.
function love.data.decompress(containerType, data, format) end

--- Creates a new Data object containing the serialized version of the specified Lua value(s).
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param value any The Lua value(s) to serialize.
---@return string|love.data.Data serializedData The serialized data.
function love.data.pack(containerType, value) end

--- Deserializes a string or Data object into Lua value(s).
---@param format love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param data string|love.data.Data The encoded data to deserialize.
---@param size number The number of bytes to decode, or nil to decode until the end of the data.
---@return any deserializedValue The deserialized Lua value(s).
function love.data.unpack(format, data, size) end

--- Creates a new Data object with the specified size, filled with zeroes.
---@param size number The size of the new Data object, in bytes.
---@return love.data.Data data The new Data object.
function love.data.newData(size) end

--- Compresses a string using the specified compression algorithm.
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param string string The string to compress.
---@param format love.data.CompressedDataFormat The compression algorithm to use.
---@param level number The compression level to use (0-9 for zlib, 1-22 for zstd).
---@return string|love.data.CompressedData compressedData The compressed data.
function love.data.compress(containerType, string, format, level) end

--- Decompresses a string using the specified compression algorithm.
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param string string The string to decompress.
---@param format love.data.CompressedDataFormat The compression algorithm used to compress the data.
---@return string|love.data.Data decompressedData The decompressed data.
function love.data.decompress(containerType, string, format) end

--- Computes the Base64-encoded version of a string or Data object.
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param data string|love.data.Data The data to encode.
---@return string encodedData The Base64-encoded data.
function love.data.encodeBase64(containerType, data) end

--- Decodes a Base64-encoded string or Data object.
---@param containerType love.data.ContainerType The type of the encoded data (e.g., "data" for Data objects, "string" for Lua strings).
---@param data string|love.data.Data The Base64-encoded data to decode.
---@return string|love.data.Data decodedData The decoded data.
function love.data.decodeBase64(containerType, data) end

---@alias love.data.CompressedDataFormat string
--- Different formats for compressed data.
love.data.CompressedDataFormat = {
    --- Zlib compressed data format.
    "zlib",
    --- Gzip compressed data format.
    "gzip",
    --- LZMA compressed data format.
    "lzma",
    --- Zstandard compressed data format.
    "zstd",
}

---@alias love.data.ContainerType string
--- Different container types for encoded data.
love.data.ContainerType = {
    --- A Lua string.
    "string",
    --- A love.data.Data object.
    "data",
}

---@alias love.data.DataFormat string
--- Different formats for encoded data.
love.data.DataFormat = {
    --- Base64 data format.
    "base64",
}

---@alias love.data.HashFunction string
--- Different hash algorithms.
love.data.HashFunction = {
    --- MD5 hash algorithm.
    "md5",
    --- SHA1 hash algorithm.
    "sha1",
    --- SHA224 hash algorithm.
    "sha224",
    --- SHA256 hash algorithm.
    "sha256",
    --- SHA384 hash algorithm.
    "sha384",
    --- SHA512 hash algorithm.
    "sha512",
    --- MurmurHash2 algorithm.
    "murmurhash2",
    --- MurmurHash3 algorithm.
    "murmurhash3",
}

return love.data