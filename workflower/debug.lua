local debugger = {}

function debugger.error(id, flower, traceback)
    local cleaned_traceback = {}
    for line in string.gmatch(traceback, "[^\n]+") do
        if not string.match(line, "debug.lua") and not string.match(line, "workflower/init.lua") then
            table.insert(cleaned_traceback, line)
        end
    end

    local cleaned_traceback_str = table.concat(cleaned_traceback, "\n")
    error(string.format("Failure in Cell '%s':\n\t%s", id, cleaned_traceback_str))
    error(string.gsub(tostring(flower), "\n", "\n\t"))
end

local function create_debug_cell_container(fn)
    return {
        is_debug_cell_container = true,
        cell_fn = function(id, flower, ...)
            local results = { pcall(fn, ...) }
            local success = table.remove(results, 1)

            if not success then
                local err = results[1]
                -- using level 2 to skip the overhead of everything in debug.lua and init.lua, starting the traceback from the cell function
                debugger.error(id, flower, debug.traceback( err, 2))

                return 'error', unpack(results)
            end

            return unpack(results)
        end
    }
end

local function transform_debug_cell(debug_object, cell_id, flower)
    local cell_fn = debug_object.cell_fn

    return function(...)
        return cell_fn(cell_id, flower, ...)
    end
end

debugger.debug_cell_container   = create_debug_cell_container
debugger.debug_cell             = transform_debug_cell

return debugger