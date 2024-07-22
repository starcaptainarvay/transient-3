---@meta
---@module 'love.audio'

---@alias DistanceModel string
--- Different distance attenuation models.
DistanceModel = {
    --- Clamps the distance calculated attenuation between 0 and 1.
    "none",
    --- Attenuates distance using an inverse distance model.
    "inverse",
    --- Attenuates distance using a linear distance model.
    "linear",
    --- Attenuates distance using an inverse distance model with clamping.
    "inverseclamped",
    --- Attenuates distance using a linear distance model with clamping.
    "linearclamped",
    --- Attenuates distance using an exponent distance model.
    "exponent",
    --- Attenuates distance using an exponent distance model with clamping.
    "exponentclamped",
}

---@alias EffectType string
--- Different types of audio effects.
EffectType = {
    --- Reverb effect.
    "reverb",
    --- Chorus effect.
    "chorus",
    --- Distortion effect.
    "distortion",
    --- Echo effect.
    "echo",
    --- Flanger effect.
    "flanger",
    --- Compressor effect.
    "compressor",
    --- Equalizer effect.
    "equalizer",
}

---@alias EffectWaveform string
--- Waveform types for effects.
EffectWaveform = {
    --- Sine waveform.
    "sine",
    --- Triangle waveform.
    "triangle",
}

---@alias FilterType string
--- Types of audio filters.
FilterType = {
    --- Low-pass filter.
    "lowpass",
    --- High-pass filter.
    "highpass",
    --- Band-pass filter.
    "bandpass",
}

---@alias SourceType string
--- Types of audio sources.
SourceType = {
    --- Static source.
    "static",
    --- Streaming source.
    "stream",
}

---@alias TimeUnit string
--- Units of time.
TimeUnit = {
    --- Seconds.
    "seconds",
    --- Samples.
    "samples",
}


--- Provides an interface to create noise with the user's speakers.
---@class love.audio
love.audio = {}

--- Gets a list of the names of the currently enabled effects.
---@return table effects The list of the names of the currently enabled effects.
function love.audio.getActiveEffects() end

--- Gets the current number of simultaneously playing sources.
---@return number count The current number of simultaneously playing sources.
function love.audio.getActiveSourceCount() end

--- Returns the distance attenuation model.
---@return DistanceModel model The current distance model. The default is 'inverseclamped'.
function love.audio.getDistanceModel() end

--- Gets the current global scale factor for velocity-based doppler effects.
---@return number scale The current doppler scale factor.
function love.audio.getDopplerScale() end

--- Gets the settings associated with an effect.
---@param name string The name of the effect.
---@return table settings The settings associated with the effect.
function love.audio.getEffect(name) end

--- Gets the maximum number of active effects supported by the system.
---@return number maximum The maximum number of active effects.
function love.audio.getMaxSceneEffects() end

--- Gets the maximum number of active Effects in a single Source object, that the system can support.
---@return number maximum The maximum number of active Effects per Source.
function love.audio.getMaxSourceEffects() end

--- Returns the orientation of the listener.
---@return number fx, number fy, number fz Forward vector of the listener orientation.
---@return number ux, number uy, number uz Up vector of the listener orientation.
function love.audio.getOrientation() end

--- Returns the position of the listener.
---@return number x The X position of the listener.
---@return number y The Y position of the listener.
---@return number z The Z position of the listener.
function love.audio.getPosition() end

--- Gets a list of RecordingDevices on the system.
---@return table devices The list of connected recording devices.
function love.audio.getRecordingDevices() end

--- Returns the velocity of the listener.
---@return number x The X velocity of the listener.
---@return number y The Y velocity of the listener.
---@return number z The Z velocity of the listener.
function love.audio.getVelocity() end

--- Returns the master volume.
---@return number volume The current master volume.
function love.audio.getVolume() end

--- Gets whether audio effects are supported in the system.
---@return boolean supported True if effects are supported, false otherwise.
function love.audio.isEffectsSupported() end

--- Creates a new Source usable for real-time generated sound playback with Source:queue.
---@param samplerate number Number of samples per second when playing.
---@param bitdepth number Bits per sample (8 or 16).
---@param channels number 1 for mono or 2 for stereo.
---@param buffercount number The number of buffers that can be queued up at any given time with Source:queue.
---@return Source source The new Source usable with Source:queue.
function love.audio.newQueueableSource(samplerate, bitdepth, channels, buffercount) end

--- Creates a new Source from a filepath, File, Decoder or SoundData.
---@param filename string The filepath to the audio file.
---@param type SourceType Streaming or static source.
---@return Source source A new Source that can play the specified audio.
function love.audio.newSource(filename, type) end

--- Pauses specific or all currently played Sources.
---@return table Sources A table containing a list of Sources that were paused by this call.
function love.audio.pause() end

--- Pauses the given Sources.
---@param source Source The first Source to pause.
---@vararg Source Additional Sources to pause.
function love.audio.pause(source, ...) end

--- Pauses the given Sources.
---@param sources table A table containing a list of Sources to pause.
function love.audio.pause(sources) end

