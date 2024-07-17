local wf        = require("workflower")
local dict      = require("transient.util.dict")
local Entity    = require("transient.Entity")
local System    = require("transient.System")


local transient = wf.observable()
local _entities = {}
local _systems  = {}

function transient.system(name)
    if _systems[name] then return _systems[name] end
    _systems[name] = System.new(name)
    return _systems[name]
end

function transient.addComponent(entity, componentSystem, componentData)
    componentData.entity = entity
    componentData._component = componentSystem

    table.insert(_entities[entity], componentData)
    _systems[componentSystem]:addEntity(componentData)
end

function transient.removeComponent(entity, componentData)
    for index, component in pairs(_entities[entity]) do
        if component == componentData then
            table.remove(_entities[entity], index)
            break
        end
    end

    return _systems[componentData._component]:removeEntity(entity)
end

function transient.entity()
    local entity = Entity.new()
    _entities[entity] = {}
    return entity
end

local function clean_up_components(entity)
    local result = true
    while #_entities[entity] > 0 do
        local component = _entities[entity][1]
        result = result and transient.removeComponent(entity, component)
    end

    return result
end

function transient.destroy(entity)
    if clean_up_components(entity) then
        _entities[entity] = nil
    end
end

function transient.listEntities()
    return dict.keys(_entities)
end

function transient.start()
    for systemName, system in pairs(_systems) do
        if not system._initialized then
            system:initSystem()
            system._initialized = true
            print("Initialized system: ", systemName)
        end
    end
end

local entitiesUpdatedQueue, triggerEntitiesUpdatedEvent = wf.queue(nil)

local update_single_system = wf({
    "update-entities",
    {"queue-update", "dispatch-entities-updated"},
    ["queue-update"] = function(system)
        system:updateEntities()
        return nil, system.name, system:listEntities()
    end,
    ["dispatch-entities-updated"] = triggerEntitiesUpdatedEvent
})

entitiesUpdatedQueue:on("value", function(system_name, entity_list)
    transient:dispatch(string.format("entities-updated:%s", system_name), entity_list)
    entitiesUpdatedQueue:pop()
end)

local update_systems = wf({
    "update-entities",
    {"update-entities", "update-system"},
    ["update-entities"] = function(systems)
        for _, system in pairs(systems) do
            update_single_system(system)
        end
        return nil, systems
    end,
    ["update-system"] = function(systems)
        for _, system in pairs(systems) do
            system:updateSystem()
        end
        return nil, systems
    end
})

function transient.update()
    update_systems(_systems)
end

return transient