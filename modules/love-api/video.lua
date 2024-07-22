---@meta
---@module 'love.video'

--- Provides an interface to decode and play videos.
---@class love.video
love.video = {}

--- Creates a new Video object.
---@param filename string The filename of the video file.
---@param decoder love.video.VideoDecoder The decoder to use for the video file.
---@return love.video.Video video The new Video object.
function love.video.newVideo(filename, decoder) end

--- Creates a new VideoStream object.
---@param filename string The filename of the video file.
---@param decoder love.video.VideoDecoder The decoder to use for the video file.
---@return love.video.VideoStream videoStream The new VideoStream object.
function love.video.newVideoStream(filename, decoder) end

---@class love.video.Video
local Video = {}

--- Plays the video.
function Video:play() end

--- Pauses the video.
function Video:pause() end

--- Stops the video.
function Video:stop() end

--- Rewinds the video.
function Video:rewind() end

--- Seeks to a specific position in the video.
---@param position number The position to seek to, in seconds.
function Video:seek(position) end

--- Gets the current position of the video.
---@return number position The current position of the video, in seconds.
function Video:tell() end

--- Sets the volume of the video's audio.
---@param volume number The volume of the video's audio.
function Video:setVolume(volume) end

--- Gets the volume of the video's audio.
---@return number volume The volume of the video's audio.
function Video:getVolume() end

--- Sets whether the video should loop.
---@param loop boolean Whether the video should loop.
function Video:setLooping(loop) end

--- Gets whether the video is looping.
---@return boolean looping Whether the video is looping.
function Video:isLooping() end

--- Gets whether the video is playing.
---@return boolean playing Whether the video is playing.
function Video:isPlaying() end

---@class love.video.VideoStream
local VideoStream = {}

--- Decodes the next frame of the video stream.
---@return love.graphics.Image frame The next frame of the video stream.
function VideoStream:decode() end

--- Gets the width of the video stream.
---@return number width The width of the video stream.
function VideoStream:getWidth() end

--- Gets the height of the video stream.
---@return number height The height of the video stream.
function VideoStream:getHeight() end

---@alias love.video.VideoDecoder string
--- The decoders to use for video files.
love.video.VideoDecoder = {
    --- The default decoder.
    "default",
    --- A custom decoder.
    "custom",
}

return love.video
