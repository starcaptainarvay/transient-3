package.path = package.path .. ";./workflower/?.lua"

local flower = require('workflower')

local renderQueue, renderQueueCell = flower.queue(nil)

flower({
    --...
    --{..., 'renderQueue'}
    renderQueue = renderQueue
})


local queue, cell = flower.queue(nil)

local render = flower({
    'print',
    {'print', 'queue'},
    print = function(...) return nil, ... end,
    queue = cell
})

renderQueueCell(1,2,3)
renderQueueCell(1,2,3)
renderQueueCell(1,2,3)

render(flower.bucket())
render(flower.bucket())
render(renderQueue)
render(render)
render(flower.bucket())
render(flower.bucket())

print()
print(queue)

-- function love.load()
--     print(table.concat({renderQueue, renderQueue, renderQueue}, ""))
-- end
-- function love.draw()
--     -- print(renderQueue)
--     while #renderQueue > 0 do
--         render(renderQueue:pop())
--     end
-- end

local o = flower.observable()
o:on("render", print)
o:dispatch("render", 1,2,3)
o:dispatch("render", 1,2,3)
o:dispatch("render", 2,34)
o:dispatch("render", 1,2,3)
o:dispatch("render", 532)