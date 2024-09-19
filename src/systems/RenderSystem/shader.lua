local wf = require("workflower")

local shader_registry = {}
local SHADER_DIR = "src/shader/"

local function get_file(params)
    local filename = SHADER_DIR .. params.name .. ".glsl"
    return 'read', params.name, filename, params
end

local function read_shader_file(shader_id, filename, params)
    local file_content, io_err_or_size = love.filesystem.read(filename)
    print("file_content", file_content, "file_size:", io_err_or_size)
    return 'compile', shader_id, file_content
end

local function load_shader(shader_id, shader_code, params)
    shader_registry[shader_id] = love.graphics.newShader(shader_code)
    return nil, shader_id, params
end

local createShader = wf({
    'extract_params',
    {'extract_params', 'read', 'compile'},
    extract_params = get_file,
    read = read_shader_file,
    compile = load_shader
})

local function fetch_shader(shader_id, params)
    if not shader_registry[shader_id] then
        createShader(params)
    end
    return 'apply', shader_registry[shader_id], params
end

local function apply_shader(shaderObject, ...)
    love.graphics.setShader(shaderObject)
    return ...
end

local applyShader = wf({
    'fetch',
    fetch = fetch_shader,
    apply = apply_shader
})

return {
    apply = applyShader
}