---@meta
---@module 'love.sound'

--- Provides an interface to decode sound files.
---@class love.sound
love.sound = {}

--- Creates new SoundData from an existing file, Decoder, or Blob.
---@param filename string The filename of the sound file.
---@return love.sound.SoundData soundData The new SoundData object.
function love.sound.newSoundData(filename) end

--- Creates new SoundData from an existing file, Decoder, or Blob.
---@param blob love.data.Blob The Blob containing the sound file.
---@return love.sound.SoundData soundData The new SoundData object.
function love.sound.newSoundData(blob) end

--- Creates new SoundData from an existing file, Decoder, or Blob.
---@param decoder love.sound.Decoder The Decoder containing the sound file.
---@return love.sound.SoundData soundData The new SoundData object.
function love.sound.newSoundData(decoder) end

--- Creates new SoundData with a specified length, sample rate, bit depth, and channel count.
---@param samples number The total number of samples in the SoundData.
---@param rate number The number of samples per second.
---@param bits number The number of bits per sample (8 or 16).
---@param channels number The number of channels (1 for mono, 2 for stereo).
---@return love.sound.SoundData soundData The new SoundData object.
function love.sound.newSoundData(samples, rate, bits, channels) end

---@class love.sound.SoundData
local SoundData = {}

--- Gets the number of channels in the SoundData.
---@return number channels The number of channels.
function SoundData:getChannelCount() end

--- Gets the duration of the SoundData.
---@return number duration The duration of the SoundData in seconds.
function SoundData:getDuration() end

--- Gets the number of bits per sample.
---@return number bits The number of bits per sample.
function SoundData:getBitDepth() end

--- Gets the number of samples per second.
---@return number rate The number of samples per second.
function SoundData:getSampleRate() end

--- Gets the number of frames in the SoundData.
---@return number frames The number of frames.
function SoundData:getFrameCount() end

--- Gets the sample at the specified position.
---@param frame number The frame position.
---@param channel number The channel to get the sample from.
---@return number sample The sample value (-1 to 1).
function SoundData:getSample(frame, channel) end

--- Sets the sample at the specified position.
---@param frame number The frame position.
---@param channel number The channel to set the sample in.
---@param sample number The sample value (-1 to 1).
function SoundData:setSample(frame, channel, sample) end

---@class love.sound.Decoder
local Decoder = {}

--- Gets the number of channels in the Decoder.
---@return number channels The number of channels.
function Decoder:getChannelCount() end

--- Gets the duration of the Decoder.
---@return number duration The duration of the Decoder in seconds.
function Decoder:getDuration() end

--- Gets the number of bits per sample.
---@return number bits The number of bits per sample.
function Decoder:getBitDepth() end

--- Gets the number of samples per second.
---@return number rate The number of samples per second.
function Decoder:getSampleRate() end

--- Gets the total number of frames in the Decoder.
---@return number frames The number of frames.
function Decoder:getFrameCount() end

--- Decodes the next chunk of data.
---@param bytes number The number of bytes to decode.
---@return love.data.Data data The decoded data.
function Decoder:decode(bytes) end

--- Seeks to a specific position.
---@param position number The position to seek to.
---@return boolean success True if successful, false otherwise.
function Decoder:seek(position) end

--- Gets the current position.
---@return number position The current position.
function Decoder:tell() end

return love.sound
