package.path = package.path .. ";./workflower/?.lua;./transient/?.lua"
function love.conf(e)
	e.console = true
end