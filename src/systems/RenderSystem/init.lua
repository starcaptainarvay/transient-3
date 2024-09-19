local wf = require("workflower")
local t3 = require("transient")
local Shader = require("RenderSystem.shader")
local Vector = require("src.math.Vector")

local RenderSystem = t3.system("Render")

local renderQueue, renderQueueCell = wf.queue()

function RenderSystem:init(component, entity)
    
end

function RenderSystem:update(component, entity)
    
end

function RenderSystem:updateSystem()
    
end

function RenderSystem.drawTexture()

end

function RenderSystem.createQueue()
    return renderQueue, renderQueueCell, RenderSystem.drawTexture
end


local a = Vector.new(3, 3)
local b = Vector.new(1, 2)

print("a * b", a * b)
print("a * 5", a * 5)
print("5 * a", 5 * a)
print("a + b", a + b)
print("2 * b * 2", 2 * b * 2)

return RenderSystem