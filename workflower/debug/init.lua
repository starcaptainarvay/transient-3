local debugger = {}

local presets = require("debug.formatting_presets")

debugger.formatting = {}
debugger.formatting.presets = {
    reset = 'reset',
    bold = 'bold',
    dim = 'dim',
    italic = 'italic',
    underline = 'underline',
    blink = 'blink',
    reverse = 'reverse',
    hidden = 'hidden',
    strikethrough = 'strikethrough',
    fg_black = 'fg_black',
    fg_red = 'fg_red',
    fg_bright_red = 'fg_bright_red',
    fg_orange = 'fg_orange',
    fg_green = 'fg_green',
    fg_yellow = 'fg_yellow',
    fg_blue = 'fg_blue',
    fg_magenta = 'fg_magenta',
    fg_cyan = 'fg_cyan',
    fg_white = 'fg_white',
    bg_black = 'bg_black',
    bg_red = 'bg_red',
    bg_bright_red = 'bg_bright_red',
    bg_orange = 'bg_orange',
    bg_green = 'bg_green',
    bg_yellow = 'bg_yellow',
    bg_blue = 'bg_blue',
    bg_magenta = 'bg_magenta',
    bg_cyan = 'bg_cyan',
    bg_white = 'bg_white'
}

local function _format(formatted_string, format_table)
    for _, formatting in ipairs(format_table) do
        local code = formatting
        if code then
            formatted_string = code .. formatted_string
        end
    end
    -- Reset formatting at the end
    formatted_string = formatted_string .. presets.reset
    return formatted_string
end

function debugger.format(str, ...)
    local formatting = {...}
    for i=1, #formatting do
        formatting[i] = presets[formatting[i]]
    end
    return _format(str, formatting)
end

function debugger.error_string(id, flower, traceback)
    local cleaned_traceback = {}
    local lineno = 1
    for line in string.gmatch(traceback, "[^\n]+") do
        if not string.match(line, "debug.lua") and not string.match(line, "workflower/init.lua") then
            if lineno < 4 then
                table.insert(cleaned_traceback, _format(line, {presets.fg_red}))
            else
                table.insert(cleaned_traceback, _format(line, {presets.fg_red, presets.dim}))
            end
            lineno = lineno + 1
        end
    end

    local cleaned_traceback_str = table.concat(cleaned_traceback, "\n")
    local cell_name = _format(id, {presets.fg_white, presets.bold})
    local failure_in_cell = _format("Failure", {presets.bold, presets.fg_bright_red, presets.bg_black}) .. _format(" in Cell '", {presets.fg_bright_red})
    local leading_message = failure_in_cell .. cell_name .. _format("':", {presets.fg_bright_red})
    local err_string = string.format("\n%s\n\t%s", _format(leading_message, {presets.fg_bright_red}), cleaned_traceback_str)

    return err_string
end

function debugger.warn(s, ...)
    print(
        _format(
            ("Warning: %s"):format(_format(s, {presets.underline})), 
            {presets.bold, presets.fg_yellow}), 
        _format(
            table.concat({...}, " "),
             {presets.bg_black, presets.fg_yellow}
            ), 
        "\n"
    )
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
                local err_str = debugger.error_string(
                    id, flower, 
                    debug.traceback( err, 2)
                )

                return 'error', err_str, results
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