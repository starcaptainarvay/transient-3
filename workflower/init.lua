--- Workflower module implementation

local bucket        = require("workflower.bucket")
local pipe          = require("workflower.pipe")
local stringify     = require("workflower.stringify")
local debug         = require("workflower.debug")

local workflower    = {}

local reserved_indexes, get_instance_content = {
    [1] = true, -- entry point
    [2] = true -- directed graph, in the form of a node list
}, {}

function workflower.new(options, ...)
    local parents = {...}
    local flower = setmetatable({ _cells = {}, _entry = options[1], _graph = options[2] or {}, _events = {} }, get_instance_content)

    if #parents > 0 then
        for _, parent in pairs(parents) do
            for cell_id, cell_fn in pairs(parent._cells) do
                if not reserved_indexes[cell_id] then flower:cell(cell_id, cell_fn) end
            end
        end
    end

    if options then
        for cell_id, cell_fn in pairs(options) do
            if not reserved_indexes[cell_id] then flower:cell(cell_id, cell_fn) end
        end
    end

    return flower
end

function workflower.cell(flower, id, fn)
    if type(fn) == "table" then
        if fn.is_debug_cell_container then
            fn = debug.debug_cell(fn, id, flower)
        end
    end

    local function _pass(self, call_index, ...)
        local results = {fn(...)}
        local _next = table.remove(results, 1)

        return _next or self.flower._graph[call_index + 1], results
    end

    local cell = {
        flower = flower,
        id = id,
        fn = fn,
        pass = _pass
    }

    flower._cells[id] = cell

    return cell
end

function workflower.get_cell(flower, cell_id)
    return flower._cells[cell_id]
end

local get_instance_content_defaults = {
    cell = true,
    get_cell = true
}

local get_instance_content_raw = {
    _cells = true,
    _entry = true,
    _graph = true
}

function get_instance_content.__index(self, key)
    if get_instance_content_raw[key] then
        return rawget(self, key)
    elseif get_instance_content_defaults[key] then
        return workflower[key]
    end
end

function get_instance_content.__call(self, ...)
    return workflower.execute(self:get_cell(self._entry), 1, ...)
end

function get_instance_content.__tostring(self)
    return stringify(self)
end

function workflower.execute(cell, call_index, ...)
    local _next, results = cell:pass(call_index, ...)
    local _next_cell = workflower.get_cell(cell.flower, _next)

    if _next == "error" then
        local err_string = results[1]
        if not _next_cell then -- no error handler
            error(err_string, 2)
        end
    end

    if _next_cell then
        return workflower.execute(_next_cell, call_index + 1, unpack(results))
    end

    return unpack(results)
end

function workflower.bucket(_next)
    return bucket.new(_next)
end

function workflower.pipe(_next, fn)
    return pipe.new(_next, fn)
end

function workflower.debug(fn)
    return debug.debug_cell_container(fn)
end

workflower.debugging = {
    formatting = debug.formatting,
    format = debug.format
}

local function get_lib_content(self, key)
    return workflower[key]
end

local __meta = {
    __call = function(_, ...) return workflower.new(...) end,
    __index = get_lib_content
}

return setmetatable({}, __meta)