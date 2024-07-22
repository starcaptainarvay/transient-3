---@meta

--- Entity class representing individual entities in the ECS.
---@class Entity
local Entity = {}

--- Creates a new Entity instance.
---@return Entity The new Entity instance.
function Entity.new() end

--- System class representing systems in the ECS.
---@class System
---@field name string The name of the system.
---@field private _initialized boolean Indicates whether the system is initialized.
---@field private _entities table The entities managed by the system.
local System = {}

--- Creates a new System instance.
---@param name string The name of the system.
---@return System The new System instance.
function System.new(name) end

--- Adds an entity to the system.
---@param componentData table The component data associated with the entity.
---@return number The index at which the entity was added.
function System:addEntity(componentData) end

--- Removes an entity from the system.
---@param entity Entity The entity to remove.
---@return boolean Whether the entity was successfully removed.
function System:removeEntity(entity) end

--- Lists all entities managed by the system.
---@return table The list of entities.
function System:listEntities() end

--- Updates all entities managed by the system.
function System:updateEntities() end

--- Initializes a component in the system.
-- @abstract
-- This method should be overridden in implementation.
---@param componentData table The component data to initialize.
---@param entity Entity The entity associated with the component.
function System:init(componentData, entity) end

--- Updates a component in the system.
-- @abstract
-- This method should be overridden in implementation.
---@param componentData table The component data to update.
---@param entity Entity The entity associated with the component.
function System:update(componentData, entity) end

--- Initializes the system.
-- @abstract
-- This method should be overridden in implementation.
function System:initSystem() end

--- Updates the system.
-- @abstract
-- This method should be overridden in implementation.
function System:updateSystem() end

--- Converts the system to a string representation.
---@return string The string representation of the system.
function System:__tostring() end

--- Transient module for managing entities and systems in the ECS.
---@module 'transient'
local transient = {}

--- Creates or retrieves a system by name.
---@param name string The name of the system.
---@return System The system instance.
function transient.system(name) end

--- Adds a component to an entity.
---@param entity Entity The entity to add the component to.
---@param componentSystem string The name of the component system.
---@param componentData table The data for the component.
function transient.addComponent(entity, componentSystem, componentData) end

--- Removes a component from an entity.
---@param entity Entity The entity to remove the component from.
---@param componentData table The data for the component to remove.
---@return boolean Whether the component was successfully removed.
function transient.removeComponent(entity, componentData) end

--- Creates a new entity.
---@return Entity The new entity instance.
function transient.entity() end

--- Destroys an entity and cleans up its components.
---@param entity Entity The entity to destroy.
function transient.destroy(entity) end

--- Lists all entities.
---@return table The list of all entities.
function transient.listEntities() end

--- Starts the ECS, initializing all systems.
function transient.start() end

--- Updates all systems and entities.
function transient.update() end

return transient