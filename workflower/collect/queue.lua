local debug = require("workflower.debug")
local event = require("workflower.event")

local queue = {}
queue.__index = queue

function queue.new(_next)
    local _queue = setmetatable({ list = {}, _events = {} }, queue)

    local function cell_fn(...)
        _queue:push({...})

        return _next, ...
    end

    return _queue, cell_fn
end

function queue.size(self)
    return #self.list
end

function queue.get(self, i)
    return unpack(self.list[i])
end

function queue.pop(self)
    return unpack(table.remove(self.list, 1))
end

function queue.push(self, item)
    table.insert(self.list, item)
    self:dispatch("value", unpack(item))
end

function queue.__tostring(self)
    local open, close = debug.format("Queue {", debug.formatting.presets.fg_green, debug.formatting.presets.bold),
        debug.format("}", debug.formatting.presets.fg_green, debug.formatting.presets.bold)

    local content = "\n"
    for i = 1, self:size() do
        content = content .. debug.format("\t(  ", debug.formatting.presets.fg_blue)
        content = content .. debug.format(
            table.concat(self.list[i], ",\t\t"),
            debug.formatting.presets.fg_white,
            debug.formatting.presets.bold)
        content = content .. debug.format("  )", debug.formatting.presets.fg_blue)

        if i < self:size() then
            content = content .. ",\n"
        end
    end

    content = content .. "\n"

    return "\n" .. open .. content .. close .. "\n"
end

queue.on           = event.observable.on
queue.once         = event.observable.once
queue.dispatch     = event.observable.dispatch

return queue