local t3 = require("transient")
local wf = require("workflower")

local EmissionManager = t3.system("Emission")
local activeComponents = {}

local emissionsBucket, setEmissions = wf.bucket(nil, 0)

function EmissionManager:sumTotal()
    return emissionsBucket:get()
end

-- function EmissionManager:initSystem()
--     -- emissionsBucket:on("value", function(data) if data > 0 then print("TOTAL emissions", data) end end)
-- end

function EmissionManager:init(component, entity)
    component.created = love.timer.getTime()
    component.now = love.timer.getTime()

    component.expiry = component.expiry or 5
    component.emissionRate = component.emissionRate or 0

    -- print("Made new emissionManager")

    activeComponents[component.created] = component
end

function EmissionManager:update(component, entity)
    component.now = love.timer.getTime()

    -- print("update emission",component.emissionRate,component.expiry, component.created)

    if (component.now - component.created) >= component.expiry then
        t3.removeComponent(entity, component)
    end
end

function EmissionManager:destroy(component, entity)
    activeComponents[component.created] = nil
end

function EmissionManager:updateSystem()
    local total = 0

    for _, component in pairs(activeComponents) do
        if component.emissionRate then
            total = total + component.emissionRate
        end
    end

    setEmissions(total/2)
end

return EmissionManager