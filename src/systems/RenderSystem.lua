local wf = require("workflower")
local t3 = require("transient")

local RenderSystem = t3.system("Render")

local renderQueue, renderQueueCell = wf.queue()

function RenderSystem:init(component, entity)
    
end

function RenderSystem:update(component, entity)
    
end

function RenderSystem:updateSystem()
    
end

local shader_registry = {}

local function get_file(params)
    return 'read', params.name, filename, params
end

local function read_shader_file(shader_id, filename, params)
    return 'compile', shader_id, love.filesystem.read(filename)
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
    return nil, shader_registry[shader_id], params
end

local function apply_shader(shader_code, ...)
    love.graphics.setShader()
    return ...
end

return RenderSystem