---@meta

---@module 'love.filesystem'

--- Provides an interface to the user's filesystem.
---@class love.filesystem
love.filesystem = {}

--- Append data to a file.
---@param filename string The name (and path) of the file.
---@param data string The data to append.
---@param size number How many bytes to write.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function love.filesystem.append(filename, data, size) end

--- Gets the application data directory (could be a subdirectory within the system's application data directory).
---@return string path The path of the application data directory.
function love.filesystem.getAppdataDirectory() end

--- Gets the directory where the executable is located (only on some platforms).
---@return string path The path of the executable directory.
function love.filesystem.getExecutablePath() end

--- Returns a list of filenames and directory names in the specified directory.
---@param dir string The directory.
---@return table items A table with the names of all files and subdirectories in the directory.
function love.filesystem.getDirectoryItems(dir) end

--- Gets the filesystem paths that will be searched when requiring modules with require.
---@return table paths The paths to be searched.
function love.filesystem.getRequirePath() end

--- Returns the size in bytes of the specified file.
---@param filename string The name (and path) of the file.
---@return number size The size in bytes of the file, or nil if it doesn't exist.
function love.filesystem.getSize(filename) end

--- Returns the current working directory.
---@return string cwd The current working directory.
function love.filesystem.getWorkingDirectory() end

--- Returns whether a file or directory exists.
---@param filename string The name (and path) to the file or directory.
---@return boolean exists Whether the file or directory exists.
function love.filesystem.exists(filename) end

--- Returns whether a path is a directory.
---@param path string The path to check.
---@return boolean isdir Whether the path is a directory.
function love.filesystem.isDirectory(path) end

--- Returns whether a path is a file.
---@param path string The path to check.
---@return boolean isfile Whether the path is a file.
function love.filesystem.isFile(path) end

--- Loads a Lua file (but does not run it).
---@param filename string The name (and path) of the file.
---@return function chunk A function containing the compiled Lua code.
---@return string message An error message if the file could not be read.
function love.filesystem.load(filename) end

--- Creates a new directory.
---@param name string The directory name.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function love.filesystem.createDirectory(name) end

--- Mounts a ZIP file or directory into the game's virtual filesystem.
---@param archive string The folder or zip file in the real filesystem to mount.
---@param mountpoint string The new path the archive will be mounted to.
---@param appendToPath boolean Whether the archive will be searched when reading a filepath before or after already-mounted archives. Defaults to false (mounts before others).
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function love.filesystem.mount(archive, mountpoint, appendToPath) end

--- Reads the contents of a file.
---@param filename string The name (and path) of the file.
---@param size number How many bytes to read.
---@return love.filesystem.FileData data The file contents.
function love.filesystem.read(filename, size) end

--- Sets the filesystem paths that will be searched when requiring modules with require.
---@param path string The paths to search.
function love.filesystem.setRequirePath(path) end

--- Unmounts a ZIP file or directory previously mounted with love.filesystem.mount.
---@param archive string The folder or zip file in the real filesystem to unmount.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function love.filesystem.unmount(archive) end

--- Writes data to a file.
---@param filename string The name (and path) of the file.
---@param data string The data to write.
---@param size number How many bytes to write.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function love.filesystem.write(filename, data, size) end

--- Removes a file or directory.
---@param name string The file or directory to remove.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function love.filesystem.remove(name) end

--- Sets the identity of the game, which is used as the name of the save directory.
---@param name string The identity to set.
function love.filesystem.setIdentity(name) end

--- Gets the identity of the game, which is used as the name of the save directory.
---@return string name The identity.
function love.filesystem.getIdentity() end

---@class love.filesystem.File
local File = {}

--- Closes a file.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function File:close() end

--- Flushes any buffered written data to the file.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function File:flush() end

--- Returns the size in bytes of the file.
---@return number size The size in bytes of the file.
function File:getSize() end

--- Returns the current file position.
---@return number pos The current position.
function File:tell() end

--- Sets the current file position.
---@param pos number The position to set.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function File:seek(pos) end

--- Reads the specified number of bytes from the file.
---@param size number The number of bytes to read.
---@return string contents The contents read from the file.
---@return number bytesRead The number of bytes actually read.
function File:read(size) end

--- Writes data to the file.
---@param data string The data to write.
---@param size number The number of bytes to write.
---@return boolean success, string message Whether the operation was successful, and an error message if it wasn't.
function File:write(data, size) end

---@alias love.filesystem.FileMode string
--- The mode to open a file in.
love.filesystem.FileMode = {
    --- Read mode.
    "r",
    --- Write mode.
    "w",
    --- Append mode.
    "a",
    --- Read and write mode.
    "rw",
    --- Read and append mode.
    "ra",
}

---@class love.filesystem.FileData
local FileData = {}

--- Gets the filename of the FileData.
---@return string name The filename.
function FileData:getFilename() end

--- Gets the extension of the FileData.
---@return string ext The file extension.
function FileData:getExtension() end

--- Gets the size in bytes of the FileData.
---@return number size The size in bytes.
function FileData:getSize() end

return love.filesystem