local debug = require("workflower.debug")

local function graph_tostring(graph)
    local content = "\n"
    -- Helper functions to build the flowchart content
    local function format_node(node)
        return "[ " .. node .. " ]"
    end

    local function add_single(node, prefix)
        content = content .. prefix
        content = content .. debug.format(node, debug.formatting.presets.fg_blue, debug.formatting.presets.bold) .. "\n"
    end

    local function add_multiple(nodes, prefix)
        content = content .. prefix
        for _, node in pairs(nodes) do
            content = content .. string.rep("-", 5) .. " " .. debug.format(format_node(node), debug.formatting.presets.fg_blue, debug.formatting.presets.bold) .. " "
        end

        content = content .. "\n"
    end

    local function add_line(prefix)
        content = content .. prefix .. "\n"
    end

    add_single(graph[1], "\t")

    local midpoint  = math.floor(string.len(format_node(graph[1])) / 2)
    local spacing   = string.rep(" ", midpoint)
    local prefix    = "\t" .. spacing .. "|"

    add_line(prefix)

    for i=2, #graph do
        local node = graph[i]
        if type(node) == "string" then
            local single = format_node(node)
            local mpoint = math.floor(string.len(single) / 2)
            local adjust = math.max(midpoint - mpoint, 0)
            add_single(single, "\t" .. string.rep(" ", adjust))
        else add_multiple(node, prefix) end
        if i < #graph then
            add_line(prefix)
        end
    end


    return content .. "\n"
end

local function flower_tostring(self)
    local open = debug.format("Workflower {", debug.formatting.presets.fg_orange, debug.formatting.presets.bold)
    local close = debug.format("}", debug.formatting.presets.fg_orange, debug.formatting.presets.bold)
    local content = graph_tostring(self._graph)

    return "\n" .. open .. content .. close .. "\n"
end

return flower_tostring