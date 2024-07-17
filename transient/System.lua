local System    = {}
System.__index  = System

function System.new(name)
    return setmetatable({
        name = name,
        _initialized = false,
        _entities = {}
    }, System)
end

function System:addEntity(componentData)
    self:init(componentData, componentData.entity)
    return table.insert(self._entities, componentData)
end

function System:removeEntity(entity)
    for index, component in pairs(self._entities) do
        if component.entity == entity then
            return table.remove(self._entities, index)
        end
    end
    return false
end

function System:listEntities()
    return self._entities
end

function System:updateEntities()
    for _, component in pairs(self._entities) do
        self:update(component, component.entity)
    end
end

function System:init(componentData, entity) end
function System:update(componentData, entity) end
function System:initSystem() end
function System:updateSystem() end

function System.__tostring(self)
    return self.name .."System: " .. #(self._entities) .. " entities"
end

return System