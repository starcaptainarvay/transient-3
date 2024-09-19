local wf = require("workflower")
local t3 = require("transient")
local Shader = require("systems.rendering.shader")
print("shader loaded")

local vector = require("src.math.vector")
print("vector loaded")

local RenderSystem = t3.system("Render")
local renderQueue, renderQueueCell

function RenderSystem:init(component, entity)
    
end

function RenderSystem:update(component, entity)
    print('updawg')
end

function RenderSystem:updateSystem()
    
end

function RenderSystem.drawTexture(...)

end

function RenderSystem.createQueue()
    if not renderQueue then
       renderQueue, renderQueueCell = wf.queue()
    end
    return renderQueue, renderQueueCell, RenderSystem.drawTexture
end


local a = vector.new(3, 3)
local b = vector.new(1, 2)

print("a * b", a * b)
print("a * 5", a * 5)
print("5 * a", 5 * a)
print("a + b", a + b)
print("2 * b * 2", 2 * b * 2)

return RenderSystem