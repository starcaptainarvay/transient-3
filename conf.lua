package.path = package.path .. ";./modules/workflower/?.lua;./modules/transient/?.lua"
function love.conf(e)
	e.console = true
end