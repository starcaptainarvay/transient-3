local function flower_tostring(self)
    local out = "Flower {"

    if not self._graph or #self._graph < 1 then
        for k, _ in pairs(self._cells) do
            out = out .. "\n\t"

            if k ~= self._entry then
                out = out .. " -> "
            end

            out = out .. "Cell [" .. k .. "]"
        end
    else
        for i, v in pairs(self._graph) do
            out = out .. "\n\t"

            if i > 1 then
                out = out .. " -> "
            end

            if type(v) == "string" then
                out = out .. "Cell [" .. v .. "]"
            elseif type(v) == "table" then
                out = out .. "Cells ["
                for n = 1, #v do
                    out = out .. v[n]
                    if n < #v then out = out .. ", " end
                end
                out = out .. "]"
            end
        end
    end

    out = out .. "\n}"
    return out
end

return flower_tostring