--- Plays the specified Source.
---@param source Source The Source to play.
function love.audio.play(source) end

--- Starts playing multiple Sources simultaneously.
---@param sources table Table containing a list of Sources to play.
function love.audio.play(sources) end

--- Starts playing multiple Sources simultaneously.
---@param source1 Source The first Source to play.
---@param source2 Source The second Source to play.
---@vararg Source Additional Sources to play.
function love.audio.play(source1, source2, ...) end

--- Sets the distance attenuation model.
---@param model DistanceModel The new distance model.
function love.audio.setDistanceModel(model) end

--- Sets a global scale factor for velocity-based doppler effects.
---@param scale number The new doppler scale factor. The scale must be greater than 0.
function love.audio.setDopplerScale(scale) end

--- Defines an effect that can be applied to a Source.
---@param name string The name of the effect.
---@param settings table The settings to use for this effect.
---@return boolean success Whether the effect was successfully created.
function love.audio.setEffect(name, settings) end

--- Defines an effect that can be applied to a Source.
---@param name string The name of the effect.
---@param enabled boolean If false and the given effect name was previously set, disables the effect.
---@return boolean success Whether the effect was successfully disabled.
function love.audio.setEffect(name, enabled) end

--- Sets whether the system should mix the audio with the system's audio.
---@param mix boolean True to enable mixing, false to disable it.
---@return boolean success True if the change succeeded, false otherwise.
function love.audio.setMixWithSystem(mix) end

--- Sets the orientation of the listener.
---@param fx number Forward vector of the listener orientation.
---@param fy number Forward vector of the listener orientation.
---@param fz number Forward vector of the listener orientation.
---@param ux number Up vector of the listener orientation.
---@param uy number Up vector of the listener orientation.
---@param uz number Up vector of the listener orientation.
function love.audio.setOrientation(fx, fy, fz, ux, uy, uz) end

--- Sets the position of the listener.
---@param x number The x position of the listener.
---@param y number The y position of the listener.
---@param z number The z position of the listener.
function love.audio.setPosition(x, y, z) end

--- Sets the velocity of the listener.
---@param x number The X velocity of the listener.
---@param y number The Y velocity of the listener.
---@param z number The Z velocity of the listener.
function love.audio.setVelocity(x, y, z) end

--- Sets the master volume.
---@param volume number 1.0 is max and 0.0 is off.
function love.audio.setVolume(volume) end

--- Stops currently played sources.
function love.audio.stop() end

--- Simultaneously stops all given Sources.
---@param sources table A table containing a list of Sources to stop.
function love.audio.stop(sources) end

--- Simultaneously stops all given Sources.
---@param source1 Source The first Source to stop.
---@param source2 Source The second Source to stop.
---@vararg Source Additional Sources to stop.
function love.audio.stop(source1, source2, ...) end

--- Stops the specified source.
---@param source Source The source on which to stop the playback.
function love.audio.stop(source) end

--- @class RecordingDevice
local RecordingDevice = {}

--- Starts recording audio using this device.
---@param samplecount number The maximum number of samples to store in an internal ring buffer when recording. A default value of 8192 is used if no value is specified.
function RecordingDevice:start(samplecount) end

--- Stops recording audio using this device.
function RecordingDevice:stop() end

--- Gets the number of bits per sample in the recorded audio.
---@return number bits The number of bits per sample.
function RecordingDevice:getBitDepth() end

--- Gets the number of channels in the recorded audio.
---@return number channels The number of channels.
function RecordingDevice:getChannelCount() end

--- Gets the number of samples per second of the recorded audio.
---@return number rate The number of samples per second.
function RecordingDevice:getSampleRate() end

--- Gets the name of the recording device.
---@return string name The name of the recording device.
function RecordingDevice:getName() end

--- Returns whether the device is currently recording.
---@return boolean recording True if the device is currently recording, false otherwise.
function RecordingDevice:isRecording() end

--- Gets the duration of the recorded audio data.
---@return number duration The duration of the recorded audio data in seconds.
function RecordingDevice:getDuration() end

--- Gets the size of the internal ring buffer used for recording.
---@return number size The size of the internal ring buffer in bytes.
function RecordingDevice:getBufferSize() end

--- Sets the size of the internal ring buffer used for recording.
---@param size number The size of the internal ring buffer in bytes.
function RecordingDevice:setBufferSize(size) end

--- @class Source
local Source = {}

--- Creates an identical copy of the Source in the stopped state.
---@return Source source The new identical copy of this Source.
function Source:clone() end

--- Gets a list of the Source's active effect names.
---@return table effects A list of the source's active effect names.
function Source:getActiveEffects() end

--- Gets the amount of air absorption applied to the Source.
---@return number amount The amount of air absorption applied to the Source.
function Source:getAirAbsorption() end

--- Gets the reference and maximum attenuation distances of the Source.
---@return number ref The current reference attenuation distance.
---@return number max The current maximum attenuation distance.
function Source:getAttenuationDistances() end

return love.audio